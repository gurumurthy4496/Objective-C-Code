//
//  OpenROServiceCell.m
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "OpenROServiceCell.h"

@interface OpenROServiceCell(){
    
}
@property(nonatomic,retain) UIButton* mApproveButton_;
@property(nonatomic,retain) UIButton* mDeclineButton_;
@property(nonatomic,retain) UIButton* mEditButton_;
@property(nonatomic,retain) UIButton* mDoneButton_;
@property(nonatomic,retain) UIButton* mDeleteButton_;
@property(nonatomic,retain) UILabel* mServiceNameLabel_;
@property(nonatomic,retain) UIButton* mNPLButton_;
@property(nonatomic,retain) UILabel* mPayTypeLabel_;
@property(nonatomic,retain) UILabel* mHoursLabel_;
@property(nonatomic,retain) UILabel* mLaborLabel_;
@property(nonatomic,retain) UILabel* mPartsLabel_;
@property(nonatomic,retain) UILabel* mPriceLabel_;

@end

@implementation OpenROServiceCell
@synthesize mServiceDictionary_;
@synthesize mApproveButton_;
@synthesize mDeclineButton_;
@synthesize mEditButton_;
@synthesize mDoneButton_;
@synthesize mDeleteButton_;
@synthesize mServiceNameLabel_;
@synthesize mPayTypeLabel_;
@synthesize mHoursLabel_;
@synthesize mLaborLabel_;
@synthesize mPartsLabel_;
@synthesize mPriceLabel_;
@synthesize isPrimary;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)addViewToCell{
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self removeSubviews];
    if(self.contentView.tag%2==0)
        [ self.contentView setBackgroundColor:[UIColor whiteColor]];
    else
        [ self.contentView setBackgroundColor:[UIColor colorWithRed:(236.0/255.0) green:(240.0/255.0) blue:(241.0/255.0) alpha:1.0]];
    if(isPrimary)
        [self addCurrentServicesCell];
    else
        [self addRecommendedServicesCell];
}

-(void)removeSubviews{
    for (UIView *subview in [self.contentView subviews])
    {
        [subview removeFromSuperview];
    }
    
}

