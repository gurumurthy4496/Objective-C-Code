//
//  InspectionFormSliderView.m
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "InspectionFormSliderView.h"

@interface InspectionFormSliderView(){
    int yPos,xPos;
}
@property(nonatomic,retain) UIButton* mPlusBtn;
@property(nonatomic,retain) UIButton* mMinBtn;
@property (nonatomic,retain)UISlider *mSlider_;
@property (nonatomic,retain)UIView *mLabelAboveSlider_;
@property(nonatomic,retain)NSMutableArray* mSubitemsGreenArray_;
@property(nonatomic,retain)NSMutableArray* mSubitemsYellowArray_;
@property(nonatomic,retain)NSMutableArray* mSubitemsRedArray_;
@property(nonatomic,retain)NSMutableArray* mSubitemsArray_;
@property (nonatomic,retain) NSString*mColor;
@property (nonatomic,retain) NSString*mValue;
@property(nonatomic,retain) NSMutableArray* itemsarray;

@end


@implementation InspectionFormSliderView
@synthesize mItemDict_;
@synthesize mMinBtn;
@synthesize mPlusBtn;
@synthesize mSlider_;
@synthesize mLabelAboveSlider_;
@synthesize mSubitemsArray_;
@synthesize mSubitemsGreenArray_;
@synthesize mSubitemsYellowArray_;
@synthesize mSubitemsRedArray_;
@synthesize mValueDict_;
@synthesize mColor;
@synthesize mValue;
@synthesize itemsarray;
@synthesize mFormtype;
@synthesize mRONumber_;


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
-(void)initializeLaneInspectionView{
    [self initializeTheArrays];
    
    UIButton* lInspectionGreenButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, 25, 25)];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionGreenButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_green-inactive-btn"]];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionGreenButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_green-active-btn"]];
    lInspectionGreenButton.tag=1;
    if([mColor isEqualToString:@"Green"])
        [lInspectionGreenButton setSelected:YES];
    else
        if([mColor isEqualToString:@""])
            [lInspectionGreenButton setSelected:YES];
    
    [lInspectionGreenButton addTarget:self action:@selector(isButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lInspectionGreenButton];
    UIButton* lInspectionYellowButton=[[UIButton alloc]initWithFrame:CGRectMake(40, 5, 25, 25)];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionYellowButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_yellow-inactive-btn"]];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionYellowButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_yellow-active-btn"]];
    lInspectionYellowButton.tag=2;
    if([mColor isEqualToString:@"Yellow"])
        [lInspectionYellowButton setSelected:YES];
    
    [lInspectionYellowButton addTarget:self action:@selector(isButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lInspectionYellowButton];
    
    UIButton* lInspectionRedButton=[[UIButton alloc]initWithFrame:CGRectMake(70, 5, 25, 25)];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionRedButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_red-inactive-btn"]];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionRedButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_red-active-btn"]];
    lInspectionRedButton.tag=3;
    if([mColor isEqualToString:@"Red"])
        [lInspectionRedButton setSelected:YES];
    
    [lInspectionRedButton addTarget:self action:@selector(isButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lInspectionRedButton];
    UILabel* lInspectionLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 0, 210, 32)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lInspectionLabel labelTitleFont:[UIFont regularFontOfSize:13 fontKey:kFontNameHelveticaNeueKey] labelTitle:[mItemDict_ objectForKey:@"Name"] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [self addSubview:lInspectionLabel];
   if(isMandatory){
      UIImageView* lMandatoryView=[[UIImageView alloc] initWithFrame:CGRectMake(690, 10, 6, 6)];
      [lMandatoryView setImage:[UIImage imageNamed:@"IMG_mandatory-icon"]];
      [self addSubview:lMandatoryView];
   }
    
    
    CGRect frame=self.frame;
    xPos=10;
    yPos=40;
    if(([mSubitemsArray_ count]>0)||([mSubitemsGreenArray_ count]>0)||([mSubitemsRedArray_ count]>0)||([mSubitemsYellowArray_ count]>0)){
        [self displaySliderTopValues];
        if(xPos==165)
            yPos+=40;
        
        frame.size.height=yPos;
        
    }
    else
        frame.size.height=40;
    
    self.frame=frame;
    
}


