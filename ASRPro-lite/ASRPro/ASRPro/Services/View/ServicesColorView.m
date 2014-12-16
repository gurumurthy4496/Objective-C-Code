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
    UIButton *lTempYellowButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5,30, 30)];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempYellowButton buttonTitle:@"" buttonTitleColor:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontBoldKey] controlState:UIControlStateSelected buttoncontentEdgeInsets: UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundImage:kSELECT_YELLOW_IMAGE_RECOMMENDED];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempYellowButton buttonTitle:@"" buttonTitleColor:[UIColor grayColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontBoldKey] controlState:UIControlStateNormal buttoncontentEdgeInsets: UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundImage:kUNSELECT_YELLOW_IMAGE_RECOMMENDED];
    lTempYellowButton.tag=1;
    [lTempYellowButton addTarget:self action:@selector(isRadioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self setMYellowColorBtn_:lTempYellowButton];
    [self addSubview:self.mYellowColorBtn_];


    UILabel* lTempYellowColorLabel=[[UILabel alloc] initWithFrame:CGRectMake(50, 10, 300, 20)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempYellowColorLabel labelTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontBoldKey] labelTitle:KMAYREQUIREATTENTION labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [self addSubview:lTempYellowColorLabel];

    
    UIButton *lTempRedButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 55,30, 30)];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempRedButton buttonTitle:@"" buttonTitleColor:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontBoldKey] controlState:UIControlStateSelected buttoncontentEdgeInsets: UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundImage:kSELECT_RED_IMAGE_RECOMMENDED];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempRedButton buttonTitle:@"" buttonTitleColor:[UIColor grayColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontBoldKey] controlState:UIControlStateNormal buttoncontentEdgeInsets: UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundImage:kUNSELECT_RED_IMAGE_RECOMMENDED];
    lTempRedButton.tag=2;
    [lTempRedButton addTarget:self action:@selector(isRadioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self setMRedColorBtn_:lTempRedButton];
    [self addSubview:mRedColorBtn_];

    UILabel* lTempRedColorLabel=[[UILabel alloc] initWithFrame:CGRectMake(50, 60, 300, 20)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempRedColorLabel labelTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontBoldKey] labelTitle:KREQUIREATTENTION labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [self addSubview:lTempRedColorLabel];
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
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mModelForSelectedService_ mColor_];
}

-(void)isRadioButtonClicked:(UIButton*)sender{
    if(sender.tag==1)
       [self setValue:[sender isSelected]?@"":@"Yellow"];
    if(sender.tag==2)
        [self setValue:[sender isSelected]?@"":@"Red"];
}

@end
