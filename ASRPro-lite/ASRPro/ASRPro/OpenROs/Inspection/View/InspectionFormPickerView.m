//
//  InspectionFormPickerView.m
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "InspectionFormPickerView.h"
@interface InspectionFormPickerView()
@property (nonatomic,retain) NSString*mColor;
@property (nonatomic,retain) NSString*mValue;

@property(nonatomic,retain)NSMutableArray* mSubitemsGreenArray_;
@property(nonatomic,retain)NSMutableArray* mSubitemsYellowArray_;
@property(nonatomic,retain)NSMutableArray* mSubitemsRedArray_;
@property(nonatomic,retain)NSMutableArray* mSubitemsArray_;

@end

@implementation InspectionFormPickerView

@synthesize mItemDict_;
@synthesize mValueDict_;
@synthesize mColor;
@synthesize mValue;

@synthesize mpickerview;

@synthesize mPickerMonths;
@synthesize mPickerYears;

@synthesize mSubitemsArray_;
@synthesize mSubitemsGreenArray_;
@synthesize mSubitemsYellowArray_;
@synthesize mSubitemsRedArray_;
@synthesize mFormtype;
@synthesize mRONumber_;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        /*  mpickerview=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
         mpickerview.delegate=self;
         mpickerview.dataSource=self;
         [mpickerview setUserInteractionEnabled:YES];
         mpickerview.showsSelectionIndicator = YES;
         mPickerMonths=[[NSMutableArray alloc]init];
         mPickerYears=[[NSMutableArray alloc]init];
         [self addSubview:mpickerview];*/
    }
    return self;
}

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
    
    CGRect frame=self.frame;
    
    if(([mSubitemsArray_ count]>0)||([mSubitemsGreenArray_ count]>0)||([mSubitemsRedArray_ count]>0)||([mSubitemsYellowArray_ count]>0)){
        [self initializePickerView];
        frame.size.height=120;
    }
    else
        frame.size.height=40;
    
    self.frame=frame;
    
}

-(void)initializePickerView{
    
   mpickerview=[[UIPickerView alloc]initWithFrame:CGRectMake(320, 10, 310, 100)];
    mpickerview.delegate=self;
    mpickerview.dataSource=self;
    [mpickerview setUserInteractionEnabled:YES];
    mpickerview.showsSelectionIndicator = YES;
    mPickerMonths=[[NSMutableArray alloc]init];
    mPickerYears=[[NSMutableArray alloc]init];
    for(int i=0;i<[mSubitemsArray_ count]&&[mSubitemsArray_ count]>0;i++){
        NSString *msubitem=[NSString stringWithFormat:@"%@",[mSubitemsArray_ objectAtIndex:i]];
        msubitem = [msubitem stringByReplacingOccurrencesOfString:@" " withString:@""];
        if([msubitem intValue]>0){
            [self.mPickerYears addObject:msubitem];
        } else {
            [self.mPickerMonths addObject:msubitem];
        }
    }
    [self addSubview:mpickerview];
    [self setValue:mValue];
}

-(void)initializeTheArrays{
   isMandatory=[[mItemDict_ objectForKey:@"Required"] boolValue];
    isAdded=(mValueDict_!=nil)?YES:NO;
    
    self.mColor=(mValueDict_!=nil)?[NSString stringWithFormat:@"%@",[mValueDict_ objectForKey:@"Color"]]:@"";
    self.mValue=(mValueDict_!=nil)?[NSString stringWithFormat:@"%@",[mValueDict_ objectForKey:@"Value"]]:@"";
    
    if(![[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItems"]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
        mSubitemsArray_=[[[[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItems"] ]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]] componentsSeparatedByString:@","] mutableCopy];
    if(![[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItemsGreen"]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
        mSubitemsGreenArray_=[[[[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItemsGreen"] ]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]] componentsSeparatedByString:@","] mutableCopy];
    if(![[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItemsRed"]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
        mSubitemsRedArray_=[[[[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItemsRed"] ]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]] componentsSeparatedByString:@","] mutableCopy];
    if(![[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItemsYellow"]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
        mSubitemsYellowArray_=[[[[[NSString stringWithFormat:@"%@",[mItemDict_ objectForKey:@"SubItemsYellow"] ]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]] componentsSeparatedByString:@","] mutableCopy];
}




//-------------------------------------- ************** ----------------------------------------
//                         *** sets value for picker  ***
//-------------------------------------- ************** ----------------------------------------
-(void)setValue:(NSString*)value // reloads the component to previous values
{
    NSArray * stringArray=[[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsSeparatedByString:@","];
    for (int i=0;i<[self.mPickerMonths count]&&[stringArray count]>0;i++)
    {
        if([[NSString stringWithFormat:@"%@",[stringArray objectAtIndex:0]] isEqualToString:[NSString stringWithFormat:@"%@",[self.mPickerMonths objectAtIndex:i]]])
        {
            [mpickerview selectRow:i inComponent:0 animated:YES];
            break;
        }
    }
    for (int i=0;i<[self.mPickerYears count]&&[stringArray count]>1;i++)
    {
        if([[NSString stringWithFormat:@"%@",[stringArray objectAtIndex:1]]isEqualToString:[NSString stringWithFormat:@"%@",[self.mPickerYears objectAtIndex:i]]])
        {
            [mpickerview selectRow:i inComponent:1 animated:YES];
            break;
        }
    }
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
                        }
                            break;
                        case 2:{
                            mColor=@"Yellow";
                            
                        }
                            break;
                        case 3:{
                            mColor=@"Red";
                            
                        }
                            break;
                        default:
                            break;
                            
                    }
                }
                if((tempBtn.tag>1)&&[tempBtn isSelected]){
                    [self showAddservicePopupView:tempBtn.tag];
                }
                
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

#pragma mark - ****************** UIPickerViewDelegate *********************

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if(component==MONTH)
        return 100;
    if(component==YEAR)
        return 100;
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component==MONTH)
        return [NSString stringWithFormat:@"%@",[self.mPickerMonths objectAtIndex:row]];
    if(component==YEAR)
        return [NSString stringWithFormat:@"%@",[self.mPickerYears objectAtIndex:row]];
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component ==MONTH)
    {
        [self setMValue:[NSString stringWithFormat:@"%@, %@",[self.mPickerMonths objectAtIndex:row],[self.mPickerYears objectAtIndex:[mpickerview selectedRowInComponent:1]]] ];
    }
    else if(component ==YEAR)
    {
        [self setMValue:[NSString stringWithFormat:@"%@, %@",[self.mPickerMonths objectAtIndex:row],[self.mPickerYears objectAtIndex:[mpickerview selectedRowInComponent:1]]] ];
    }
    [self sendRequestForAddItem];
}

#pragma mark -  ****************** UIPickerViewDataSource *****************
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == MONTH)
    {
        return [self.mPickerMonths count];
    }
    else if(component == YEAR)
    {
        return [self.mPickerYears count];
    }
    return 1;
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
                        [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_ ]mWalkAroundLaneInspectionView] addServicePopupView:tempBtn.frame.origin.x :tempBtn.frame.origin.y+self.frame.origin.y :ltempArray:tag :1];
                      if(mFormtype==MAININSPECTION)
                        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mFinishInspectionViewController_ ] addServicePopupView:tempBtn.frame.origin.x :tempBtn.frame.origin.y+self.frame.origin.y :ltempArray:tag :1];
                
            }
        }
    }];
}

@end