-(void)addRecommendedServicesCell{
    int xPos=5;
    UIView *lCellView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 690, self.contentView.frame.size.height)];
    [lCellView setBackgroundColor:[UIColor clearColor]];
    lCellView.clipsToBounds=YES;
    
    //Approve Button
    UIButton* lTempApproveButton = [[UIButton alloc] initWithFrame:CGRectMake(xPos, 7, APPROVE_BUTTON_WIDTH_OPENRO, 26)];
    [lTempApproveButton addTarget:self action:@selector(isApproveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [lTempApproveButton setBackgroundColor:[UIColor clearColor]];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempApproveButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kUNAPPROVE_IMAGE];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempApproveButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kAPPROVE_IMAGE];
    [self setMApproveButton_:lTempApproveButton];
    [mApproveButton_ setTag:APPROVE_BUTTON_TAG_OPENRO];
    [mApproveButton_ setSelected:[[mServiceDictionary_ objectForKey:@"Approved"] boolValue]];
    [lCellView addSubview:mApproveButton_];
    xPos+=(APPROVE_BUTTON_WIDTH_OPENRO+8);
    [lCellView bringSubviewToFront:mApproveButton_];
    
    //Decline Button
    UIButton* lTempDeclineButton = [[UIButton alloc] initWithFrame:CGRectMake(xPos, 7, DECLINE_BUTTON_WIDTH_OPENRO, 26)];
    [lTempDeclineButton addTarget:self action:@selector(isDeclineButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempDeclineButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kUNDECLINE_IMAGE];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempDeclineButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kDECLINE_IMAGE];
    [lTempDeclineButton setBackgroundColor:[UIColor clearColor]];
    [self setMDeclineButton_:lTempDeclineButton];
    [mDeclineButton_ setTag:DECLINE_BUTTON_TAG_OPENRO];
    [mDeclineButton_ setSelected:[[mServiceDictionary_ objectForKey:@"Declined"] boolValue]];
    
    [lCellView addSubview:mDeclineButton_];
    [lCellView bringSubviewToFront:mDeclineButton_];
    xPos+=(DECLINE_BUTTON_WIDTH_OPENRO+8);
    
    //Done Button
    UIButton* lTempDoneButton=[[UIButton alloc] initWithFrame:CGRectMake(xPos, 10, 70, 23)];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempDoneButton buttonTitle:@"Undone" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kUNDONE_IMAGE];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempDoneButton buttonTitle:@"Done" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kDONE_IMAGE];
    [lTempDoneButton addTarget:self action:@selector(isDoneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self setMDoneButton_:lTempDoneButton];
    [mDoneButton_ setTag:DONE_BUTTON_TAG_OPENRO];
    [mDoneButton_ setSelected:![[mServiceDictionary_ objectForKey:@"Completed"] boolValue]];
    
    [lCellView  addSubview:mDoneButton_];
    [mDoneButton_ setHidden:TRUE];
    
    //Service Label
    UILabel* lTempServiceLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 5,SERVICE_LABEL_WIDTH_OPENRO-30, 30)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempServiceLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[mServiceDictionary_ objectForKey:KSERVICENAME]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    
    //    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:lTempServiceLabel buttonTitle:[NSString stringWithFormat:@"%@",[mServiceDictionary_ objectForKey:KSERVICENAME]] buttonTitleColor:[[mServiceDictionary_ objectForKey:@"Completed"] boolValue]?[UIColor greenColor]:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] buttonTitleEdgeInsets:UIEdgeInsetsMake(5, -20, 5, 30) buttonImage:kNPL_ACTIVE_IMAGE_RECOMMENDED buttonImageEdgeInsets:UIEdgeInsetsMake(4, 190, 4, 0) controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundColor:[UIColor clearColor]];
    //    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:lTempServiceLabel buttonTitle:[NSString stringWithFormat:@"%@",[mServiceDictionary_ objectForKey:KSERVICENAME]] buttonTitleColor:[[mServiceDictionary_ objectForKey:@"Completed"] boolValue]?[UIColor greenColor]:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] buttonTitleEdgeInsets:UIEdgeInsetsMake(5,-20, 5, 30) buttonImage:kNPL_INACTIVE_IMAGE_RECOMMENDED buttonImageEdgeInsets:UIEdgeInsetsMake(4, 190, 4, 0) controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundColor:[UIColor clearColor]];
    //    [lTempServiceLabel setSelected:[[mServiceDictionary_ objectForKey:@"PartsNotNeeded"] boolValue]];
    //    [lTempServiceLabel addTarget:self action:@selector(isNPLButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //
    
    [lTempServiceLabel setTextColor:[[mServiceDictionary_ objectForKey:@"Completed"] boolValue]?[UIColor greenColor]:[UIColor blackColor]];
    
    [self setMServiceNameLabel_:lTempServiceLabel];
    [mServiceNameLabel_ setTag:SERVICE_LABEL_TAG_OPENRO];
    [mServiceNameLabel_ setLineBreakMode:NSLineBreakByTruncatingTail];
    [lCellView addSubview:mServiceNameLabel_];
    //Delete Button
    UIButton* lTempNPLButton=[[UIButton alloc] initWithFrame:CGRectMake(xPos+SERVICE_LABEL_WIDTH_OPENRO-30, 8, 24, 24)];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempNPLButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kNPL_ACTIVE_IMAGE_RECOMMENDED];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempNPLButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kNPL_INACTIVE_IMAGE_RECOMMENDED];;
    [lTempNPLButton setSelected:[[mServiceDictionary_ objectForKey:@"PartsNotNeeded"] boolValue]];
    [lTempNPLButton addTarget:self action:@selector(isNPLButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self setMNPLButton_:lTempNPLButton];
    //  [mDeleteButton_ setTag:DELETE_BUTTON_TAG_OPENRO];
    [self  addSubview:self.mNPLButton_];
    
    
    
    xPos+=(SERVICE_LABEL_WIDTH_OPENRO+SEPERATION_GAP_OPENRO);
    
    //Delete Button
    UIButton* lTempDeleteButton=[[UIButton alloc] initWithFrame:CGRectMake(xPos-75, 10, 70, 23)];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempDeleteButton buttonTitle:@"Delete" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kDELETE_IMAGE_RECOMMENDED];;
    [lTempDeleteButton addTarget:self action:@selector(isDeleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self setMDeleteButton_:lTempDeleteButton];
    [mDeleteButton_ setTag:DELETE_BUTTON_TAG_OPENRO];
    [self  addSubview:mDeleteButton_];
    [lTempDeleteButton setHidden:TRUE];
    
    
    UIView* lDividerView=[[UIView alloc]initWithFrame:CGRectMake(xPos-SEPERATION_GAP_OPENRO, 0, 1, self.contentView.frame.size.height)];
    [lDividerView setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lCellView addSubview:lDividerView];
    
    
    //PayType Label
    UILabel* lTempPayTypeLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 10, PAY_TYPE_LABEL_WIDTH_OPENRO,20)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempPayTypeLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[[mServiceDictionary_ objectForKey:@"PayTypeCode"] objectForKey:@"Code"]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [self setMPayTypeLabel_:lTempPayTypeLabel];
    [mPayTypeLabel_ setTag:PAY_TYPE_LABEL_TAG_OPENRO];
    [lCellView addSubview:mPayTypeLabel_];
    xPos+=(PAY_TYPE_LABEL_WIDTH_OPENRO+SEPERATION_GAP_OPENRO);
    
    UIView* lDividerView1=[[UIView alloc]initWithFrame:CGRectMake(xPos-SEPERATION_GAP_OPENRO, 0, 1, self.contentView.frame.size.height)];
    [lDividerView1 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lCellView addSubview:lDividerView1];
    
    
    //Hrs Type Label
    UILabel* lTempHrsLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 10,HOURS_LABEL_WIDTH_OPENRO, 20)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempHrsLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%.1f",[[mServiceDictionary_ objectForKey:KHOURS] floatValue]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [self setMHoursLabel_:lTempHrsLabel];
    [mHoursLabel_ setTag:HOURS_LABEL_TAG_OPENRO];
    [lCellView addSubview:mHoursLabel_];
    xPos+=(HOURS_LABEL_WIDTH_OPENRO+SEPERATION_GAP_OPENRO);
    
    UIView* lDividerView2=[[UIView alloc]initWithFrame:CGRectMake(xPos-SEPERATION_GAP_OPENRO, 0, 1, self.contentView.frame.size.height)];
    [lDividerView2 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lCellView addSubview:lDividerView2];
    
    
    
    //Labor Label
    UILabel* lTempLaborLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos-10, 10, LABOR_LABEL_WIDTH_OPENRO,20)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempLaborLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"$%.2f",[[mServiceDictionary_ objectForKey:KPRICELABOR] floatValue]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentRight labelBackgroundColor:[UIColor clearColor]];
    [self setMLaborLabel_:lTempLaborLabel];
    [mLaborLabel_ setTag:LABOR_LABEL_TAG_OPENRO];
    [lCellView addSubview:mLaborLabel_];
    xPos+=(LABOR_LABEL_WIDTH_OPENRO+SEPERATION_GAP_OPENRO);
    
    UIView* lDividerView3=[[UIView alloc]initWithFrame:CGRectMake(xPos-SEPERATION_GAP_OPENRO, 0, 1, self.contentView.frame.size.height)];
    [lDividerView3 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lCellView addSubview:lDividerView3];
    
    
    
    //Parts Label
    UILabel* lTempPartsLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos-10,10,PARTS_LABEL_WIDTH_OPENRO, 20)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempPartsLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"$%.2f",[[mServiceDictionary_ objectForKey:KPRICEPARTS] floatValue]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentRight labelBackgroundColor:[UIColor clearColor]];
    [self setMPartsLabel_:lTempPartsLabel];
    [mPartsLabel_ setTag:PARTS_LABEL_TAG_OPENRO];
    [lCellView addSubview:mPartsLabel_];
    xPos+=(PARTS_LABEL_WIDTH_OPENRO+SEPERATION_GAP_OPENRO);
    
    UIView* lDividerView4=[[UIView alloc]initWithFrame:CGRectMake(xPos-SEPERATION_GAP_OPENRO, 0, 1, self.contentView.frame.size.height)];
    [lDividerView4 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lCellView addSubview:lDividerView4];
    
    
    
    // Price Label
    UILabel* lTempPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos-10, 10, PRICE_LABEL_WIDTH_OPENRO,20)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempPriceLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"$%.2f",[[mServiceDictionary_ objectForKey:KPRICE] floatValue]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentRight labelBackgroundColor:[UIColor clearColor]];
    [self setMPriceLabel_:lTempPriceLabel];
    [mPriceLabel_ setTag:PRICE_LABEL_TAG_OPENRO];
    [lCellView addSubview:mPriceLabel_];
    xPos+=(PRICE_LABEL_WIDTH_OPENRO+SEPERATION_GAP_OPENRO);
    
    UIView* lDividerView5=[[UIView alloc]initWithFrame:CGRectMake(xPos-SEPERATION_GAP_OPENRO, 0, 1, self.contentView.frame.size.height)];
    [lDividerView5 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lCellView addSubview:lDividerView5];
    
    // Edit Buton
    UIButton* lTempEditButton = [[UIButton alloc] initWithFrame:CGRectMake(xPos+5, 10, EDIT_BUTTON_WIDTH_OPENRO, 24)];
    [lTempEditButton addTarget:self action:@selector(isEditButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempEditButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kEDIT_IMAGE_RECOMMENDED];
    [lTempEditButton setBackgroundColor:[UIColor clearColor]];
    [self setMEditButton_:lTempEditButton];
    [mEditButton_ setTag:EDIT_BUTTON_TAG_OPENRO];
    [lCellView addSubview:mEditButton_];
    
    [self sendSubviewToBack:self.contentView];
    [self.contentView addSubview:lCellView];
}

