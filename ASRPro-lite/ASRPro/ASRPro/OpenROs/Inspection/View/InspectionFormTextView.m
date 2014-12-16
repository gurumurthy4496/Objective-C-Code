//
//  InspectionFormTextView.m
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "InspectionFormTextView.h"

@interface InspectionFormTextView(){
    UIToolbar  *mToolBar_;
}
@property(nonatomic,retain) UITextView *mTextView_;
@property (nonatomic,retain) NSString*mColor;
@property (nonatomic,retain) NSString*mValue;

@end

@implementation InspectionFormTextView

@synthesize mItemDict_;
@synthesize mValueDict_;
@synthesize mTextView_;
@synthesize mColor;
@synthesize mValue;
@synthesize mRONumber_;
@synthesize mFormtype;


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
    isMandatory=[[mItemDict_ objectForKey:@"Required"] boolValue];
    isAdded=(mValueDict_!=nil)?YES:NO;
    self.mColor=(mValueDict_!=nil)?[NSString stringWithFormat:@"%@",[mValueDict_ objectForKey:@"Color"]]:@"";
    self.mValue=(mValueDict_!=nil)?[NSString stringWithFormat:@"%@",[mValueDict_ objectForKey:@"Value"]]:@"";
    
    UIButton* lInspectionGreenButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, 25, 25)];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionGreenButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_green-inactive-btn"]];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionGreenButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_green-active-btn"]];
    lInspectionGreenButton.tag=1;
    if(mValueDict_!=nil){
        if([[NSString stringWithFormat:@"%@",[mValueDict_ objectForKey:@"Color"]] isEqualToString:@"Green"])
            [lInspectionGreenButton setSelected:YES];
    }else
        [lInspectionGreenButton setSelected:YES];
    
    [lInspectionGreenButton addTarget:self action:@selector(isButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lInspectionGreenButton];
    UIButton* lInspectionYellowButton=[[UIButton alloc]initWithFrame:CGRectMake(40, 5, 25, 25)];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionYellowButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_yellow-inactive-btn"]];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionYellowButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_yellow-active-btn"]];
    lInspectionYellowButton.tag=2;
    if(mValueDict_!=nil)
        if([[NSString stringWithFormat:@"%@",[mValueDict_ objectForKey:@"Color"]] isEqualToString:@"Yellow"])
            [lInspectionYellowButton setSelected:YES];
    
    [lInspectionYellowButton addTarget:self action:@selector(isButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lInspectionYellowButton];
    
    UIButton* lInspectionRedButton=[[UIButton alloc]initWithFrame:CGRectMake(70, 5, 25, 25)];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionRedButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_red-inactive-btn"]];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionRedButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_red-active-btn"]];
    lInspectionRedButton.tag=3;
    if(mValueDict_!=nil)
        if([[NSString stringWithFormat:@"%@",[mValueDict_ objectForKey:@"Color"]] isEqualToString:@"Red"])
            [lInspectionRedButton setSelected:YES];
    
    [lInspectionRedButton addTarget:self action:@selector(isButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lInspectionRedButton];
    //    int height=  [[GenericFiles genericFiles] dynamiclabelHeightForText:[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"Name"]] :200 :[UIFont regularFontOfSize:13 fontKey:kFontNameHelveticaNeueKey]];
    //    if(height>32)
    //        height=32;
    UILabel* lInspectionLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, 32)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lInspectionLabel labelTitleFont:[UIFont regularFontOfSize:13 fontKey:kFontNameHelveticaNeueKey] labelTitle:[mItemDict_ objectForKey:@"Name"] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:lInspectionLabel];
    
    if(isMandatory){
        UIImageView* lMandatoryView=[[UIImageView alloc] initWithFrame:CGRectMake(690, 10, 6, 6)];
        [lMandatoryView setImage:[UIImage imageNamed:@"IMG_mandatory-icon"]];
        [self addSubview:lMandatoryView];
    }

    
    UITextView* lInspectionTextView=[[UITextView alloc] initWithFrame:CGRectMake(330, 40, 300, 100)];
    [self setMTextView_:lInspectionTextView];
    [self.mTextView_ setTextColor:[UIColor blackColor]];
    [self.mTextView_ setUserInteractionEnabled:YES];
    self.mTextView_.layer.borderWidth = 1.0f;
    [self.mTextView_.layer setCornerRadius:10.0];
    self.mTextView_.layer.borderColor = [[UIColor grayColor] CGColor];
    self.mTextView_.layer.backgroundColor=[[UIColor whiteColor] CGColor];
    [self.mTextView_ setFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey]];
    [self.mTextView_ setReturnKeyType:UIReturnKeyDefault];
    self.mTextView_.enablesReturnKeyAutomatically=NO;
    [self.mTextView_ setText:self.mValue];
    
    [self inputviewForKeyboard];
    [self addSubview:mTextView_];
    
    CGRect frame=self.frame;
    frame.size.height=110;
    self.frame=frame;
    
}


