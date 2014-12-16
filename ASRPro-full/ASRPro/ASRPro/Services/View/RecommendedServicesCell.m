//
//  RecommendedServicesCell.m
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "RecommendedServicesCell.h"
#import "AddServicesViewController.h"
@interface RecommendedServicesCell(){
    
}

/**
 * Instance for Edit Button
 */
@property(nonatomic,retain) UIButton* mEditButton_;

/**
 * Instance for Delete Button
 */
@property(nonatomic,retain) UIButton* mDeleteButton_;

/**
 * Instance for Service Label
 */
@property(nonatomic,retain) UILabel* mServiceLabel_;

/**
 * Instance for Approve Button
 */
@property(nonatomic,retain) UIButton* mNPLButton_;

/**
 * Instance for Pay Type Label
 */
@property(nonatomic,retain) UILabel* mPayTypeLabel_;

/**
 * Instance for Hours Label
 */
@property(nonatomic,retain) UILabel* mHrsLabel_;

/**
 * Instance for Labor Label
 */
@property(nonatomic,retain) UILabel* mLaborLabel_;

/**
 * Instance for Parts Label
 */
@property(nonatomic,retain) UILabel* mPartsLabel_;

/**
 * Instance for Price Label
 */
@property(nonatomic,retain) UILabel* mPriceLabel_;

/**
 * Instance for Approve Button
 */
@property(nonatomic,retain) ServicesApproveButton* mApproveButton_;

@end


@implementation RecommendedServicesCell
@synthesize mServicesDict;
@synthesize mEditButton_;
@synthesize mServiceLabel_;
@synthesize mPayTypeLabel_;
@synthesize mHrsLabel_;
@synthesize mLaborLabel_;
@synthesize mPartsLabel_;
@synthesize mPriceLabel_;
@synthesize mApproveButton_;
@synthesize mDeleteButton_;
@synthesize mNPLButton_;

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

#pragma mark -  ********************** Generic Methods **************************

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** Method to initialise ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)addViewToCell{
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self removeSubviews];
    if(self.contentView.tag%2==0)
        [ self.contentView setBackgroundColor:[UIColor whiteColor]];
    else
        [ self.contentView setBackgroundColor:[UIColor colorWithRed:(236.0/255.0) green:(240.0/255.0) blue:(241.0/255.0) alpha:1.0]];
    
    [self addRecommendedServicesCell];
}


