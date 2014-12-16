//
//  InspectionFormCheckButtonView.m
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "InspectionFormCheckButtonView.h"

@interface InspectionFormCheckButtonView(){
    int yPos,xPos;
}
@property(nonatomic,retain)NSMutableArray* mSubitemsGreenArray_;
@property(nonatomic,retain)NSMutableArray* mSubitemsYellowArray_;
@property(nonatomic,retain)NSMutableArray* mSubitemsRedArray_;
@property(nonatomic,retain)NSMutableArray* mSubitemsArray_;
@property (nonatomic,retain) NSString*mColor;
@property (nonatomic,retain) NSString*mValue;
@property (nonatomic,retain) NSMutableArray*mValueArray;

@end

@implementation InspectionFormCheckButtonView
@synthesize mItemDict_;
@synthesize mSubitemsArray_;
@synthesize mSubitemsGreenArray_;
@synthesize mSubitemsYellowArray_;
@synthesize mSubitemsRedArray_;
@synthesize mValueDict_;
@synthesize mColor;
@synthesize mValue;
@synthesize mValueArray;
@synthesize mFormtype;
@synthesize mRONumber_;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        xPos=10;
        yPos=0;
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
    
    self.mColor=(mValueDict_!=nil)?[NSString stringWithFormat:@"%@",[mValueDict_ objectForKey:@"Color"]]:@"";
    self.mValue=(mValueDict_!=nil)?[NSString stringWithFormat:@"%@",[mValueDict_ objectForKey:@"Value"]]:@"";
    self.mValueArray=[[[[mValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]] componentsSeparatedByString:@","] mutableCopy] ;
    isAdded=(mValueDict_!=nil)?YES:NO;
    isMandatory=[[mItemDict_ objectForKey:@"Required"] boolValue];
    [self initializeTheArrays];
    [self addButtonToView];
    xPos=330;
    [self addSubItemsToView];
    [self addSubItemsGreenToView];
    [self addSubItemsYellowToView];
    [self addSubItemsRedToView];
    if(([mSubitemsArray_ count]==0)&&([mSubitemsGreenArray_ count]==0)&&([mSubitemsRedArray_ count]==0)&&([mSubitemsYellowArray_ count]==0))
        yPos=60;
    
    if(xPos==500)
        yPos+=60;
    
    if(isMandatory){
        UIImageView* lMandatoryView=[[UIImageView alloc] initWithFrame:CGRectMake(690, 10, 6, 6)];
        [lMandatoryView setImage:[UIImage imageNamed:@"IMG_mandatory-icon"]];
        [self addSubview:lMandatoryView];
    }

    
    CGRect frame=self.frame;
    frame.size.height=yPos;
    self.frame=frame;
    
}
-(void)addViewToFinishInspection{
    
    self.mColor=(mValueDict_!=nil)?[NSString stringWithFormat:@"%@",[mValueDict_ objectForKey:@"Color"]]:@"";
    self.mValue=(mValueDict_!=nil)?[NSString stringWithFormat:@"%@",[mValueDict_ objectForKey:@"Value"]]:@"";
    self.mValueArray=[[[[mValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]] componentsSeparatedByString:@","] mutableCopy] ;
    isAdded=(mValueDict_!=nil)?YES:NO;
    isMandatory=[[mItemDict_ objectForKey:@"Required"] boolValue];
    [self initializeTheArrays];
    [self addButtonToView];
    xPos=330;
    [self addSubItemsToView];
    [self addSubItemsGreenToView];
    [self addSubItemsYellowToView];
    [self addSubItemsRedToView];
    if(([mSubitemsArray_ count]==0)&&([mSubitemsGreenArray_ count]==0)&&([mSubitemsRedArray_ count]==0)&&([mSubitemsYellowArray_ count]==0))
        yPos=60;
    
    if(xPos==500)
        yPos+=60;
    
    if(isMandatory){
        UIImageView* lMandatoryView=[[UIImageView alloc] initWithFrame:CGRectMake(675, 10, 6, 6)];
        [lMandatoryView setImage:[UIImage imageNamed:@"IMG_mandatory-icon"]];
        [self addSubview:lMandatoryView];
    }

    
    CGRect frame=self.frame;
    frame.size.height=yPos;
    self.frame=frame;
    
}