-(void)addCurrentServicesCell{
    int xPos=5;
    UIView *lCellView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 690, self.contentView.frame.size.height)];
    [lCellView setBackgroundColor:[UIColor clearColor]];
    lCellView.clipsToBounds=YES;
    
    //Done Button
    UIButton* lTempDoneButton=[[UIButton alloc] initWithFrame:CGRectMake(xPos, 10, 70, 23)];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempDoneButton buttonTitle:@"Undone" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kUNDONE_IMAGE];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempDoneButton buttonTitle:@"Done" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kDONE_IMAGE];
    [lTempDoneButton addTarget:self action:@selector(isDoneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self setMDoneButton_:lTempDoneButton];
    [mDoneButton_ setTag:DONE_BUTTON_TAG_OPENRO];
    [self  addSubview:mDoneButton_];
    [mDoneButton_ setHidden:TRUE];
    
    //Service Label
    
    UILabel* lTempServiceLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 5,SERVICE_LABEL_WIDTH_OPENRO+70, 30)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempServiceLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[mServiceDictionary_ objectForKey:KSERVICENAME]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    
    //    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:lTempServiceLabel buttonTitle:[NSString stringWithFormat:@"%@",[mServiceDictionary_ objectForKey:KSERVICENAME]] buttonTitleColor:[[mServiceDictionary_ objectForKey:@"Completed"] boolValue]?[UIColor greenColor]:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] buttonTitleEdgeInsets:UIEdgeInsetsMake(5, -20, 5, 30) buttonImage:kNPL_ACTIVE_IMAGE_RECOMMENDED buttonImageEdgeInsets:UIEdgeInsetsMake(4, 190, 4, 0) controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundColor:[UIColor clearColor]];
    //    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:lTempServiceLabel buttonTitle:[NSString stringWithFormat:@"%@",[mServiceDictionary_ objectForKey:KSERVICENAME]] buttonTitleColor:[[mServiceDictionary_ objectForKey:@"Completed"] boolValue]?[UIColor greenColor]:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] buttonTitleEdgeInsets:UIEdgeInsetsMake(5,-20, 5, 30) buttonImage:kNPL_INACTIVE_IMAGE_RECOMMENDED buttonImageEdgeInsets:UIEdgeInsetsMake(4, 190, 4, 0) controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundColor:[UIColor clearColor]];
    //    [lTempServiceLabel setSelected:[[mServiceDictionary_ objectForKey:@"PartsNotNeeded"] boolValue]];
    //    [lTempServiceLabel addTarget:self action:@selector(isNPLButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //
    [self setMServiceNameLabel_:lTempServiceLabel];
    [lTempServiceLabel setTextColor:[[mServiceDictionary_ objectForKey:@"Completed"] boolValue]?[UIColor greenColor]:[UIColor blackColor]];
    
    [mServiceNameLabel_ setTag:SERVICE_LABEL_TAG_OPENRO];
    [mServiceNameLabel_ setLineBreakMode:NSLineBreakByTruncatingTail];
    [lCellView addSubview:mServiceNameLabel_];
    //Delete Button
    //    UIButton* lTempNPLButton=[[UIButton alloc] initWithFrame:CGRectMake(xPos+SERVICE_LABEL_WIDTH_OPENRO+50-30, 7, 23, 23)];
    //    [[GenericFiles genericFiles] createUIButtonInstance:lTempNPLButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kNPL_ACTIVE_IMAGE_RECOMMENDED];
    //    [[GenericFiles genericFiles] createUIButtonInstance:lTempNPLButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kNPL_INACTIVE_IMAGE_RECOMMENDED];;
    //    [lTempNPLButton setSelected:[[mServiceDictionary_ objectForKey:@"PartsNotNeeded"] boolValue]];
    //    [lTempNPLButton addTarget:self action:@selector(isNPLButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    [self setMNPLButton_:lTempNPLButton];
    //    //  [mDeleteButton_ setTag:DELETE_BUTTON_TAG_OPENRO];
    //    [self  addSubview:self.mNPLButton_];
    
    
    //Delete Button
    UIButton* lTempDeleteButton=[[UIButton alloc] initWithFrame:CGRectMake(xPos-75, 10, 70, 23)];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempDeleteButton buttonTitle:@"Delete" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kDELETE_IMAGE_RECOMMENDED];;
    [lTempDeleteButton addTarget:self action:@selector(isDeleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self setMDeleteButton_:lTempDeleteButton];
    [mDeleteButton_ setTag:DELETE_BUTTON_TAG_OPENRO];
    [self  addSubview:mDeleteButton_];
    [lTempDeleteButton setHidden:TRUE];
    
    xPos+=(SERVICE_LABEL_WIDTH_OPENRO+SEPERATION_GAP_OPENRO+70);
    
    UIView* lDividerView=[[UIView alloc]initWithFrame:CGRectMake(xPos-SEPERATION_GAP_OPENRO, 0, 1, self.contentView.frame.size.height)];
    [lDividerView setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lCellView addSubview:lDividerView];
    
    
    //PayType Label
    UILabel* lTempPayTypeLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, PAY_TYPE_LABEL_WIDTH_OPENRO, self.contentView.frame.size.height)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempPayTypeLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[mServiceDictionary_ objectForKey:@"PayTypeCode"] objectForKey:@"Code"]]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [self setMPayTypeLabel_:lTempPayTypeLabel];
    [mPayTypeLabel_ setTag:PAY_TYPE_LABEL_TAG_OPENRO];
    [lCellView addSubview:mPayTypeLabel_];
    xPos+=(PAY_TYPE_LABEL_WIDTH_OPENRO+SEPERATION_GAP_OPENRO);
    
    UIView* lDividerView1=[[UIView alloc]initWithFrame:CGRectMake(xPos-SEPERATION_GAP_OPENRO, 0, 1, self.contentView.frame.size.height)];
    [lDividerView1 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lCellView addSubview:lDividerView1];
    
    
    //Hrs Type Label
    UILabel* lTempHrsLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 0,HOURS_LABEL_WIDTH_OPENRO, self.contentView.frame.size.height)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempHrsLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%.1f",[[mServiceDictionary_ objectForKey:KHOURS] floatValue]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]]  ;
    [self setMHoursLabel_:lTempHrsLabel];
    [mHoursLabel_ setTag:HOURS_LABEL_TAG_OPENRO];
    [lCellView addSubview:mHoursLabel_];
    xPos+=(HOURS_LABEL_WIDTH_OPENRO+SEPERATION_GAP_OPENRO);
    
    UIView* lDividerView2=[[UIView alloc]initWithFrame:CGRectMake(xPos-SEPERATION_GAP_OPENRO, 0, 1, self.contentView.frame.size.height)];
    [lDividerView2 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lCellView addSubview:lDividerView2];
    
    
    
    //Labor Label
    UILabel* lTempLaborLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos-10, 0, LABOR_LABEL_WIDTH_OPENRO, self.contentView.frame.size.height)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempLaborLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"$%.2f",[[mServiceDictionary_ objectForKey:KPRICELABOR] floatValue]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentRight labelBackgroundColor:[UIColor clearColor]];
    [self setMLaborLabel_:lTempLaborLabel];
    [mLaborLabel_ setTag:LABOR_LABEL_TAG_OPENRO];
    [lCellView addSubview:mLaborLabel_];
    xPos+=(LABOR_LABEL_WIDTH_OPENRO+SEPERATION_GAP_OPENRO);
    
    UIView* lDividerView3=[[UIView alloc]initWithFrame:CGRectMake(xPos-SEPERATION_GAP_OPENRO, 0, 1, self.contentView.frame.size.height)];
    [lDividerView3 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lCellView addSubview:lDividerView3];
    
    
    
    //Parts Label
    UILabel* lTempPartsLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos-10, 0,PARTS_LABEL_WIDTH_OPENRO, self.contentView.frame.size.height)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempPartsLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"$%.2f",[[mServiceDictionary_ objectForKey:KPRICEPARTS] floatValue]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentRight labelBackgroundColor:[UIColor clearColor]];
    [self setMPartsLabel_:lTempPartsLabel];
    [mPartsLabel_ setTag:PARTS_LABEL_TAG_OPENRO];
    [lCellView addSubview:mPartsLabel_];
    xPos+=(PARTS_LABEL_WIDTH_OPENRO+SEPERATION_GAP_OPENRO);
    
    UIView* lDividerView4=[[UIView alloc]initWithFrame:CGRectMake(xPos-SEPERATION_GAP_OPENRO, 0, 1, self.contentView.frame.size.height)];
    [lDividerView4 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lCellView addSubview:lDividerView4];
    
    
    
    //Price Label
    UILabel* lTempPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos-10, 0, PRICE_LABEL_WIDTH_OPENRO, self.contentView.frame.size.height)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempPriceLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"$%.2f",[[mServiceDictionary_ objectForKey:KPRICE] floatValue]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentRight labelBackgroundColor:[UIColor clearColor]];
    [self setMPriceLabel_:lTempPriceLabel];
    [mPriceLabel_ setTag:PRICE_LABEL_TAG_OPENRO];
    [lCellView addSubview:mPriceLabel_];
    xPos+=(PRICE_LABEL_WIDTH_OPENRO+SEPERATION_GAP_OPENRO);
    
    UIView* lDividerView5=[[UIView alloc]initWithFrame:CGRectMake(xPos-SEPERATION_GAP_OPENRO, 0, 1, self.contentView.frame.size.height)];
    [lDividerView5 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lCellView addSubview:lDividerView5];
    
    
    
    //Edit Buton
    UIButton* lTempEditButton = [[UIButton alloc] initWithFrame:CGRectMake(xPos+5, 10, EDIT_BUTTON_WIDTH_OPENRO, 24)];
    [lTempEditButton addTarget:self action:@selector(isEditButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempEditButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kEDIT_IMAGE_RECOMMENDED];
    [self setMEditButton_:lTempEditButton];
    [mEditButton_ setTag:EDIT_BUTTON_TAG_OPENRO];
    [lCellView addSubview:mEditButton_];
    [mApproveButton_ setSelected:[[mServiceDictionary_ objectForKey:@"Approved"] boolValue]];
    [mDeclineButton_ setSelected:[[mServiceDictionary_ objectForKey:@"Declined"] boolValue]];
    [mDoneButton_ setSelected:![[mServiceDictionary_ objectForKey:@"Completed"] boolValue]];
    
    [self sendSubviewToBack:self.contentView];
    [self.contentView addSubview:lCellView];
}