-(void)addNoServicesLabel{
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self removeSubviews];
    [ self.contentView setBackgroundColor:[UIColor whiteColor]];
    [self.textLabel setText:@"No Services have been added"];
    [self.textLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabel setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
    self.userInteractionEnabled = NO;

}
//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** Method to remove subviews in cell content views ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)removeSubviews{
    for (UIView *subview in [self.contentView subviews])
    {
        [subview removeFromSuperview];
    }
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** Method to customise recommended cell view ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)addRecommendedServicesCell{
    UIView *lCellView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 690, self.contentView.frame.size.height)];
    [lCellView setBackgroundColor:[UIColor clearColor]];
    lCellView.clipsToBounds=YES;
    int xPos=5;
    
    //Edit Buton
    UIButton* lTempEditButton = [[UIButton alloc] initWithFrame:CGRectMake(xPos, 8, EDIT_BUTTON_WIDTH_RECOMMENDED, 24)];
    [lTempEditButton setTag:EDIT_BUTTON_TAG_RECOMMENDED];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempEditButton buttonTitle:@"" buttonTitleColor:[UIColor clearColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kEDIT_IMAGE_RECOMMENDED];
    [lTempEditButton addTarget:self action:@selector(isEditButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setMEditButton_:lTempEditButton];
    [lCellView addSubview:mEditButton_];
    xPos+=EDIT_BUTTON_WIDTH_RECOMMENDED+5;
    
    //Service Label
    UILabel* lTempServiceLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos,5, SERVICE_LABEL_WIDTH_RECOMMENDED-30, 30)];
    [lTempServiceLabel setTag:SERVICE_LABEL_TAG_RECOMMENDED];
    //    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:lTempServiceLabel buttonTitle:[NSString stringWithFormat:@"%@",[mServicesDict objectForKey:KSERVICENAME]] buttonTitleColor:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] buttonTitleEdgeInsets:UIEdgeInsetsMake(5, -20, 5, 30) buttonImage:kNPL_ACTIVE_IMAGE_RECOMMENDED buttonImageEdgeInsets:UIEdgeInsetsMake(4, 220, 4, 0) controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundColor:[UIColor clearColor]];
    //    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:lTempServiceLabel buttonTitle:[NSString stringWithFormat:@"%@",[mServicesDict objectForKey:KSERVICENAME]] buttonTitleColor:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] buttonTitleEdgeInsets:UIEdgeInsetsMake(5,-20, 5, 30) buttonImage:kNPL_INACTIVE_IMAGE_RECOMMENDED buttonImageEdgeInsets:UIEdgeInsetsMake(4, 220, 4, 0) controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundColor:[UIColor clearColor]];
    //    [lTempServiceLabel setSelected:[[mServicesDict objectForKey:KPARTSNOTNEEDED] boolValue]];
    //    [lTempServiceLabel addTarget:self action:@selector(isNPLButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempServiceLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[mServicesDict objectForKey:KSERVICENAME]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    
    [lTempServiceLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [self setMServiceLabel_:lTempServiceLabel];
    [lCellView addSubview:mServiceLabel_];
    
    
    //    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:lTempServiceLabel buttonTitle:[NSString stringWithFormat:@"%@",[mServiceDictionary_ objectForKey:KSERVICENAME]] buttonTitleColor:[[mServiceDictionary_ objectForKey:@"Completed"] boolValue]?[UIColor greenColor]:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] buttonTitleEdgeInsets:UIEdgeInsetsMake(5, -20, 5, 30) buttonImage:kNPL_ACTIVE_IMAGE_RECOMMENDED buttonImageEdgeInsets:UIEdgeInsetsMake(4, 190, 4, 0) controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundColor:[UIColor clearColor]];
    //    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:lTempServiceLabel buttonTitle:[NSString stringWithFormat:@"%@",[mServiceDictionary_ objectForKey:KSERVICENAME]] buttonTitleColor:[[mServiceDictionary_ objectForKey:@"Completed"] boolValue]?[UIColor greenColor]:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] buttonTitleEdgeInsets:UIEdgeInsetsMake(5,-20, 5, 30) buttonImage:kNPL_INACTIVE_IMAGE_RECOMMENDED buttonImageEdgeInsets:UIEdgeInsetsMake(4, 190, 4, 0) controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundColor:[UIColor clearColor]];
    //    [lTempServiceLabel setSelected:[[mServiceDictionary_ objectForKey:@"PartsNotNeeded"] boolValue]];
    //    [lTempServiceLabel addTarget:self action:@selector(isNPLButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //
    
    //NPL Button
    UIButton* lTempNPLButton=[[UIButton alloc] initWithFrame:CGRectMake(xPos+SERVICE_LABEL_WIDTH_RECOMMENDED-30, 8, 24, 24)];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempNPLButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kNPL_ACTIVE_IMAGE_RECOMMENDED];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempNPLButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kNPL_INACTIVE_IMAGE_RECOMMENDED];;
    [lTempNPLButton setSelected:[[mServicesDict objectForKey:@"PartsNotNeeded"] boolValue]];
    [lTempNPLButton addTarget:self action:@selector(isNPLButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self setMNPLButton_:lTempNPLButton];
    //  [mDeleteButton_ setTag:DELETE_BUTTON_TAG_OPENRO];
    [self  addSubview:self.mNPLButton_];
    
    xPos+=SERVICE_LABEL_WIDTH_RECOMMENDED+SEPERATION_GAP_RECOMMENDED;
    
    
    UIView* lDividerView=[[UIView alloc]initWithFrame:CGRectMake(xPos-SEPERATION_GAP_RECOMMENDED, 0, 1, self.contentView.frame.size.height)];
    [lDividerView setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lCellView addSubview:lDividerView];
    
    //PayType Label
    UILabel* lTempPayTypeLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 10, PAY_TYPE_LABEL_WIDTH_RECOMMENDED, 20)];
    [lTempPayTypeLabel setTag:PAY_TYPE_LABEL_TAG_RECOMMENDED];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempPayTypeLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[[mServicesDict objectForKey:KPAYTYPECODE] objectForKey:KPAYCODE]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [self setMPayTypeLabel_:lTempPayTypeLabel];
    [lCellView addSubview:mPayTypeLabel_];
    xPos+=(PAY_TYPE_LABEL_WIDTH_RECOMMENDED+SEPERATION_GAP_RECOMMENDED);
    
    
    UIView* lDividerView1=[[UIView alloc]initWithFrame:CGRectMake(xPos-SEPERATION_GAP_RECOMMENDED, 0, 1, self.contentView.frame.size.height)];
    [lDividerView1 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lCellView addSubview:lDividerView1];
    
    //Hrs Type Label
    UILabel* lTempHrsLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 10, HOURS_LABEL_WIDTH_RECOMMENDED-10, 20)];
    [lTempHrsLabel setTag:HOURS_LABEL_TAG_RECOMMENDED];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempHrsLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%.1f",[[mServicesDict objectForKey:KHOURS] floatValue]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [self setMHrsLabel_:lTempHrsLabel];
    [lCellView addSubview:mHrsLabel_];
    xPos+=(HOURS_LABEL_WIDTH_RECOMMENDED+SEPERATION_GAP_RECOMMENDED);
    
    UIView* lDividerView2=[[UIView alloc]initWithFrame:CGRectMake(xPos-SEPERATION_GAP_RECOMMENDED, 0, 1, self.contentView.frame.size.height)];
    [lDividerView2 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lCellView addSubview:lDividerView2];
    
    //Labor Label
    UILabel* lTempLaborLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 10, LABOR_LABEL_WIDTH_RECOMMENDED-10,20)];
    [lTempLaborLabel setTag:LABOR_LABEL_TAG_RECOMMENDED];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempLaborLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"$%.2f",[[mServicesDict objectForKey:KPRICELABOR] floatValue]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentRight labelBackgroundColor:[UIColor clearColor]];
    [self setMLaborLabel_:lTempLaborLabel];
    [lCellView addSubview:mLaborLabel_];
    xPos+=(LABOR_LABEL_WIDTH_RECOMMENDED+SEPERATION_GAP_RECOMMENDED);
    
    UIView* lDividerView3=[[UIView alloc]initWithFrame:CGRectMake(xPos-SEPERATION_GAP_RECOMMENDED, 0, 1, self.contentView.frame.size.height)];
    [lDividerView3 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lCellView addSubview:lDividerView3];
    
    //Parts Label
    UILabel* lTempPartsLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 10, PARTS_LABEL_WIDTH_RECOMMENDED-10, 20)];
    [lTempPartsLabel setTag:PARTS_LABEL_TAG_RECOMMENDED];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempPartsLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"$%.2f",[[mServicesDict objectForKey:KPRICEPARTS] floatValue]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentRight labelBackgroundColor:[UIColor clearColor]];
    [self setMPartsLabel_:lTempPartsLabel];
    [lCellView addSubview:mPartsLabel_];
    xPos+=(PARTS_LABEL_WIDTH_RECOMMENDED+SEPERATION_GAP_RECOMMENDED);
    UIView* lDividerView4=[[UIView alloc]initWithFrame:CGRectMake(xPos-SEPERATION_GAP_RECOMMENDED, 0, 1, self.contentView.frame.size.height)];
    [lDividerView4 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lCellView addSubview:lDividerView4];
    
    //Price Label
    UILabel* lTempPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 10, PRICE_LABEL_WIDTH_RECOMMENDED-10, 20)];
    [lTempPriceLabel setTag:PRICE_LABEL_TAG_RECOMMENDED];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempPriceLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"$%.2f",[[mServicesDict objectForKey:KPRICE] floatValue]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentRight labelBackgroundColor:[UIColor clearColor]];
    [self setMPriceLabel_:lTempPriceLabel];
    [lCellView addSubview:mPriceLabel_];
    xPos+=(PRICE_LABEL_WIDTH_RECOMMENDED+SEPERATION_GAP_RECOMMENDED);
    UIView* lDividerView5=[[UIView alloc]initWithFrame:CGRectMake(xPos-SEPERATION_GAP_RECOMMENDED, 0, 1, self.contentView.frame.size.height)];
    [lDividerView5 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lCellView addSubview:lDividerView5];
    
    //Approve Button
    ServicesApproveButton* lTempApproveButton = [[ServicesApproveButton alloc] initWithFrame:CGRectMake(xPos+5, 7, APPROVE_BUTTON_WIDTH_RECOMMENDED, 26)];
    [lTempApproveButton setApprovestate:UNDECIDEDSTATE];
    if([[self.mServicesDict objectForKey:KAPPROVED ] boolValue])
        [lTempApproveButton setApprovestate:APPROVESTATE];
    if([[self.mServicesDict objectForKey:KDECLINED ] boolValue])
        [lTempApproveButton setApprovestate:DECLINESTATE];
    [lTempApproveButton addTarget:self action:@selector(isApproveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [lCellView addSubview:lTempApproveButton];
    
    UIButton* lTempDeleteButton=[[UIButton alloc] initWithFrame:CGRectMake(160, 10, 70, 23)];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempDeleteButton buttonTitle:@"Delete" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kDELETE_IMAGE_RECOMMENDED];
    [lTempDeleteButton addTarget:self action:@selector(isDeleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self setMDeleteButton_:lTempDeleteButton];
    [mDeleteButton_ setTag:DELETE_BUTTON_TAG_RECOMMENDED];
    [self.contentView  addSubview:lTempDeleteButton];
    [self.contentView addSubview:lCellView];
    [mDeleteButton_ setHidden:TRUE];
    [self.contentView bringSubviewToFront:mDeleteButton_];
    
}

#pragma mark -  ********************** Button Actions**************************

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** Button action for Edit Button ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)isEditButtonClicked:(UIButton*)sender{
    [mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_ saveDictToModel:mServicesDict];
    [mAppDelegate_.mServicesViewController_ showAddServicePopup];
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** Button action for Delete Button ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)isDeleteButtonClicked:(UIButton*)sender{
    [mAppDelegate_.mModelForServiceRequestWebEngine_ setMGetServiceReference_:SERVICESVIEWCONTROLLER];
    [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForDeleteServiceLine:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ LineID:[mServicesDict objectForKey:@"ID"]];
    
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** Button action for Approve Button ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)isApproveButtonClicked:(ServicesApproveButton*)sender{
    DLog(@"self.mServicesDict :%@",self.mServicesDict);
   
        if([sender approvestate]==APPROVESTATE){
            [sender setApprovestate:DECLINESTATE];
            [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForApproveServiceLine:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ LineID:[self.mServicesDict objectForKey:KID] ApproveDict:[[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID",@"false",@"Data", nil] mutableCopy]];
        }
        else if([sender approvestate]==DECLINESTATE){
            [sender setApprovestate:UNDECIDEDSTATE];
            [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForApproveServiceLine:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ LineID:[self.mServicesDict objectForKey:KID] ApproveDict:[[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID", nil] mutableCopy]];
        }
        else if([sender approvestate]==UNDECIDEDSTATE){
            [sender setApprovestate:APPROVESTATE];
            [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForApproveServiceLine:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ LineID:[self.mServicesDict objectForKey:KID] ApproveDict:[[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID",@"true",@"Data", nil] mutableCopy]];
        }
}

-(void)isNPLButtonClicked:(UIButton*)sender{
    [sender setSelected:![sender isSelected]];
    [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForPartsNotNeeded:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ LineID:[self.mServicesDict objectForKey:KID] NPLDict:[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID",[sender isSelected]?@"true":@"false",@"Data", nil]];
    //    }
    //    else if([sender approvestate]==DECLINESTATE){
    //        [sender setApprovestate:UNDECIDEDSTATE];
    //        [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForApproveServiceLine:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ LineID:[self.mServicesDict objectForKey:KID] ApproveDict:[[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID", nil] mutableCopy]];
    //    }
    //    else if([sender approvestate]==UNDECIDEDSTATE){
    //        [sender setApprovestate:APPROVESTATE];
    //        [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForApproveServiceLine:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ LineID:[self.mServicesDict objectForKey:KID] ApproveDict:[[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID",@"true",@"Data", nil] mutableCopy]];
    //    }
}



-(void)isCellSwipedLeft:(BOOL)isTrue{
    //Approved is commented because of bleow.(08/23/14)
    //Make all lines in services screen able to be deleted, even if/when they are approved. (this is only in process RO's in the services check-in section, Open RO's continue to have normal ASR Pro permissions with deleting)

    if(/*([[self.mServicesDict objectForKey:KAPPROVED] boolValue]==FALSE)&&*/([[self.mServicesDict objectForKey:KDECLINED] boolValue]==FALSE)){
        [self.mDeleteButton_ setHidden:FALSE];
    }
}
-(void)resetCellView{
    [self.mDeleteButton_ setHidden:TRUE];
}
-(NSString*)getSubString:(NSString*)aSubStr{
    if(![[aSubStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])
        
        return [aSubStr substringToIndex:1];
    return @"";
}

@end