-(void)addButtonToView{
    UIButton* lInspectionGreenButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, 25, 25)];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionGreenButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_GREEN_INACTIVE_BUTTON];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionGreenButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_GREEN_ACTIVE_BUTTON];
    lInspectionGreenButton.tag=1;
    if([mColor isEqualToString:@"Green"])
        [lInspectionGreenButton setSelected:YES];
    else
        if([mColor isEqualToString:@""])
            [lInspectionGreenButton setSelected:YES];
    
    [lInspectionGreenButton addTarget:self action:@selector(isButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lInspectionGreenButton];
    UIButton* lInspectionYellowButton=[[UIButton alloc]initWithFrame:CGRectMake(40, 5, 25, 25)];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionYellowButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_YELLOW_INACTIVE_BUTTON];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionYellowButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_YELLOW_ACTIVE_BUTTON];
    lInspectionYellowButton.tag=2;
    if([mColor isEqualToString:@"Yellow"])
        [lInspectionYellowButton setSelected:YES];
    
    [lInspectionYellowButton addTarget:self action:@selector(isButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lInspectionYellowButton];
    
    UIButton* lInspectionRedButton=[[UIButton alloc]initWithFrame:CGRectMake(70, 5, 25, 25)];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionRedButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_RED_INACTIVE_BUTTON];
    [[GenericFiles genericFiles]createUIButtonInstance:lInspectionRedButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_RED_ACTIVE_BUTTON];
    lInspectionRedButton.tag=3;
    if([mColor isEqualToString:@"Red"])
        [lInspectionRedButton setSelected:YES];
    
    [lInspectionRedButton addTarget:self action:@selector(isButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lInspectionRedButton];
    
    
    UILabel* lInspectionLabel=[[UILabel alloc] initWithFrame:CGRectMake(120, 0, 200, 32)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lInspectionLabel labelTitleFont:[UIFont regularFontOfSize:13 fontKey:kFontNameHelveticaNeueKey] labelTitle:[mItemDict_ objectForKey:@"Name"] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [self addSubview:lInspectionLabel];
    
 
    
}

-(void)isButtonSelected:(UIButton*)sender{
    
    [self.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[UIButton class]]) {
            UIButton* tempBtn=(UIButton *)object;
            if ((tempBtn.tag !=sender.tag)&&(tempBtn.tag<5))
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
                            self.mColor=@"Green";
                            break;
                        case 2:
                            self.mColor=@"Yellow";
                            break;
                        case 3:
                            self.mColor=@"Red";
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
        [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForOpenROInspectionFormWebEngine_ requestForUpdateInspectionItem:mRONumber_ itemID:[mValueDict_ objectForKey:@"ASRIID"] requestDict:[[NSDictionary dictionaryWithObjectsAndKeys:mColor,@"Color",mValue ,@"Value",nil] mutableCopy] ];
    }
    else
        [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForOpenROInspectionFormWebEngine_ requestForAddInspectionItem:mRONumber_ requestDict:[[NSDictionary dictionaryWithObjectsAndKeys:[mItemDict_ objectForKey:@"IIID" ],@"IIID",mColor,@"Color",mValue ,@"Value", nil] mutableCopy] ] ;
    
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mFinishInspectionViewController_] setCompleteInspectionButton];

}

-(void)isCheckButtonSelected:(UIButton*)sender{
    [sender setSelected:[sender isSelected]?NO:YES];
    [self getSelectedValue];
    
}
-(void)isCheckButtonGreenSelected:(UIButton*)sender{
    [sender setSelected:[sender isSelected]?NO:YES];
    [self.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[UIButton class]]) {
            UIButton* tempBtn=(UIButton *)object;
            if(tempBtn.tag<4){
                if (tempBtn.tag ==1)
                    [tempBtn setSelected:YES];
                else
                    [tempBtn setSelected:NO];
            }
        }
    }];
    self.mColor=@"Green";
    [self getSelectedValue];
}

-(void)isCheckButtonRedSelected:(UIButton*)sender{
    [sender setSelected:[sender isSelected]?NO:YES];
    [self showAddservicePopupView:3];
    [self.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[UIButton class]]) {
            UIButton* tempBtn=(UIButton *)object;
            if(tempBtn.tag<4){
                if (tempBtn.tag ==3)
                    [tempBtn setSelected:YES];
                else
                    [tempBtn setSelected:NO];
            }
        }
        
    }];
    self.mColor=@"Red";
    [self getSelectedValue];
}