-(void)addViewToFinishInspection{
    isMandatory=[[mItemDict_ objectForKey:@"Required"] boolValue];
    isAdded=(mValueDict_!=nil)?YES:NO;
    self.mColor=(mValueDict_!=nil)?[NSString stringWithFormat:@"%@",[mValueDict_ objectForKey:@"Color"]]:@"";
    self.mValue=(mValueDict_!=nil)?[NSString stringWithFormat:@"%@",[mValueDict_ objectForKey:@"Value"]]:@"";
    
    UIButton* lInspectionGreenButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, 25, 25)];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionGreenButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_green-inactive-btn"]];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionGreenButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_green-active-btn"]];
    lInspectionGreenButton.tag=1;
    if(mValueDict_!=nil){
        if([[NSString stringWithFormat:@"%@",[mValueDict_ objectForKey:@"Color"]] isEqualToString:@"Green"])
            [lInspectionGreenButton setSelected:YES];
    }else
        [lInspectionGreenButton setSelected:YES];
    
    [lInspectionGreenButton addTarget:self action:@selector(isButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lInspectionGreenButton];
    UIButton* lInspectionYellowButton=[[UIButton alloc]initWithFrame:CGRectMake(40, 5, 25, 25)];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionYellowButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_yellow-inactive-btn"]];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionYellowButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_yellow-active-btn"]];
    lInspectionYellowButton.tag=2;
    if(mValueDict_!=nil)
        if([[NSString stringWithFormat:@"%@",[mValueDict_ objectForKey:@"Color"]] isEqualToString:@"Yellow"])
            [lInspectionYellowButton setSelected:YES];
    
    [lInspectionYellowButton addTarget:self action:@selector(isButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lInspectionYellowButton];
    
    UIButton* lInspectionRedButton=[[UIButton alloc]initWithFrame:CGRectMake(70, 5, 25, 25)];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionRedButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_red-inactive-btn"]];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionRedButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_red-active-btn"]];
    lInspectionRedButton.tag=3;
    if(mValueDict_!=nil)
        if([[NSString stringWithFormat:@"%@",[mValueDict_ objectForKey:@"Color"]] isEqualToString:@"Red"])
            [lInspectionRedButton setSelected:YES];
    
    [lInspectionRedButton addTarget:self action:@selector(isButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lInspectionRedButton];
    //    int height=  [[GenericFiles genericFiles] dynamiclabelHeightForText:[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"Name"]] :200 :[UIFont regularFontOfSize:13 fontKey:kFontNameHelveticaNeueKey]];
    //    if(height>32)
    //        height=32;
    UILabel* lInspectionLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, 32)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lInspectionLabel labelTitleFont:[UIFont regularFontOfSize:13 fontKey:kFontNameHelveticaNeueKey] labelTitle:[mItemDict_ objectForKey:@"Name"] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:lInspectionLabel];
    
    if(isMandatory){
        UIImageView* lMandatoryView=[[UIImageView alloc] initWithFrame:CGRectMake(675, 10, 6, 6)];
        [lMandatoryView setImage:[UIImage imageNamed:@"IMG_mandatory-icon"]];
        [self addSubview:lMandatoryView];
    }

    
    UITextView* lInspectionTextView=[[UITextView alloc] initWithFrame:CGRectMake(330, 40, 300, 100)];
    [self setMTextView_:lInspectionTextView];
    [self.mTextView_ setTextColor:[UIColor blackColor]];
    [self.mTextView_ setUserInteractionEnabled:YES];
    self.mTextView_.layer.borderWidth = 1.0f;
    [self.mTextView_.layer setCornerRadius:10.0];
    self.mTextView_.layer.borderColor = [[UIColor grayColor] CGColor];
    self.mTextView_.layer.backgroundColor=[[UIColor whiteColor] CGColor];
    [self.mTextView_ setFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey]];
    [self.mTextView_ setReturnKeyType:UIReturnKeyDefault];
    self.mTextView_.enablesReturnKeyAutomatically=NO;
    [self.mTextView_ setText:self.mValue];
    
    [self inputviewForKeyboard];
    [self addSubview:mTextView_];
    
    CGRect frame=self.frame;
    frame.size.height=110;
    self.frame=frame;
    
}
#pragma mark -  ******************* UI methods ******************