-(void)addViewToFinishInspection{
    [self initializeTheArrays];
    
    UIButton* lInspectionGreenButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, 25, 25)];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionGreenButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_green-inactive-btn"]];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionGreenButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_green-active-btn"]];
    lInspectionGreenButton.tag=1;
    if([mColor isEqualToString:@"Green"])
        [lInspectionGreenButton setSelected:YES];
    else
        if([mColor isEqualToString:@""])
            [lInspectionGreenButton setSelected:YES];
    
    [lInspectionGreenButton addTarget:self action:@selector(isButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lInspectionGreenButton];
    UIButton* lInspectionYellowButton=[[UIButton alloc]initWithFrame:CGRectMake(40, 5, 25, 25)];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionYellowButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_yellow-inactive-btn"]];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionYellowButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_yellow-active-btn"]];
    lInspectionYellowButton.tag=2;
    if([mColor isEqualToString:@"Yellow"])
        [lInspectionYellowButton setSelected:YES];
    
    [lInspectionYellowButton addTarget:self action:@selector(isButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lInspectionYellowButton];
    
    UIButton* lInspectionRedButton=[[UIButton alloc]initWithFrame:CGRectMake(70, 5, 25, 25)];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionRedButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_red-inactive-btn"]];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionRedButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_red-active-btn"]];
    lInspectionRedButton.tag=3;
    if([mColor isEqualToString:@"Red"])
        [lInspectionRedButton setSelected:YES];
    
    [lInspectionRedButton addTarget:self action:@selector(isButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lInspectionRedButton];
    UILabel* lInspectionLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 0, 110, 32)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lInspectionLabel labelTitleFont:[UIFont regularFontOfSize:13 fontKey:kFontNameHelveticaNeueKey] labelTitle:[mItemDict_ objectForKey:@"Name"] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [self addSubview:lInspectionLabel];
     if(isMandatory){
         UIImageView* lMandatoryView=[[UIImageView alloc] initWithFrame:CGRectMake(675, 10, 6, 6)];
         [lMandatoryView setImage:[UIImage imageNamed:@"IMG_mandatory-icon"]];
          [self addSubview:lMandatoryView];
        }
   
    
    CGRect frame=self.frame;
    xPos=10;
    yPos=40;
    if(([mSubitemsArray_ count]>0)||([mSubitemsGreenArray_ count]>0)||([mSubitemsRedArray_ count]>0)||([mSubitemsYellowArray_ count]>0)){
        [self displaySliderTopValuesInspection];
        if(xPos==165)
            yPos+=40;
        
        frame.size.height=yPos;
        
    }
    else
        frame.size.height=40;
    
    self.frame=frame;
    
}

