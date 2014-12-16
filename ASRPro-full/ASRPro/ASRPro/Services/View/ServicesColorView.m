//
//  ServicesColorView.m
//  ASRPro
//
//  Created by Kalyani on 17/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ServicesColorView.h"

@interface ServicesColorView()
@property (nonatomic,retain) UIButton* mYellowColorBtn_;
@property (nonatomic,retain) UIButton* mRedColorBtn_;


@end

@implementation ServicesColorView

@synthesize mRedColorBtn_;
@synthesize mYellowColorBtn_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initTheViews];
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

-(void)initTheViews{
    UIButton *lTempYellowButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 0,400, 40)];
    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:lTempYellowButton buttonTitle:KMAYREQUIREATTENTION buttonTitleColor:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] buttonTitleEdgeInsets:UIEdgeInsetsMake(10, 30, 10, 0) buttonImage:kSELECT_YELLOW_IMAGE_RECOMMENDED buttonImageEdgeInsets:UIEdgeInsetsMake(9, 10, 9, 10) controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundColor:[UIColor clearColor]];
    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:lTempYellowButton buttonTitle:KMAYREQUIREATTENTION buttonTitleColor:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] buttonTitleEdgeInsets:UIEdgeInsetsMake(10, 30, 10, 0) buttonImage:kUNSELECT_YELLOW_IMAGE_RECOMMENDED buttonImageEdgeInsets:UIEdgeInsetsMake(9, 10, 9, 10) controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundColor:[UIColor clearColor]];
    
    lTempYellowButton.tag=1;
    [lTempYellowButton addTarget:self action:@selector(isRadioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [lTempYellowButton setContentMode:UIViewContentModeCenter];
    [self setMYellowColorBtn_:lTempYellowButton];
    
    [self addSubview:self.mYellowColorBtn_];


//    UILabel* lTempYellowColorLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 10, 300, 20)];
//    [[GenericFiles genericFiles] createUILabelWithInstance:lTempYellowColorLabel labelTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontBoldKey] labelTitle:KMAYREQUIREATTENTION labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
//    [self addSubview:lTempYellowColorLabel];
//
    
    UIButton *lTempRedButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 40,400, 40)];
    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:lTempRedButton buttonTitle:KREQUIREATTENTION buttonTitleColor:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] buttonTitleEdgeInsets:UIEdgeInsetsMake(10, 30, 10, 0) buttonImage:kSELECT_RED_IMAGE_RECOMMENDED buttonImageEdgeInsets:UIEdgeInsetsMake(9, 10, 9, 10) controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundColor:[UIColor clearColor]];
    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:lTempRedButton buttonTitle:KREQUIREATTENTION buttonTitleColor:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] buttonTitleEdgeInsets:UIEdgeInsetsMake(10, 30, 10, 0) buttonImage:kUNSELECT_RED_IMAGE_RECOMMENDED buttonImageEdgeInsets:UIEdgeInsetsMake(9, 10, 9, 10) controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundColor:[UIColor clearColor]];
    lTempRedButton.tag=2;

    [lTempRedButton addTarget:self action:@selector(isRadioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self setMRedColorBtn_:lTempRedButton];
    [self addSubview:mRedColorBtn_];

    UIView* lDividerView=[[UIView alloc] initWithFrame:CGRectMake(0, 79, self.frame.size.width, 1)] ;
    [lDividerView setBackgroundColor:[UIColor colorWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1.0]];
    [self addSubview:lDividerView];

}

-(void)setValue:(NSString*)aValue{
    if([aValue isEqualToString: @"Yellow"])
       [mYellowColorBtn_ setSelected:YES];
    else
        [mYellowColorBtn_ setSelected:NO];
    if([aValue isEqualToString: @"Red"])
        [mRedColorBtn_ setSelected:YES];
    else
        [mRedColorBtn_ setSelected:NO];
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mModelForSelectedService_ setMColor_:aValue];
}

-(void)isRadioButtonClicked:(UIButton*)sender{
    if(sender.tag==1)
       [self setValue:[sender isSelected]?@"":@"Yellow"];
    if(sender.tag==2)
        [self setValue:[sender isSelected]?@"":@"Red"];
}

@end