//-------------------------------------- ************** ----------------------------------------
//                         *** add clear and done to keyboard  ***
//-------------------------------------- ************** ----------------------------------------
- (void)inputviewForKeyboard
{
    mToolBar_= [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.superview.bounds.size.width, 44)];
    [mToolBar_ setBarStyle:UIBarStyleDefault];
    // [mToolBar_ setTranslucent:YES];
    UIBarButtonItem *lflexibleButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace                                                                                     target:self action:nil];
    UIBarButtonItem *lCancelButtonItem=[[UIBarButtonItem alloc] initWithTitle:@" Clear " style:UIBarButtonItemStyleBordered target:self action:@selector(cancel_Event:)];
    lCancelButtonItem.tag=1;
    UIBarButtonItem *lDoneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" Done " style:UIBarButtonItemStyleDone target:self action:@selector(done_Event:)];
    lDoneBarButtonItem.tag=2;
    [mToolBar_ setItems:[NSArray arrayWithObjects:lflexibleButtonItem,lCancelButtonItem,lDoneBarButtonItem,nil]];
    mTextView_.inputAccessoryView=mToolBar_;
}

#pragma mark -  ******************* Button Action  methods ******************

//-------------------------------------- ************** ----------------------------------------
//                         *** button action when clear button is clicked  ***
//-------------------------------------- ************** ----------------------------------------
- (void)cancel_Event:(id)sender
{
    
    mTextView_.text=@"";
}

//-------------------------------------- ************** ----------------------------------------
//                         *** button action when done button is clicked  ***
//-------------------------------------- ************** ----------------------------------------
- (void)done_Event:(id)sender
{
    [mTextView_ resignFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if(mFormtype==WALKAROUNDINSPECTION)
    {
        [(UIScrollView*)self.superview setContentOffset:CGPointMake(0,self.frame.origin.y) ];
        CGRect frame=[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mWalkAroundLaneInspectionView.frame;
        frame.origin.y-=150;
        [ [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mWalkAroundScrollview_ setContentSize:CGSizeMake(1024,768+150)];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mWalkAroundLaneInspectionView setFrame:frame];
    }
    else{
        [(UIScrollView*)self.superview setContentOffset:CGPointMake(0,self.frame.origin.y) ];
        
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.mValue=mTextView_.text;
    [self sendRequestForAddItem];
    if(mFormtype==WALKAROUNDINSPECTION)
    {
        [(UIScrollView*)self.superview setContentOffset:CGPointMake(0,0) ];
        CGRect frame=[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mWalkAroundLaneInspectionView.frame;
        frame.origin.y+=150;
        [ [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mWalkAroundScrollview_ setContentSize:CGSizeMake(1024, 768)];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mWalkAroundLaneInspectionView setFrame:frame];
    }
    else{
        [(UIScrollView*)self.superview setContentOffset:CGPointMake(0,0) ];
    }
}

-(void)isButtonSelected:(UIButton*)sender{
    [self.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[UIButton class]]) {
            UIButton* tempBtn=(UIButton *)object;
            if (tempBtn.tag !=sender.tag)
                [tempBtn setSelected:NO];
            else if(tempBtn.tag==sender.tag){
                [tempBtn setSelected:[tempBtn isSelected]?NO:YES];
                if((tempBtn.tag>1)&&[tempBtn isSelected])
                {
                    [self showAddservicePopupView:tempBtn.tag];
                }
                if([sender isSelected]){
                    switch (sender.tag) {
                        case 1:
                            mColor=@"Green";
                            break;
                        case 2:
                            mColor=@"Yellow";
                            break;
                        case 3:
                            mColor=@"Red";
                            break;
                        default:
                            break;
                            
                    }
                }
                else
                    mColor=@"";
            }
        }
    }];
    [self sendRequestForAddItem];
}

-(void)sendRequestForAddItem{
    isAdded=YES;
    
    if(mValueDict_!=nil){
        [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForOpenROInspectionFormWebEngine_ requestForUpdateInspectionItem:self.mRONumber_ itemID:[mValueDict_ objectForKey:@"ASRIID"] requestDict:[[NSDictionary dictionaryWithObjectsAndKeys:mColor,@"Color",mValue ,@"Value",nil] mutableCopy] ];
    }
    else
        [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForOpenROInspectionFormWebEngine_ requestForAddInspectionItem:self.mRONumber_ requestDict:[[NSDictionary dictionaryWithObjectsAndKeys:[mItemDict_ objectForKey:@"IIID" ],@"IIID",mColor,@"Color",mValue ,@"Value", nil] mutableCopy]] ;
    
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mFinishInspectionViewController_] setCompleteInspectionButton];

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
                        [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_ ]mWalkAroundLaneInspectionView] addServicePopupView:tempBtn.frame.origin.x :tempBtn.frame.origin.y+self.frame.origin.y :ltempArray:tag :5];
                     if(mFormtype==MAININSPECTION)
                        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mFinishInspectionViewController_ ] addServicePopupView:tempBtn.frame.origin.x :tempBtn.frame.origin.y+self.frame.origin.y :ltempArray:tag :5];
                
            }
        }
    }];
    
    
}

@end
