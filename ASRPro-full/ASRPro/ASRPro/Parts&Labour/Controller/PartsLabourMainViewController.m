//
//  PartsLabourMainViewController.m
//  ASRPro
//
//  Created by Kalyani on 05/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "PartsLabourMainViewController.h"

#import "AddPartViewController.h"
#import "EditPartViewController.h"

@interface PartsLabourMainViewController ()

@end

@implementation PartsLabourMainViewController
@synthesize mDoneButton_;
@synthesize mLookUpButton_;
@synthesize mPartsScrollView_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

   //    [self animate];

    }
    return self;
}


//- (void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
//    self.view.superview.bounds = CGRectMake(0, 0, 1024,748);
//}
- (void)animate {
  //  [UIView setAnimationDidStopSelector:@selector(popStep1Complete)];
//    [UIView commitAnimations];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self initTheViews];
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    
    [self loadLookupView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setFontToViews{
}

-(void)initTheViews{
    int ypos=0;
    for(int i=0;i<[mAppDelegate_.mPartLabourDataGetter_.mAddedPartsArray_ count];i++){
        int height=([[[mAppDelegate_.mPartLabourDataGetter_.mAddedPartsArray_ objectAtIndex:i] objectForKey:@"Parts"] count]>0)?80+([[[mAppDelegate_.mPartLabourDataGetter_.mAddedPartsArray_ objectAtIndex:i] objectForKey:@"Parts"] count]*40):180;
        PartsLaborMainSubview  *lPartsLaborMainSubview = [[PartsLaborMainSubview alloc] initWithFrame:CGRectMake (0, ypos, 1024, height)];
        [lPartsLaborMainSubview setMPartsDictionary_:[[mAppDelegate_.mPartLabourDataGetter_.mAddedPartsArray_ objectAtIndex:i]mutableCopy]];
        [lPartsLaborMainSubview initTheVews];
        lPartsLaborMainSubview.tag=i;
        [mPartsScrollView_ addSubview:lPartsLaborMainSubview];
        
        ypos+=lPartsLaborMainSubview.frame.size.height+10;
        }
    [self.mPartsScrollView_ setContentSize:CGSizeMake(1024, ypos+10)];
}

-(void)reloadPartsView{
    [self.mPartsScrollView_.subviews enumerateObjectsUsingBlock:^(id lView, NSUInteger index, BOOL *stop) {
        if ([lView isKindOfClass:[PartsLaborMainSubview class]]) {
            [lView removeFromSuperview];
        }}];
    [self initTheViews];
}

-(void)loadLookupView{
    PartsLabourLookupViewController *lPartsLabourLookupViewController = [[PartsLabourLookupViewController alloc] initWithNibName:@"PartsLabourLookupViewController" bundle:nil];
    [mAppDelegate_.mPartLabourDataGetter_ setMPartsLabourLookupViewController_ :lPartsLabourLookupViewController];
}

- (IBAction)DoneButtonAction:(id)sender {
    [self.view removeFromSuperview];
    if(mAppDelegate_.mModelForPartsSupportEngine_.mGetPartsReference_==INPROCESSOPARTSVIEWCONTROLLER){
//        [mAppDelegate_.mServiceDataGetter_ setMSelectedServicesArray_:mAppDelegate_.mPartLabourDataGetter_.mAddedPartsArray_];
//        [mAppDelegate_.mServiceDataGetter_ filterLines:mAppDelegate_.mServiceDataGetter_.mSelectedServicesArray_];
//        [mAppDelegate_.mServicesViewController_ calculateAllTotals];
//        [mAppDelegate_.mServicesViewController_.mRecommendedServicesTableViewController_.tableView reloadData];
//        [mAppDelegate_.mServicesViewController_.mServicesScheduleTableViewController_.tableView reloadData];

     mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_=SERVICESVIEWCONTROLLER;
      [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForGetROLines:mAppDelegate_.mPartLabourDataGetter_.mRONumber_];
    }
    else{
//        [mAppDelegate_.mOpenRoServiceDataGetter_ setMSelectedServicesArray_:mAppDelegate_.mPartLabourDataGetter_.mAddedPartsArray_];
//        [mAppDelegate_.mOpenRoServiceDataGetter_ filterLines:mAppDelegate_.mOpenRoServiceDataGetter_.mSelectedServicesArray_];
//
//        [mAppDelegate_.mSearchViewController_.mOpenROServicesTableViewController_.tableView reloadData];
        mAppDelegate_.mModelforOpenROSupportEngine_.mGetServiceReference_=OPENROSERVICESVIEWCONTROLLER;
        [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForGetROLines:mAppDelegate_.mPartLabourDataGetter_.mRONumber_];

    }
}

- (IBAction)PartsLookupAction:(id)sender {
    [self loadLookupView];
    [mAppDelegate_.mPartLabourDataGetter_.mPartsLabourLookupViewController_.view setFrame:CGRectMake(0, 0, 1024, 748)];
    [self.view addSubview:mAppDelegate_.mPartLabourDataGetter_.mPartsLabourLookupViewController_.view];

}

-(void)ShowAddPartsPopUp{
    AddPartViewController *lAddPartViewController = [[AddPartViewController alloc] initWithNibName:@"AddPartViewController" bundle:nil];
    lAddPartViewController.modalPresentationStyle=UIModalPresentationPageSheet;
    lAddPartViewController.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    [self presentViewController:lAddPartViewController animated:YES completion:nil];
}

-(void)ShowEditPartsPopUp{
    EditPartViewController *lEditPartViewController = [[EditPartViewController alloc] initWithNibName:@"EditPartViewController" bundle:nil];
        lEditPartViewController.modalPresentationStyle=UIModalPresentationPageSheet;
    lEditPartViewController.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    [self presentViewController:lEditPartViewController animated:YES completion:nil];
}

-(void)resizeTheViews{
    int tag=mAppDelegate_.mPartLabourDataGetter_.mPartsLaborMainSubview.tag;
    int height=([[mAppDelegate_.mPartLabourDataGetter_.mPartsLaborMainSubview.mPartsDictionary_ objectForKey:@"Parts" ] count]>0)?80+([[mAppDelegate_.mPartLabourDataGetter_.mPartsLaborMainSubview.mPartsDictionary_ objectForKey:@"Parts" ] count]*40):180;
    int yPos=([[mAppDelegate_.mPartLabourDataGetter_.mPartsLaborMainSubview.mPartsDictionary_ objectForKey:@"Parts" ] count]>0)?-40:60;
    [self.mPartsScrollView_.subviews enumerateObjectsUsingBlock:^(id lView, NSUInteger index, BOOL *stop) {
        if ([lView isKindOfClass:[PartsLaborMainSubview class]]) {
            PartsLaborMainSubview* lTempView=(PartsLaborMainSubview*)lView;
            if(lTempView.tag==tag){
                CGRect  frame= lTempView.frame;
                frame.size.height=height;
                [lTempView setFrame:frame];
            }
            else if(lTempView.tag>tag){
                CGRect  frame= lTempView.frame;
                frame.origin.y+=yPos;
                [lTempView setFrame:frame];
            }
        }}];
    CGSize tempFrame=    self.mPartsScrollView_.contentSize;
    tempFrame.height+=yPos;
    self.mPartsScrollView_.contentSize=tempFrame;
}

@end