-(void)resetCellView{
    isCellSwipedRight=FALSE;
    isCellSwipedLeft=FALSE;
    [mDeleteButton_ setHidden:TRUE];
    [mDoneButton_ setHidden:TRUE];
    [mDoneButton_.superview bringSubviewToFront:mApproveButton_];
    [mDoneButton_.superview bringSubviewToFront:mDeclineButton_];
    
}

-(void)isEditButtonClicked:(UIButton*)aSender{
    if((mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_!=7)||(![mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Technician"])){
        [mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_ saveDictToModel:self.mServiceDictionary_];
        [mAppDelegate_.mSearchViewController_.mOpenROServicesTableViewController_  getAddServicesList];
    }
}

-(void)isDoneButtonClicked:(UIButton*)aSender{
    [mDoneButton_ setSelected:![mDoneButton_ isSelected]];
    [mDoneButton_ setHidden:TRUE];
    isCellSwipedLeft=FALSE;
    [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForCompleteServiceLine:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_ LineID:[mServiceDictionary_ objectForKey:KID] isDone:!mDoneButton_.isSelected];
    [mDoneButton_.superview bringSubviewToFront:mApproveButton_];
    [mDoneButton_.superview bringSubviewToFront:mDeclineButton_];
    
    
}

-(void)isDeleteButtonClicked:(UIButton*)aSender{
    [mDeleteButton_ setHidden:TRUE];
    isCellSwipedRight=FALSE;
    [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForDeleteServiceLine:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_ LineID:[mServiceDictionary_ objectForKey:@"ID"]];
}
-(void)isApproveButtonClicked:(UIButton*)aSender{
    if([mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Advisor"]||([mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Manager"])){
        if(([[NSString stringWithFormat:@"%@",[self.mServiceDictionary_ objectForKey:@"CreateUserID"]] intValue]==[mAppDelegate_.mModelForSplashScreen_.mEmployeeID_ intValue])||(mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_==4)||(mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_==6)){
            if(mDoneButton_.isSelected&&(([mAppDelegate_.mOpenRoServiceDataGetter_.mPartStatusID_ intValue]==1)||([mAppDelegate_.mOpenRoServiceDataGetter_.mPartStatusID_ intValue]==5))&&(([[NSString stringWithFormat:@"%@",[mServiceDictionary_ objectForKey:@"Hours"]]floatValue]>0)||([mAppDelegate_.mServiceDataGetter_ isAllowZeroHours:[self.mServiceDictionary_ objectForKey:@"SGID"]])||([[self getSubString:[NSString stringWithFormat:@"%@",[[mServiceDictionary_ objectForKey:KPAYTYPECODE] objectForKey:KPAYCODE]]] isEqualToString:@"W"]))){
                
                [mApproveButton_ setSelected:![mApproveButton_ isSelected]];
                [mDeclineButton_ setSelected:FALSE];
                if([mApproveButton_ isSelected])
                    [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForApproveServiceLine:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_ LineID:[mServiceDictionary_ objectForKey:@"ID"] ApproveDict:[[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID",@"true",@"Data", nil] mutableCopy] ];
                else
                    [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForApproveServiceLine:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_ LineID:[mServiceDictionary_ objectForKey:@"ID"] ApproveDict:[[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID", nil] mutableCopy] ];
                
            }
        }
    }
}
-(void)isDeclineButtonClicked:(UIButton*)aSender{
    if([mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Advisor"]||([mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Manager"])){
        if(([[NSString stringWithFormat:@"%@",[self.mServiceDictionary_ objectForKey:@"CreateUserID"]] intValue]==[mAppDelegate_.mModelForSplashScreen_.mEmployeeID_ intValue])||(mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_==4)||(mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_==6)){
            if(mDoneButton_.isSelected&&(([mAppDelegate_.mOpenRoServiceDataGetter_.mPartStatusID_ intValue]==1)||([mAppDelegate_.mOpenRoServiceDataGetter_.mPartStatusID_ intValue]==5))&&(([[NSString stringWithFormat:@"%@",[mServiceDictionary_ objectForKey:@"Hours"]]floatValue]>0)||([mAppDelegate_.mServiceDataGetter_ isAllowZeroHours:[self.mServiceDictionary_ objectForKey:@"SGID"]])||([[self getSubString:[NSString stringWithFormat:@"%@",[[mServiceDictionary_ objectForKey:KPAYTYPECODE] objectForKey:KPAYCODE]]] isEqualToString:@"W"]))){
                [mDeclineButton_ setSelected:![mDeclineButton_ isSelected]];
                [mApproveButton_ setSelected:FALSE];
                if([mDeclineButton_ isSelected])
                    [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForApproveServiceLine:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_ LineID:[mServiceDictionary_ objectForKey:@"ID"] ApproveDict:[[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID",@"false",@"Data", nil] mutableCopy] ];
                else
                    [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForApproveServiceLine:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_ LineID:[mServiceDictionary_ objectForKey:@"ID"] ApproveDict:[[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID", nil] mutableCopy] ];
                
            }
        }
    }
}

-(void)isCellSwipedRight:(BOOL)isTrue{
    if(!isCellSwipedRight){
        if((mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_!=2)&&(mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_!=7)){
            if((isPrimary)||(mApproveButton_.isSelected)){
                [mDoneButton_ setHidden:FALSE];
                isCellSwipedLeft=TRUE;
                [mDoneButton_.superview bringSubviewToFront:mDoneButton_];
            }
        }
    }else
        [self resetCellView];
}

-(void)isCellSwipedLeft:(BOOL)isTrue{
    if(!isCellSwipedLeft){
        if(([mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Technician"]&&([[NSString stringWithFormat:@"%@",[mServiceDictionary_ objectForKey:@"CreateUserID"]] intValue]==[mAppDelegate_.mModelForSplashScreen_.mEmployeeID_ intValue]))||([mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Manager"])||([mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Advisor"]&&(([[NSString stringWithFormat:@"%@",[mServiceDictionary_ objectForKey:@"CreateUserID"]] intValue]==[mAppDelegate_.mModelForSplashScreen_.mEmployeeID_ intValue])||(mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_>3)))){
            if((!isPrimary)&&(!mApproveButton_.isSelected)&&(!mDeclineButton_.isSelected)&&(mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_!=7)){
                [mDeleteButton_ setHidden:FALSE];
                isCellSwipedRight=TRUE;
            }
        }
    }
    else
        [self resetCellView];
}


-(void)isNPLButtonClicked:(UIButton*)sender{
    if(mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_!=7){
        
        [sender setSelected:![sender isSelected]];
        [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForPartsNotNeeded:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_ LineID:[self.mServiceDictionary_ objectForKey:KID] NPLDict:[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID",[sender isSelected]?@"true":@"false",@"Data", nil]];
    }
}


-(NSString*)getSubString:(NSString*)aSubStr{
    if(![[aSubStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])
        
        return [aSubStr substringToIndex:1];
    return @"";
}
@end

