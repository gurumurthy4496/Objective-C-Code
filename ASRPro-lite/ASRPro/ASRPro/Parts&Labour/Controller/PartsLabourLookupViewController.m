//
//  PartsLabourLookupViewController.m
//  ASRPro
//
//  Created by Kalyani on 05/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "PartsLabourLookupViewController.h"
@implementation PartsLabourLookupViewController

@synthesize mHeadingLabel_;
@synthesize mCancelButton_;
@synthesize mSaveButton_;
@synthesize mGrayActivityIndicator;
@synthesize mPartsScrollView;
@synthesize mTempView_;
@synthesize mPartsLookupView_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    selectedindex=0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.mPartsLookupView_ setFrame:CGRectMake(1024, 0, 680, 748)];
    [self.mPartsLookupView_ setFrame:CGRectMake(1024-680, 0, 680, 748)];
    [UIView commitAnimations];

    [self initTheViews];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTheViews{
    int ypos=10;
    [mSaveButton_ setTitle:@"Save" forState:UIControlStateNormal];
    [mCancelButton_ setTitle:@"Cancel" forState:UIControlStateNormal];
    [mHeadingLabel_ setText:@"Look up Parts & Labor"];
    
    if(mAppDelegate_.mPartLabourDataGetter_->isSucess){
        if([mAppDelegate_.mPartLabourDataGetter_.mPartsLookupDict_ count]>0){
            if([[[mAppDelegate_.mPartLabourDataGetter_.mPartsLookupDict_ objectAtIndex:0] objectForKey:@"RepairOrderLines"] count]>0){
        for(int i=0;i<[mAppDelegate_.mPartLabourDataGetter_.mPartsLookupDict_ count];i++){
            PartsLabourLookupSubview* lPartsLabourLookupSubview_=[[PartsLabourLookupSubview alloc] initWithFrame:CGRectMake(10, ypos, 660, 30)];
            [lPartsLabourLookupSubview_ setDelegate:self];
            [lPartsLabourLookupSubview_ setTag:i];
            [lPartsLabourLookupSubview_ setPartsLabourView:[mAppDelegate_.mPartLabourDataGetter_.mPartsLookupDict_ objectAtIndex:i]];
            [mPartsScrollView addSubview:lPartsLabourLookupSubview_];
            ypos+=40;
        }
                [mPartsScrollView setContentSize:CGSizeMake(680, ypos)];
    
        }
            else{
                [self addNoPartsFound];
                
            }

        }
        else{
            [self addNoPartsFound];

        }
    }
    else{
        [self addNoPartsFound];
        
    }
}

-(void)addNoPartsFound{
    UILabel* lNoPartsFound=[[UILabel alloc]initWithFrame:CGRectMake(20, 50, 710, 25)];
    [lNoPartsFound setTextAlignment:NSTextAlignmentCenter];
    [lNoPartsFound setTextColor:[UIColor blackColor]];
    [lNoPartsFound setFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey]];
    [lNoPartsFound setText:@"No parts and labor information found"];
    [mPartsScrollView addSubview:lNoPartsFound];
    
}

- (IBAction)SaveButtonAction:(id)sender {
    [self.view removeFromSuperview];
    NSMutableArray * mPartsArray=[NSMutableArray new];
    NSMutableArray * mLaborArray=[NSMutableArray new];
    [self.mPartsScrollView.subviews enumerateObjectsUsingBlock:^(id lView, NSUInteger index, BOOL *stop) {
        if ([lView isKindOfClass:[PartsLabourLookupSubview class]]) {
    [((PartsLabourLookupSubview*)lView).subviews enumerateObjectsUsingBlock:^(id lObjectView, NSUInteger index, BOOL *stop) {
        if ([lObjectView isKindOfClass:[PartsLaborSubview class]]) {
            PartsLaborSubview* lTempView=(PartsLaborSubview*)lObjectView;
            if((lTempView->isParts)){
                if([lTempView getPartsDictionary]!=nil)
                 [mPartsArray addObject:[lTempView getPartsDictionary]];
            }
            else{
                if([lTempView getLaborDictionary]!=nil)
                [mLaborArray addObject:[lTempView getLaborDictionary]];
            }

    }
    }];
        }
    }];
 
    NSDictionary* mRequestDict=[NSDictionary dictionaryWithObjectsAndKeys:mAppDelegate_.mModelForSplashScreen_.mEmployeeID_,@"UserID",mPartsArray,@"Data",mLaborArray,@"Labor" , nil];
    [mAppDelegate_.mModelForPartsSupportEngine_ requestToAddLookup:mAppDelegate_.mPartLabourDataGetter_.mRONumber_ RequestDict:[mRequestDict mutableCopy]];
   }
- (IBAction)CancelButtonAction_:(id)sender {
    [self.view removeFromSuperview];
    
}

-(void)resetAllFields{
    [self.mPartsScrollView.subviews enumerateObjectsUsingBlock:^(id lView, NSUInteger index, BOOL *stop) {
        if ([lView isKindOfClass:[PartsLabourLookupSubview class]]) {
            [((PartsLabourLookupSubview*)lView).subviews enumerateObjectsUsingBlock:^(id lObjectView, NSUInteger index, BOOL *stop) {
                if ([lObjectView isKindOfClass:[PartsLaborSubview class]]) {
                    PartsLaborSubview* lTempView=(PartsLaborSubview*)lObjectView;
                    [lTempView.mTextFld setText:@"0"];
                }
            }];
        }
    }];
    

}

-(void)changeHeight:(int)height Tag:(int)aTag selected:(BOOL)isselected{
    rowheight=0;
    [self.mPartsScrollView.subviews enumerateObjectsUsingBlock:^(id lView, NSUInteger index, BOOL *stop) {
        if ([lView isKindOfClass:[PartsLabourLookupSubview class]]) {
            PartsLabourLookupSubview* lTempView=(PartsLabourLookupSubview*)lView;

            if(lTempView.tag==aTag){
                [lTempView.mHeaderButton setSelected:!isselected];
                CGRect frame=lTempView.frame;
                frame.size.height=height;
                frame.origin.y=40*aTag;
                [lTempView setFrame:frame];
                rowheight+=height;
            }
        else{
            [lTempView.mHeaderButton setSelected:FALSE];
            CGRect frame=lTempView.frame;
            frame.size.height=30;
            frame.origin.y=(aTag>lTempView.tag)?40*lTempView.tag:(40*lTempView.tag)+height-30;
            [lTempView setFrame:frame];
            rowheight+=40;
        }
        }
    }];
    
    [mPartsScrollView setContentSize:CGSizeMake(680, rowheight+20)];
}



@end