-(void)displaySliderTopValues {
    [self.superview setUserInteractionEnabled:YES];
    [self setUserInteractionEnabled:YES];
    itemsarray=[[NSMutableArray alloc] init];
    [itemsarray addObjectsFromArray:mSubitemsRedArray_];
    [itemsarray addObjectsFromArray:mSubitemsYellowArray_];
    [itemsarray addObjectsFromArray:mSubitemsGreenArray_];
    
    if([itemsarray count]>0){
        CGRect frame = CGRectMake(340, 0,310,15);
        mLabelAboveSlider_ = [[UIView alloc] initWithFrame:frame];
        float width=(315-(12*[itemsarray count]) )/([itemsarray count]-1);
        UIButton *lMinButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
        [lMinButton_ setFrame:CGRectMake(305, 5, 25, 25)];
        [lMinButton_ setBackgroundImage:[UIImage imageNamed:@"IMG_minus-icon.png"] forState:UIControlStateNormal];
        [lMinButton_ setTag:100];
        [lMinButton_ addTarget:self action:@selector(decrementButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [lMinButton_ setUserInteractionEnabled:YES];
        [self addSubview:lMinButton_];
        for(int i=0;i<[itemsarray count];i++){
            UILabel *mlabel=[[UILabel alloc]initWithFrame:CGRectMake((i*(width+12)), 3.0,15, 15)];
            [mlabel setBackgroundColor:[UIColor clearColor]];
            [mlabel setText:[[NSString stringWithFormat:@"%@",[itemsarray objectAtIndex:i]] stringByReplacingOccurrencesOfString:@" " withString:@""]];
            [mlabel setFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey]];
            [mlabel setTextColor:[UIColor ASRProRGBColor:24 Green:100 Blue:250]];
            [mLabelAboveSlider_ addSubview:mlabel];
        }
        [self addSubview:mLabelAboveSlider_];
            frame = CGRectMake(340, 20, 310, 10.0);
        
        mSlider_ = [[UISlider alloc] initWithFrame:frame];
        [mSlider_ addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
        [mSlider_ addTarget:self action:@selector(sendRequest:) forControlEvents:UIControlEventTouchUpInside];
        [mSlider_ setBackgroundColor:[UIColor clearColor]];
        mSlider_.minimumValue = 1.0;
        mSlider_.maximumValue = [itemsarray count];
        mSlider_.continuous = YES;
        [mSlider_ setUserInteractionEnabled:YES];
        
        [mSlider_ setThumbImage: [UIImage imageNamed:@"IMG_slider-handler.png"]  forState:UIControlStateNormal];
        [mSlider_ setThumbImage: [UIImage imageNamed:@"IMG_slider-handler.png"]  forState:UIControlStateHighlighted];
        mSlider_.value=[mValue floatValue];
        
        [mSlider_ setMinimumTrackImage:[[UIImage imageNamed:@"IMG_tracker_selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)] forState:UIControlStateNormal];
        [mSlider_ setMaximumTrackImage:[[UIImage imageNamed:@"IMG_tracker_unselected"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0,10)] forState:UIControlStateNormal];
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sliderTapped:)] ;
        [mSlider_ addGestureRecognizer:gr];
        [self addSubview:mSlider_];
        
        UIButton *lPlusButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
        [lPlusButton_ setFrame:CGRectMake(660, 5, 25, 25)];
        [lPlusButton_ setBackgroundImage:[UIImage imageNamed:@"IMG_plus-icon.png"] forState:UIControlStateNormal];
        [lPlusButton_ setTag:101];
        [lPlusButton_ addTarget:self action:@selector(incrementButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [lPlusButton_ setUserInteractionEnabled:YES];
        [self addSubview:lPlusButton_];
    }
    yPos=40;
    
    [self addRadioButtons];
}


-(void)displaySliderTopValuesInspection {
    [self.superview setUserInteractionEnabled:YES];
    [self setUserInteractionEnabled:YES];
    itemsarray=[[NSMutableArray alloc] init];
    [itemsarray addObjectsFromArray:mSubitemsRedArray_];
    [itemsarray addObjectsFromArray:mSubitemsYellowArray_];
    [itemsarray addObjectsFromArray:mSubitemsGreenArray_];
    
    if([itemsarray count]>0){
        CGRect frame = CGRectMake(240, 0,310,15);
        mLabelAboveSlider_ = [[UIView alloc] initWithFrame:frame];
        float width=(315-(12*[itemsarray count]) )/([itemsarray count]-1);
        UIButton *lMinButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
        [lMinButton_ setFrame:CGRectMake(205, 5, 25, 25)];
        [lMinButton_ setBackgroundImage:[UIImage imageNamed:@"IMG_minus-icon.png"] forState:UIControlStateNormal];
        [lMinButton_ setTag:100];
        [lMinButton_ addTarget:self action:@selector(decrementButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [lMinButton_ setUserInteractionEnabled:YES];
        [self addSubview:lMinButton_];
        for(int i=0;i<[itemsarray count];i++){
            UILabel *mlabel=[[UILabel alloc]initWithFrame:CGRectMake((i*(width+12)), 3.0,15, 15)];
            [mlabel setBackgroundColor:[UIColor clearColor]];
            [mlabel setText:[[NSString stringWithFormat:@"%@",[itemsarray objectAtIndex:i]] stringByReplacingOccurrencesOfString:@" " withString:@""]];
            [mlabel setFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey]];
            [mlabel setTextColor:[UIColor ASRProRGBColor:24 Green:100 Blue:250]];
            [mLabelAboveSlider_ addSubview:mlabel];
        }
        [self addSubview:mLabelAboveSlider_];
        frame = CGRectMake(240, 20, 310, 10.0);
        
        mSlider_ = [[UISlider alloc] initWithFrame:frame];
        [mSlider_ addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
        [mSlider_ addTarget:self action:@selector(sendRequest:) forControlEvents:UIControlEventTouchUpInside];
        [mSlider_ setBackgroundColor:[UIColor clearColor]];
        mSlider_.minimumValue = 1.0;
        mSlider_.maximumValue = [itemsarray count];
        mSlider_.continuous = YES;
        [mSlider_ setUserInteractionEnabled:YES];
        
        [mSlider_ setThumbImage: [UIImage imageNamed:@"IMG_slider-handler.png"]  forState:UIControlStateNormal];
        [mSlider_ setThumbImage: [UIImage imageNamed:@"IMG_slider-handler.png"]  forState:UIControlStateHighlighted];
        mSlider_.value=[mValue floatValue];
        
        [mSlider_ setMinimumTrackImage:[[UIImage imageNamed:@"IMG_tracker_selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)] forState:UIControlStateNormal];
        [mSlider_ setMaximumTrackImage:[[UIImage imageNamed:@"IMG_tracker_unselected"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0,10)] forState:UIControlStateNormal];
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sliderTapped:)] ;
        [mSlider_ addGestureRecognizer:gr];
        [self addSubview:mSlider_];
        
        UIButton *lPlusButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
        [lPlusButton_ setFrame:CGRectMake(560, 5, 25, 25)];
        [lPlusButton_ setBackgroundImage:[UIImage imageNamed:@"IMG_plus-icon.png"] forState:UIControlStateNormal];
        [lPlusButton_ setTag:101];
        [lPlusButton_ addTarget:self action:@selector(incrementButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [lPlusButton_ setUserInteractionEnabled:YES];
        [self addSubview:lPlusButton_];
    }
    yPos=40;
    
    [self addRadioButtons];
}
-(void)addRadioButtons{
    for (int i=0;i<[mSubitemsArray_ count];i++){
        InspectionButton* lInspectionCheckButton=[[InspectionButton alloc]initWithFrame:CGRectMake(610, 5, 50, 25)];
        [[GenericFiles genericFiles]createUIButtonInstance:lInspectionCheckButton buttonTitle:[[NSString stringWithFormat:@"%@",[mSubitemsArray_ objectAtIndex:i]] stringByReplacingOccurrencesOfString:@" " withString:@""] buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:(153.0/255.0) green:(153.0/255.0) blue:(153.0/255.0) alpha:1.0]]];
        [[GenericFiles genericFiles]createUIButtonInstance:lInspectionCheckButton buttonTitle:[[NSString stringWithFormat:@"%@",[mSubitemsArray_ objectAtIndex:i]] stringByReplacingOccurrencesOfString:@" " withString:@""] buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]]];
        lInspectionCheckButton.tag=10+i;
        [lInspectionCheckButton addTarget:self action:@selector(isCheckButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        if([mValue isEqualToString:[NSString stringWithFormat:@"%@",[mSubitemsArray_ objectAtIndex:i]]])
            [lInspectionCheckButton setSelected:YES];
        [lInspectionCheckButton setMButtonName:[NSString stringWithFormat:@"%@",[mSubitemsArray_ objectAtIndex:i]]];
        [self addSubview:lInspectionCheckButton];
//        UILabel* lInspectionLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos+30, yPos, 200, 32)];
//        [[GenericFiles genericFiles] createUILabelWithInstance:lInspectionLabel labelTitleFont:[UIFont regularFontOfSize:13 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[mSubitemsArray_ objectAtIndex:i]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
//        // [lInspectionLabel setNumberOfLines:0];
//        
//        [self addSubview:lInspectionLabel];
        //   xPos=(xPos==10)?165:10;
        //  if(xPos==10)
        yPos+=40;
        
    }
}

-(void)isCheckButtonSelected:(InspectionButton*)sender{
    [sender setSelected:YES];
    mSlider_.value=0;
    [self setMValue:sender.mButtonName];
    [self setMColor:@"Clear"];
    [self.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[UIButton class]]) {
            UIButton* tempBtn=(UIButton *)object;
            if (tempBtn.tag !=sender.tag)
                [tempBtn setSelected:NO];
        }
    }];
    
    [self sendRequestForAddItem];
    
}
-(void)isButtonSelected:(UIButton*)sender{
    [self.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[UIButton class]]) {
            UIButton* tempBtn=(UIButton *)object;
            if (tempBtn.tag !=sender.tag)
                [tempBtn setSelected:NO];
            else if(tempBtn.tag==sender.tag){
                
                if(![tempBtn isSelected]){
                    [tempBtn setSelected:YES];
                    
                    switch (sender.tag) {
                        case 1:{
                            mColor=@"Green";
                            mSlider_.value=[[mSubitemsGreenArray_ objectAtIndex:0]intValue];
                        }
                            break;
                        case 2:{
                            mColor=@"Yellow";
                            mSlider_.value=[[mSubitemsYellowArray_ objectAtIndex:0]intValue];
                            
                        }
                            break;
                        case 3:{
                            mColor=@"Red";
                            mSlider_.value=[[mSubitemsRedArray_ objectAtIndex:0]intValue];
                            
                        }
                            break;
                        default:
                            break;
                            
                    }
                    [self setMValue:[NSString stringWithFormat:@"%@",[itemsarray objectAtIndex:mSlider_.value-1]]];
                }
                if((tempBtn.tag>1)&&[tempBtn isSelected]){
                    [self showAddservicePopupView:tempBtn.tag];
                }
                
            }
            
        }
    }];
    [self sendRequestForAddItem];
    
}


-(void)initializeTheArrays{
    self.mColor=(mValueDict_!=nil)?[NSString stringWithFormat:@"%@",[mValueDict_ objectForKey:@"Color"]]:@"";
    self.mValue=(mValueDict_!=nil)?[NSString stringWithFormat:@"%@",[mValueDict_ objectForKey:@"Value"]]:@"";
    isMandatory=[[mItemDict_ objectForKey:@"Required"] boolValue];
    isAdded=(mValueDict_!=nil)?YES:NO;
    
    if(![[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItems"]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
        mSubitemsArray_=[[[[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItems"] ]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]] componentsSeparatedByString:@","] mutableCopy];
    if(![[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItemsGreen"]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
        mSubitemsGreenArray_=[[[[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItemsGreen"] ]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]] componentsSeparatedByString:@","] mutableCopy];
    if(![[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItemsRed"]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
        mSubitemsRedArray_=[[[[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItemsRed"] ]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]] componentsSeparatedByString:@","] mutableCopy];
    if(![[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItemsYellow"]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
        mSubitemsYellowArray_=[[[[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItemsYellow"] ]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]] componentsSeparatedByString:@","] mutableCopy];
    mGreenValue=[[self.mSubitemsGreenArray_ objectAtIndex:([mSubitemsGreenArray_ count]-1)] intValue];
    mYellowValue=[[self.mSubitemsYellowArray_ objectAtIndex:([mSubitemsYellowArray_ count]-1)] intValue];
    mRedValue=[[self.mSubitemsRedArray_ objectAtIndex:([mSubitemsRedArray_ count]-1)] intValue];
}

#pragma mark -  ******************* Button and Slider Action methods ******************

-(void)incrementButtonClicked:(id)sender
{
    [mSlider_ setValue:mSlider_.value+1];
    [self setMValue:[NSString stringWithFormat:@"%@",[itemsarray objectAtIndex:mSlider_.value-1]]];
    if((mSlider_.value<=mRedValue)&&(mSlider_.value>=1)) {
        mColor=@"Red";
        [self changeButtonState:3];
    } else if ((mSlider_.value<=mYellowValue)&&(mSlider_.value>mRedValue)) {
        mColor=@"Yellow";
        [self changeButtonState:2];
        
        
    } else {
        mColor=@"Green";
        [self changeButtonState:1];
        
    }
    [self sendRequestForAddItem];
    
}
-(void)decrementButtonClicked:(id)sender
{
    [mSlider_ setValue:mSlider_.value-1];
    [self setMValue:[NSString stringWithFormat:@"%@",[itemsarray objectAtIndex:mSlider_.value-1]]];
    if((mSlider_.value<=mRedValue)&&(mSlider_.value>=1)) {
        mColor=@"Red";
        [self changeButtonState:3];
        
    } else if ((mSlider_.value<=mYellowValue)&&(mSlider_.value>mRedValue)) {
        mColor=@"Yellow";
        [self changeButtonState:2];
        
    } else {
        mColor=@"Green";
        [self changeButtonState:1];
        
    }
    
    [self sendRequestForAddItem];
}

-(void)changeButtonState:(int)tag{
    [self.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[UIButton class]]) {
            UIButton* tempBtn=(UIButton *)object;
            if (tempBtn.tag !=tag)
                [tempBtn setSelected:NO];
            else if(tempBtn.tag==tag)
                [tempBtn setSelected:YES];
        }
    }];
    if(tag>1){
        [self showAddservicePopupView:tag];
    }
    
}

//-------------------------------------- ************** ----------------------------------------
//                         *** slider action when value is changing  ***
//-------------------------------------- ************** ----------------------------------------
-(void)changeValue:(id)sender
{
    int discreteValue = roundl([mSlider_ value]); // Rounds float to an integer
    [mSlider_ setValue:(float)discreteValue];
    [self setMValue:[NSString stringWithFormat:@"%@",[itemsarray objectAtIndex:mSlider_.value-1]]];
    if((mSlider_.value<=mRedValue)&&(mSlider_.value>=1)) {
        mColor=@"Red";
        [self changeButtonState:3];
        
    } else if ((mSlider_.value<=mYellowValue)&&(mSlider_.value>mRedValue)) {
        mColor=@"Yellow";
        [self changeButtonState:2];
        
        
    } else {
        mColor=@"Green";
        [self changeButtonState:1];
        
        
    }
    
}
-(void)sendRequest:(id)sender{
    [self sendRequestForAddItem];
}
//-------------------------------------- ************** ----------------------------------------
//                         *** slider action when value is changed  ***
//-------------------------------------- ************** ----------------------------------------
-(void)sendRequestForAddItem{
    isAdded=YES;
    
    if(mValueDict_!=nil){
        [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForOpenROInspectionFormWebEngine_ requestForUpdateInspectionItem:mRONumber_ itemID:[mValueDict_ objectForKey:@"ASRIID"] requestDict:[[NSDictionary dictionaryWithObjectsAndKeys:mColor,@"Color",mValue ,@"Value",nil] mutableCopy] ];
    }
    else
        [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForOpenROInspectionFormWebEngine_ requestForAddInspectionItem:mRONumber_ requestDict:[[NSDictionary dictionaryWithObjectsAndKeys:[mItemDict_ objectForKey:@"IIID" ],@"IIID",mColor,@"Color",mValue ,@"Value", nil] mutableCopy] ] ;
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mFinishInspectionViewController_] setCompleteInspectionButton];

    
}


- (void)sliderTapped:(UIGestureRecognizer *)g {
    UISlider* s = (UISlider*)g.view;
    if (s.highlighted)
        return; // tap on thumb, let slider deal with it
    CGPoint pt = [g locationInView: s];
    CGFloat percentage = pt.x / s.bounds.size.width;
    CGFloat delta = percentage * (s.maximumValue - s.minimumValue);
    CGFloat value = s.minimumValue + delta;
    int a=value+0.5;
    [mSlider_ setValue:a];
    self.mValue=[NSString stringWithFormat:@"%0.2f",mSlider_.value];
    if((mSlider_.value<=mRedValue)&&(mSlider_.value>=1)) {
        mColor=@"Red";
        [self changeButtonState:3];
    } else if ((mSlider_.value<=mYellowValue)&&(mSlider_.value>mRedValue)) {
        mColor=@"Yellow";
        [self changeButtonState:2];
        
    } else {
        mColor=@"Green";
        [self changeButtonState:1];
    }
    [self sendRequestForAddItem];
    
}

-(void)showAddservicePopupView:(int)tag{
    [self.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[UIButton class]]) {
            UIButton* tempBtn=(UIButton *)object;
            if(tempBtn.tag==tag)
            {
                NSMutableArray* ltempArray=[self.mItemDict_ objectForKey:@"SelectedServices"];
                if([ltempArray count]>0)
                    if(mFormtype==LANEINSPECTION)
                        [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_ ]mWalkAroundLaneInspectionView] addServicePopupView:tempBtn.frame.origin.x :tempBtn.frame.origin.y+self.frame.origin.y :ltempArray:tag :3];
                    if(mFormtype==MAININSPECTION)
                        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mFinishInspectionViewController_ ] addServicePopupView:tempBtn.frame.origin.x :tempBtn.frame.origin.y+self.frame.origin.y :ltempArray:tag :3];

            }
        }
    }];
}

@end