-(void)isCheckButtonYellowSelected:(UIButton*)sender{
    [sender setSelected:[sender isSelected]?NO:YES];
    [self showAddservicePopupView:2];
    [self.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[UIButton class]]) {
            UIButton* tempBtn=(UIButton *)object;
            if(tempBtn.tag<4){
                if (tempBtn.tag ==2)
                    [tempBtn setSelected:YES];
                else
                    [tempBtn setSelected:NO];
            }
        }
        
    }];
    self.mColor=@"Yellow";
    [self getSelectedValue];
}

-(void)getSelectedValue{
    [mValueArray removeAllObjects];
    [self.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[InspectionButton class]]) {
            InspectionButton* tempBtn=(InspectionButton *)object;
            if(tempBtn.tag>4){
                if([tempBtn isSelected])
                    [ mValueArray addObject:tempBtn.mButtonName];
            }
        }
    }];
    self.mValue=[mValueArray componentsJoinedByString:@","];
    [self sendRequestForAddItem];
    
    
    
}
-(void)addSubItemsToView{
    for (int i=0;i<[mSubitemsArray_ count];i++){
        InspectionButton* lInspectionCheckButton=[[InspectionButton alloc]initWithFrame:CGRectMake(xPos, yPos, 30, 30)];
        [[GenericFiles genericFiles]createUIButtonInstance:lInspectionCheckButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_uncheck-icon"]];
        [[GenericFiles genericFiles]createUIButtonInstance:lInspectionCheckButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageNamed:@"IMG_check-icon"]];
        lInspectionCheckButton.tag=10+i;
        [lInspectionCheckButton addTarget:self action:@selector(isCheckButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [lInspectionCheckButton setSelected:[self isValuePresent:[NSString stringWithFormat:@"%@",[mSubitemsArray_ objectAtIndex:i]]]];
        [lInspectionCheckButton setMButtonName:[NSString stringWithFormat:@"%@",[mSubitemsArray_ objectAtIndex:i]]];
        [self addSubview:lInspectionCheckButton];
        UILabel* lInspectionLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos+30, yPos, 115, 32)];
        [[GenericFiles genericFiles] createUILabelWithInstance:lInspectionLabel labelTitleFont:[UIFont regularFontOfSize:13 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[mSubitemsArray_ objectAtIndex:i]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
        [self addSubview:lInspectionLabel];
        xPos=(xPos==330)?500:330;
        if(xPos==330)
            yPos+=40;
        
    }
    
}
-(void)addSubItemsGreenToView{
    for (int i=0;i<[mSubitemsGreenArray_ count];i++){
        InspectionButton* lInspectionCheckButton=[[InspectionButton alloc]initWithFrame:CGRectMake(xPos, yPos+3, 30, 30)];
        [[GenericFiles genericFiles]createUIButtonInstance:lInspectionCheckButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_CHECK_UNSELECT];
        [[GenericFiles genericFiles]createUIButtonInstance:lInspectionCheckButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_CHECK_SELECT];
        [lInspectionCheckButton setSelected:[self isValuePresent:[NSString stringWithFormat:@"%@",[mSubitemsGreenArray_ objectAtIndex:i]]]];
        [lInspectionCheckButton setMButtonName:[NSString stringWithFormat:@"%@",[mSubitemsGreenArray_ objectAtIndex:i]]];
        
        lInspectionCheckButton.tag=50+i;
        [lInspectionCheckButton addTarget:self action:@selector(isCheckButtonGreenSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lInspectionCheckButton];
        UILabel* lInspectionLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos+30, yPos, 115, 32)];
        [[GenericFiles genericFiles] createUILabelWithInstance:lInspectionLabel labelTitleFont:[UIFont regularFontOfSize:13 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[mSubitemsGreenArray_ objectAtIndex:i]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
        [self addSubview:lInspectionLabel];
        xPos=(xPos==330)?500:330;
        if(xPos==330)
            yPos+=40;
    }
}
-(void)addSubItemsRedToView{
    for (int i=0;i<[mSubitemsRedArray_ count];i++){
        InspectionButton* lInspectionCheckButton=[[InspectionButton alloc]initWithFrame:CGRectMake(xPos, yPos+3, 30, 30)];
        [[GenericFiles genericFiles]createUIButtonInstance:lInspectionCheckButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_CHECK_UNSELECT];
        [[GenericFiles genericFiles]createUIButtonInstance:lInspectionCheckButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_CHECK_SELECT];
        lInspectionCheckButton.tag=70+i;
        [lInspectionCheckButton addTarget:self action:@selector(isCheckButtonRedSelected:) forControlEvents:UIControlEventTouchUpInside];
        [lInspectionCheckButton setSelected:[self isValuePresent:[NSString stringWithFormat:@"%@",[mSubitemsRedArray_ objectAtIndex:i]]]];
        [lInspectionCheckButton setMButtonName:[NSString stringWithFormat:@"%@",[mSubitemsRedArray_ objectAtIndex:i]]];
        
        [self addSubview:lInspectionCheckButton];
        UILabel* lInspectionLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos+30, yPos, 115, 32)];
        [[GenericFiles genericFiles] createUILabelWithInstance:lInspectionLabel labelTitleFont:[UIFont regularFontOfSize:13 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[mSubitemsRedArray_ objectAtIndex:i]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
        [self addSubview:lInspectionLabel];
        xPos=(xPos==330)?500:330;
        if(xPos==330)
            yPos+=40;
    }
    
    
}
-(void)addSubItemsYellowToView{
    for (int i=0;i<[mSubitemsYellowArray_ count];i++){
        InspectionButton* lInspectionCheckButton=[[InspectionButton alloc]initWithFrame:CGRectMake(xPos, yPos+3,
                                                                                                   0, 30)];
        [[GenericFiles genericFiles]createUIButtonInstance:lInspectionCheckButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_CHECK_UNSELECT];
        [[GenericFiles genericFiles]createUIButtonInstance:lInspectionCheckButton buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_CHECK_SELECT];
        lInspectionCheckButton.tag=60+i;
        [lInspectionCheckButton addTarget:self action:@selector(isCheckButtonYellowSelected:) forControlEvents:UIControlEventTouchUpInside];
        [lInspectionCheckButton setSelected:[self isValuePresent:[NSString stringWithFormat:@"%@",[mSubitemsYellowArray_ objectAtIndex:i]]]];
        [lInspectionCheckButton setMButtonName:[NSString stringWithFormat:@"%@",[mSubitemsYellowArray_ objectAtIndex:i]]];
        
        [self addSubview:lInspectionCheckButton];
        UILabel* lInspectionLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos+30, yPos, 115, 32)];
        [[GenericFiles genericFiles] createUILabelWithInstance:lInspectionLabel labelTitleFont:[UIFont regularFontOfSize:13 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@",[mSubitemsYellowArray_ objectAtIndex:i]] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
        [self addSubview:lInspectionLabel];
        xPos=(xPos==330)?500:330;
        if(xPos==330)
            yPos+=40;
        
    }
    
    
}
-(void)initializeTheArrays{
    if(![[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItems"]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
        mSubitemsArray_=[[[[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItems"] ]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]] componentsSeparatedByString:@","] mutableCopy];
    if(![[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItemsGreen"]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
        mSubitemsGreenArray_=[[[[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItemsGreen"] ]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]] componentsSeparatedByString:@","] mutableCopy];
    if(![[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItemsRed"]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
        mSubitemsRedArray_=[[[[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItemsRed"] ]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]] componentsSeparatedByString:@","] mutableCopy];
    if(![[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItemsYellow"]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
        mSubitemsYellowArray_=[[[[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItemsYellow"] ]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]] componentsSeparatedByString:@","] mutableCopy];
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
                        [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_ ]mWalkAroundLaneInspectionView] addServicePopupView:tempBtn.frame.origin.x :tempBtn.frame.origin.y+self.frame.origin.y :ltempArray:tag :1];
                  if(mFormtype==MAININSPECTION)
                        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mFinishInspectionViewController_ ] addServicePopupView:tempBtn.frame.origin.x :tempBtn.frame.origin.y+self.frame.origin.y :ltempArray:tag :1];
                }
            }
        }
    }];
}

-(BOOL)isValuePresent:(NSString*)aValue{
    for(int i=0;i<[mValueArray count];i++){
        if([[[NSString stringWithFormat:@"%@",[mValueArray objectAtIndex:i]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:[aValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]])
            return TRUE;
    }
    return FALSE;
}

@end
