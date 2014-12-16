//
//  PartsLabourCellViewCell.m
//  ASRPro
//
//  Created by Kalyani on 06/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "PartsLabourCellViewCell.h"

@interface PartsLabourCellViewCell(){
    
}
@property(nonatomic,retain) UIButton* mEditButton_;
@property(nonatomic,retain) UILabel* mQualityLabel_;
@property(nonatomic,retain) UILabel* mQuantityLabel_;
@property(nonatomic,retain) UILabel* mDescriptionLabel_;
@property(nonatomic,retain) UILabel* mLocationLabel_;
@property(nonatomic,retain) UILabel* mPriceLabel_;
@property(nonatomic,retain) UILabel* mPartNumberLabel_;
@end


@implementation PartsLabourCellViewCell
@synthesize mEditButton_;
@synthesize mQualityLabel_;
@synthesize mDescriptionLabel_;
@synthesize mLocationLabel_;
@synthesize mPartNumberLabel_;
@synthesize mPriceLabel_;
@synthesize mQuantityLabel_;
@synthesize mServicesDict;


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
         [ self.contentView setBackgroundColor:[UIColor whiteColor]];
    
    [self addCurrentServicesCell];
}

-(void)removeSubviews{
    for (UIView *subview in [self.contentView subviews])
    {
        [subview removeFromSuperview];
    }
    
}

-(void)addCurrentServicesCell{
    int xPos=10;
    //Service Label
    UILabel* lTempQualityLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 10, 90, 20)];
    [lTempQualityLabel setTag:0];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempQualityLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mQualityArray_ objectAtIndex:[[mServicesDict objectForKey:@"QualityID"] intValue]]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [self setMQualityLabel_:lTempQualityLabel];
    [self.contentView addSubview:self.mQualityLabel_];
    xPos+=100;
    
    UILabel* lTempQuantityLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 10, 90, 20)];
    [lTempQuantityLabel setTag:1];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempQuantityLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[mServicesDict objectForKey:@"Quantity"]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [self setMQuantityLabel_:lTempQuantityLabel];
    [self.contentView addSubview:self.mQuantityLabel_];
    xPos+=100;
    
    UILabel* lTempPartsNumberLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 10, 110, 20)];
    [lTempPartsNumberLabel setTag:2];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempPartsNumberLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[mServicesDict objectForKey:@"PartNumber"]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [self setMPartNumberLabel_:lTempPartsNumberLabel];
    [self.contentView addSubview:mPartNumberLabel_];
    xPos+=120;
    
    UILabel* lTempDescriptionLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 10, 350, 20)];
    [lTempDescriptionLabel setTag:3];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempDescriptionLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[mServicesDict objectForKey:@"Description"]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [self setMDescriptionLabel_:lTempDescriptionLabel];
    [mDescriptionLabel_ setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.contentView addSubview:mDescriptionLabel_];
    xPos+=360;

    
    UILabel* lTempLocationLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 10, 150, 20)];
    [lTempLocationLabel setTag:4];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempLocationLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_ getLocationName:[[mServicesDict objectForKey:@"LocationID"] intValue]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [self setMLocationLabel_:lTempLocationLabel];
    [self.contentView addSubview:mLocationLabel_];
    xPos+=160;
    
    
    //Price Label
    UILabel* lTempPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 10, 100, 20)];
    [lTempPriceLabel setTag:5];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempPriceLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[mServicesDict objectForKey:@"Price"]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [self setMPriceLabel_:lTempPriceLabel];
    [self.contentView addSubview:mPriceLabel_];
    xPos+=110;


    //Edit Buton
    UIButton* lTempEditButton = [[UIButton alloc] initWithFrame:CGRectMake(xPos, 10, 20, 20)];
    [lTempEditButton setTag:6];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempEditButton buttonTitle:@"" buttonTitleColor:[UIColor clearColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"edit_blue.png"]];
    [lTempEditButton addTarget:self action:@selector(isEditButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setMEditButton_:lTempEditButton];
    [self.contentView addSubview:mEditButton_];
    xPos+=EDIT_BUTTON_WIDTH_RECOMMENDED+5;
    
}

-(void)isEditButtonClicked:(UIButton*)sender{
    mAppDelegate_.mPartLabourDataGetter_->isAdd=FALSE;
    [mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_ setDictToModel:mServicesDict];
    [mAppDelegate_.mPartLabourDataGetter_.mPartsLabourMainViewController_ ShowEditPartsPopUp];
    mAppDelegate_.mPartLabourDataGetter_.mPartsLaborMainSubview=mPartsLaborMainSubview_;
    mPartsLaborMainSubview_->index=self.contentView.tag;
    
}


@end
