//
//  PartsLaborMainSubview.m
//  ASRPro
//
//  Created by Kalyani on 06/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "PartsLaborMainSubview.h"
#import "PartsLabourCellViewCell.h"

@implementation PartsLaborMainSubview
@synthesize mAddButton_;
@synthesize mPartsDictionary_;
@synthesize mPartsTableView_;
@synthesize mTitleImage_;
@synthesize mTitleLabel_;
@synthesize mType_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

#pragma mark -  ********************** Generic methods**************************
//--------------------------------------------------- ************** ------------------------------------------------------
//                                                  *** Method to init views  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)initTheVews{
    self.mAddButton_=[[UIButton alloc] initWithFrame:CGRectMake(960, 5, 54, 17)];
    if(  [[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_->mselectedSegment_==3)
        [self.mAddButton_ setHidden:([[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Technician"]||([[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Advisor"]&&![[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] isEnableGBB:[self.mPartsDictionary_ objectForKey:KSGID]]))?TRUE:FALSE];
    [[GenericFiles genericFiles] createUIButtonInstance:self.mAddButton_ buttonTitle:kADD_TITLE_PARTS buttonTitleColor:kTEXTCOLORPARTS buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kADD_IMAGE_PARTS];
    [self.mAddButton_ addTarget:self action:@selector(addPartsAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.mAddButton_];
    self.mTitleLabel_=[[UILabel alloc] initWithFrame:CGRectMake(40, 5, 800, 20)];
    self.mTitleImage_=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 22, 17)];
    self.mPartsTableView_=[[UITableView alloc] initWithFrame:CGRectMake(10, 40, 1004, ([[self.mPartsDictionary_ objectForKey:KPARTS] count]>0)?([[self.mPartsDictionary_ objectForKey:KPARTS] count]*40+40):140)];
    [self.mPartsTableView_ setDataSource:self];
    [self.mPartsTableView_ setDelegate:self];
    [self.mPartsTableView_.layer setBorderWidth:2.0];
    if([[self.mPartsDictionary_ objectForKey:KAPPROVED] boolValue])
        self.mType_=APPROVESTATE;
    else if([[self.mPartsDictionary_ objectForKey:KDECLINED] boolValue])
        self.mType_=DECLINESTATE;
    else
        self.mType_=UNDECIDEDSTATE;
    if(self.mType_==APPROVESTATE){
        [[GenericFiles genericFiles] createUILabelWithInstance:self.mTitleLabel_ labelTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[self.mPartsDictionary_ objectForKey:KSERVICENAME]!=nil?[self.mPartsDictionary_ objectForKey:KSERVICENAME]:@""] labelTextColor:[UIColor colorWithRed:(41.0/255.0) green:(174.0/255.0) blue:(97.0/255.0) alpha:1.0] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
        [self.mTitleImage_ setImage:kAPPROVE_IMAGE_RECOMMENDED];
        [self.mPartsTableView_.layer setBorderColor:kAPPROVECOLOR.CGColor];
    }else  if(self.mType_==DECLINESTATE){
        [[GenericFiles genericFiles] createUILabelWithInstance:self.mTitleLabel_ labelTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[self.mPartsDictionary_ objectForKey:KSERVICENAME]!=nil?[self.mPartsDictionary_ objectForKey:KSERVICENAME]:@""] labelTextColor:[UIColor colorWithRed:(251.0/255.0) green:(62.0/255.0) blue:(56.0/255.0) alpha:1.0] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
        [self.mTitleImage_ setImage:kUNAPPROVE_IMAGE_RECOMMENDED];
        [self.mPartsTableView_.layer setBorderColor:kDECLINECOLOR.CGColor];
    }
    else  if(self.mType_==UNDECIDEDSTATE){
        [[GenericFiles genericFiles] createUILabelWithInstance:self.mTitleLabel_ labelTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[self.mPartsDictionary_ objectForKey:KSERVICENAME]!=nil?[self.mPartsDictionary_ objectForKey:KSERVICENAME]:@""] labelTextColor:[UIColor colorWithRed:(19.0/255.0) green:(124.0/255.0) blue:(252.0/255.0) alpha:1.0] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
        [self.mTitleImage_ setImage:kUNDECIDEDTHUMBIMAGE];
        [self.mPartsTableView_.layer setBorderColor:kUNDECIDEDCOLOR.CGColor];
    }
    [self.mPartsTableView_ setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self addSubview:self.mTitleImage_];
    [self addSubview:self.mTitleLabel_];
    [self addSubview:self.mPartsTableView_];
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                      *** Method to reload table data on put response  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)reloadTableData:(NSMutableDictionary*)mDict{
    NSMutableArray* lTempArray=[[self.mPartsDictionary_ objectForKey:KPARTS]mutableCopy];
    [lTempArray replaceObjectAtIndex:index withObject:mDict];
    [self.mPartsDictionary_ setObject:lTempArray forKey:KPARTS];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mPartLabourDataGetter_] mAddedPartsArray_ ] replaceObjectAtIndex:self.tag withObject:self.mPartsDictionary_];
    [self.mPartsTableView_ reloadData];
    [self.mPartsTableView_ setFrame:CGRectMake(10, 40, 1004,([[self.mPartsDictionary_ objectForKey:KPARTS] count]>0)?([[self.mPartsDictionary_ objectForKey:KPARTS] count]*40+40):140) ];
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                      *** Method to delete part without reloading the view ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)deleteIndex{
    NSMutableArray* lTempArray=[[self.mPartsDictionary_ objectForKey:KPARTS]mutableCopy];
    [lTempArray removeObjectAtIndex:index];
    [self.mPartsDictionary_ setObject:lTempArray forKey:KPARTS];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mPartLabourDataGetter_] mAddedPartsArray_ ] replaceObjectAtIndex:self.tag withObject:self.mPartsDictionary_];
    [self.mPartsTableView_ reloadData];
    [self.mPartsTableView_ setFrame:CGRectMake(10, 40, 1004,([[self.mPartsDictionary_ objectForKey:KPARTS] count]>0)?([[self.mPartsDictionary_ objectForKey:KPARTS] count]*40+40):140) ];
}

