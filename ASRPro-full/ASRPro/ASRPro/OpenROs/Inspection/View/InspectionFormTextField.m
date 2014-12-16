//
//  InspectionFormTextField.m
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "InspectionFormTextField.h"

@interface InspectionFormTextField()
@property (nonatomic,retain) NSString*mColor;
@property (nonatomic,retain) NSString*mValue;

@end

@implementation InspectionFormTextField

@synthesize mItemDict_;
@synthesize mValueDict_;
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
    UILabel* lInspectionLabel=[[UILabel alloc] initWithFrame:CGRectMake(120, 0, 200, 32)];
    
    [[GenericFiles genericFiles] createUILabelWithInstance:lInspectionLabel labelTitleFont:[UIFont regularFontOfSize:13 fontKey:kFontNameHelveticaNeueKey] labelTitle:[mItemDict_ objectForKey:@"Name"] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [self addSubview:lInspectionLabel];
    
    
    UITextField* lInspectionTextField=[[UITextField alloc] initWithFrame:CGRectMake(330, 10, 300, 30)];
    [[GenericFiles genericFiles] createUITextFieldInstance:lInspectionTextField  textfieldTitle:@"" textfieldTitleColor:[UIColor blackColor] textfieldTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] BackgroundColor:[UIColor whiteColor]];
    [lInspectionTextField.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [lInspectionTextField.layer setBorderWidth:1.0];
    [lInspectionTextField setReturnKeyType:UIReturnKeyDone];
    lInspectionTextField.enablesReturnKeyAutomatically=NO;
    [lInspectionTextField setText:mValue];
    lInspectionTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [lInspectionTextField setDelegate:self];
    UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10,40)];
    lInspectionTextField.leftView =leftView;
    lInspectionTextField.leftViewMode= UITextFieldViewModeAlways;
    
    leftView.userInteractionEnabled=NO;
    
    leftView=nil;
    lInspectionTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self addSubview:lInspectionTextField];
    if(isMandatory){
        UIImageView* lMandatoryView=[[UIImageView alloc] initWithFrame:CGRectMake(690, 10, 6, 6)];
        [lMandatoryView setImage:[UIImage imageNamed:@"IMG_mandatory-icon"]];
        [self addSubview:lMandatoryView];
    }

    
    CGRect frame=self.frame;
    frame.size.height=40;
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
    UILabel* lInspectionLabel=[[UILabel alloc] initWithFrame:CGRectMake(120, 0, 200, 32)];
    
    [[GenericFiles genericFiles] createUILabelWithInstance:lInspectionLabel labelTitleFont:[UIFont regularFontOfSize:13 fontKey:kFontNameHelveticaNeueKey] labelTitle:[mItemDict_ objectForKey:@"Name"] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [self addSubview:lInspectionLabel];
    
    
    UITextField* lInspectionTextField=[[UITextField alloc] initWithFrame:CGRectMake(330, 10, 300, 30)];
    [[GenericFiles genericFiles] createUITextFieldInstance:lInspectionTextField  textfieldTitle:@"" textfieldTitleColor:[UIColor blackColor] textfieldTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] BackgroundColor:[UIColor whiteColor]];
    [lInspectionTextField.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [lInspectionTextField.layer setBorderWidth:1.0];
    [lInspectionTextField setReturnKeyType:UIReturnKeyDone];
    lInspectionTextField.enablesReturnKeyAutomatically=NO;
    [lInspectionTextField setText:mValue];
    lInspectionTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [lInspectionTextField setDelegate:self];
    UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10,40)];
    lInspectionTextField.leftView =leftView;
    lInspectionTextField.leftViewMode= UITextFieldViewModeAlways;
    
    leftView.userInteractionEnabled=NO;
    
    leftView=nil;
    lInspectionTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self addSubview:lInspectionTextField];
    if(isMandatory){
        UIImageView* lMandatoryView=[[UIImageView alloc] initWithFrame:CGRectMake(675, 10, 6, 6)];
        [lMandatoryView setImage:[UIImage imageNamed:@"IMG_mandatory-icon"]];
        [self addSubview:lMandatoryView];
    }

    
    CGRect frame=self.frame;
    frame.size.height=40;
    self.frame=frame;
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
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
      //  [(UIScrollView*)self.superview  setContentSize:CGSizeMake(684, ((UIScrollView*)self.superview).+150)];

    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{

  self.mValue=textField.text;
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
        //  [(UIScrollView*)self.superview  setContentSize:CGSizeMake(684, ((UIScrollView*)self.superview).+150)];
        
    }

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
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
                if([ltempArray count]>0){
                    if(mFormtype==LANEINSPECTION)
                        [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_ ]mWalkAroundLaneInspectionView] addServicePopupView:tempBtn.frame.origin.x :tempBtn.frame.origin.y+self.frame.origin.y :ltempArray:tag :6];
                    if(mFormtype==MAININSPECTION)
                        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mFinishInspectionViewController_ ] addServicePopupView:tempBtn.frame.origin.x :tempBtn.frame.origin.y+self.frame.origin.y :ltempArray:tag :6];
                }
            }
        }
    }];
}

@end
