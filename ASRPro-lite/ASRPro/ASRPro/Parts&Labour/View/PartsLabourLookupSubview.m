//
//  PartsLabourLookupSubview.m
//  ASRPro
//
//  Created by Kalyani on 10/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "PartsLabourLookupSubview.h"

@implementation PartsLabourLookupSubview
@synthesize delegate;
@synthesize mHeaderButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)loadPartsAndLabour:(UIView*)aTempView
                 tempDict:(NSMutableDictionary*)aTempDict{
    int ypos=30;
    NSMutableArray*ltempArray=[aTempDict objectForKey:@"RepairOrderLines"];
    
    for(int i=0;i<[ltempArray count];i++){
        
        UILabel* lCategoryLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, ypos, 660, 25)];
        [lCategoryLabel setTextColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
        [lCategoryLabel setFont:[UIFont regularFontOfSize:14.0 fontKey:kFontNameHelveticaNeueKey]];
        [lCategoryLabel setText:[self getServiceName:[[[aTempDict objectForKey:@"RepairOrderLines"] objectAtIndex:i] objectForKey:KID]]];
        [aTempView addSubview:lCategoryLabel];
        
        UIView* lCategoryView=[[UILabel alloc]initWithFrame:CGRectMake(10, ypos+26, 650, 1)];
        [lCategoryView setBackgroundColor:[UIColor colorWithRed:(153.0/255.0) green:(153.0/255.0) blue:(153.0/255.0) alpha:1.0]];
        [aTempView addSubview:lCategoryView];
        ypos+=30;
        NSMutableArray*ltempArray1=[[[aTempDict objectForKey:@"RepairOrderLines"] objectAtIndex:i] objectForKey:@"PartItems"];
        
        for(int j=0;j<[ltempArray1 count];j++){
            if(j==0){
                UILabel* lPartsLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, ypos, 410, 25)];
                [lPartsLabel setTextColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
                [lPartsLabel setText:@"Parts"];
                [lPartsLabel setFont:[UIFont regularFontOfSize:14.0 fontKey:kFontNameHelveticaNeueKey]];
                [aTempView addSubview:lPartsLabel];
                ypos+=30;
            }
            PartsLaborSubview* lPartsLaborSubview= [[PartsLaborSubview alloc] initWithFrame:CGRectMake(20, ypos, 620, 40)];
            [lPartsLaborSubview setMLineID_:[[[aTempDict objectForKey:@"RepairOrderLines"] objectAtIndex:i] objectForKey:@"ID"]];
            [lPartsLaborSubview setMItemDict_:[[[[aTempDict objectForKey:@"RepairOrderLines"] objectAtIndex:i] objectForKey:@"PartItems"]objectAtIndex:j]];
            [lPartsLaborSubview initThePartView];
            [aTempView addSubview:lPartsLaborSubview];
            ypos+=40;
            
        }
        NSMutableArray*ltempArray2= [[[aTempDict objectForKey:@"RepairOrderLines"] objectAtIndex:i] objectForKey:@"LaborItems"];
        for(int k=0;k<[ltempArray2 count];k++)
        {
            if(k==0){
                UILabel* lLaborLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, ypos, 410, 25)];
                [lLaborLabel setTextColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
                [lLaborLabel setFont:[UIFont regularFontOfSize:14.0 fontKey:kFontNameHelveticaNeueKey]];
                [lLaborLabel setText:@"Labor"];
                [aTempView addSubview:lLaborLabel];
                ypos+=30;
            }
            PartsLaborSubview* lPartsLaborSubview= [[PartsLaborSubview alloc] initWithFrame:CGRectMake(20, ypos, 620, 40)];
            [lPartsLaborSubview setMLineID_:[[[aTempDict objectForKey:@"RepairOrderLines"] objectAtIndex:i] objectForKey:@"ID"]];
            [lPartsLaborSubview setMItemDict_:[[[[aTempDict objectForKey:@"RepairOrderLines"] objectAtIndex:i] objectForKey:@"LaborItems"]objectAtIndex:k]];
            [lPartsLaborSubview initTheLaborView];
            [aTempView addSubview:lPartsLaborSubview];
            ypos+=40;
        }
    }
    rowheight=ypos+30;
}


-(void)setPartsLabourView :(NSMutableDictionary*)aTempDict{
    [self.layer setBorderColor:[UIColor colorWithRed:(19.0/255.0) green:(124.0/255.0) blue:(252.0/255.0) alpha:1.0].CGColor];
    [self setClipsToBounds:YES];
    [self.layer setBorderWidth:2.0];
    UIView* mHeadingView_=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 660, 30)];
    mHeaderButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 660, 30)];
    [[GenericFiles genericFiles] createUIButtonInstance:mHeaderButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];
     [[GenericFiles genericFiles] createUIButtonInstance:mHeaderButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];
    [mHeaderButton addTarget:self action:@selector(isButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [mHeadingView_ addSubview:mHeaderButton];
    [mHeadingView_ setBackgroundColor:[UIColor colorWithRed:(19.0/255.0) green:(124.0/255.0) blue:(252.0/255.0) alpha:1.0]];
    [self addSubview:mHeadingView_];
    UILabel* mHeadingLabel_=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 660, 30)];
    NSString* lTempLabelStr=[NSString stringWithFormat:@"%@",([aTempDict objectForKey:@"Description"]!=nil)?[aTempDict objectForKey:@"Description"]:[aTempDict objectForKey:@"CarID"]];
    if([[mAppDelegate_.mPartLabourDataGetter_.mPartsLookupDict_ objectAtIndex:0] objectForKey:@"CarID"])
    [[GenericFiles genericFiles]createUILabelWithInstance:mHeadingLabel_ labelTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] labelTitle:lTempLabelStr labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [self addSubview:mHeadingLabel_];

    [self loadPartsAndLabour:self tempDict:aTempDict ];
    
}

-(NSString*)getServiceName:(NSString*)LineID{
    for(int i=0;i<[mAppDelegate_.mPartLabourDataGetter_.mAddedPartsArray_  count];i++){
        if([[[mAppDelegate_.mPartLabourDataGetter_.mAddedPartsArray_ objectAtIndex:i]objectForKey:KID] intValue]==[LineID intValue])
            return [NSString stringWithFormat:@"%@",[[mAppDelegate_.mPartLabourDataGetter_.mAddedPartsArray_ objectAtIndex:i]objectForKey:KSERVICENAME]];
    }
    return @"";
}

-(void)isButtonClicked:(UIButton*)sender{
    if([self.delegate respondsToSelector:@selector(changeHeight:Tag:selected:)]) {
        [self.delegate changeHeight:sender.selected?30:rowheight Tag:self.tag selected:sender.selected];
    }
}

@end