#pragma mark -  ********************** Button Actions**************************

//--------------------------------------------------- ************** ------------------------------------------------------
//                                            *** Button action for Add Button  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)addPartsAction:(UIButton*)aTempButton{
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mPartLabourDataGetter_] mModelForCurrentPart_] setMLineID_:[self.mPartsDictionary_ objectForKey:KID]!=nil?[self.mPartsDictionary_ objectForKey:KID]:@""];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mPartLabourDataGetter_] mPartsLabourMainViewController_] ShowAddPartsPopUp];
}

#pragma mark -  ********************** TableView - Data Source**************************

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if([[self.mPartsDictionary_ objectForKey:KPARTS] count]>0)
        return [[self.mPartsDictionary_ objectForKey:KPARTS] count];
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PartsLabourCellViewCell";
    PartsLabourCellViewCell* cell = [[PartsLabourCellViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    [cell.contentView setTag:indexPath.row];
    
    if([[mPartsDictionary_ objectForKey:KPARTS] count]>0){
        if(  [[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_->mselectedSegment_==3)
            cell->showEdit=([[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Technician"]||([[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Advisor"]&&![[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] isEnableGBB:[self.mPartsDictionary_ objectForKey:KSGID]]));
        else
            cell->showEdit=FALSE;
        
        [cell setMServicesDict:[[mPartsDictionary_ objectForKey:KPARTS] objectAtIndex:indexPath.row]];
        cell->mPartsLaborMainSubview_=self ;
        [cell addViewToCell];
    }
    else{
        UILabel * lTempLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 40, 1024, 20)];
        [[GenericFiles genericFiles] createUILabelWithInstance:lTempLabel labelTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] labelTitle:kNOPARTSTEXT labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:lTempLabel];
    }
    // Configure the cell...
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray* lHeaderArray=[KPARTSHEADINGLABEL componentsSeparatedByString:@","];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)] ;
    /* Create custom view to display section header... */
    int xPos=10;
    
    //Service Label
    UILabel* lTempQualityLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, 90, 40)];
    [lTempQualityLabel setTag:0];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempQualityLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[lHeaderArray objectAtIndex:0]] labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [view addSubview:lTempQualityLabel];
    xPos+=100;
    
    // Quantity Label
    UILabel* lTempQuantityLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, 90, 40)];
    [lTempQuantityLabel setTag:1];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempQuantityLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[lHeaderArray objectAtIndex:1]] labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [view addSubview:lTempQuantityLabel];
    xPos+=100;
    
    
    // Parts Label
    UILabel* lTempPartsNumberLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, 110, 40)];
    [lTempPartsNumberLabel setTag:2];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempPartsNumberLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[lHeaderArray objectAtIndex:2]] labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [view addSubview:lTempPartsNumberLabel];
    xPos+=120;
    
    // Description Label
    UILabel* lTempDescriptionLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, 350, 40)];
    [lTempDescriptionLabel setTag:3];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempDescriptionLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[lHeaderArray objectAtIndex:3]] labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [view addSubview:lTempDescriptionLabel];
    xPos+=360;
    
    // Location Label
    UILabel* lTempLocationLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, 150, 40)];
    [lTempLocationLabel setTag:4];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempLocationLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[lHeaderArray objectAtIndex:4]] labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [view addSubview:lTempLocationLabel];
    xPos+=160;
    
    // Price Label
    UILabel* lTempPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, 100, 40)];
    [lTempPriceLabel setTag:5];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempPriceLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[lHeaderArray objectAtIndex:5]] labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [view addSubview:lTempPriceLabel];
    xPos+=110;
    
    if(self.mType_==APPROVESTATE)
        [view setBackgroundColor:kAPPROVECOLOR];
    else  if(self.mType_==DECLINESTATE)
        [view setBackgroundColor:kDECLINECOLOR];
    else  if(self.mType_==UNDECIDEDSTATE)
        [view setBackgroundColor:kUNDECIDEDCOLOR];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[self.mPartsDictionary_ objectForKey:KPARTS] count]>0)
        return  40.0;
    else
        return 100.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0;
}


@end
