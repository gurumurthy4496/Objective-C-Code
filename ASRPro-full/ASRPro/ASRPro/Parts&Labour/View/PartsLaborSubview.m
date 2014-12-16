//
//  PartsLaborSubview.m
//  ASRPro
//
//  Created by Kalyani on 24/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "PartsLaborSubview.h"

@implementation PartsLaborSubview
@synthesize mDescriptionLabel;
@synthesize mHeaderLabel;
@synthesize mMinBtn;
@synthesize mPlusBtn;
@synthesize mTextFld;
@synthesize mItemDict_;
@synthesize mLineID_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark -  ********************** Generic Methods **************************
//--------------------------------------------------- ************** ------------------------------------------------------
//                                            *** Method to create part view  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)initThePartView{
    isParts=TRUE;
    //Header Label
    self.mHeaderLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 5, 100, 20)];
    [self.mHeaderLabel setText:[NSString stringWithFormat:@"%@ ",[self.mItemDict_  objectForKey:kPART_NUMBER_DICT]]];
    [self.mHeaderLabel setTextColor:[UIColor blackColor]];
    [self.mHeaderLabel setFont:[UIFont regularFontOfSize:13.0 fontKey:kFontNameHelveticaNeueKey]];
    [self addSubview:self.mHeaderLabel];
    
    //Description Label
    self.mDescriptionLabel=[[UILabel alloc] initWithFrame:CGRectMake(110, 5, 390, 20)];
    [self.mDescriptionLabel setText:[NSString stringWithFormat:@"%@ ",[[self.mItemDict_  objectForKey:kPART_NAME] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]]];
    [self.mDescriptionLabel setTextColor:[UIColor blackColor]];
    [self.mDescriptionLabel setFont:[UIFont regularFontOfSize:13.0 fontKey:kFontNameHelveticaNeueKey]];
    [self addSubview:self.mDescriptionLabel];
    
    //Min btn
    self.mMinBtn=[[UIButton alloc] initWithFrame:CGRectMake(500,0, 40, 30)];
    [self.mMinBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.mMinBtn setTag:1];
    [self.mMinBtn setImage:kMINUS_IMAGE_PARTS forState:UIControlStateNormal];
    [self.mMinBtn setContentMode:UIViewContentModeCenter];
    [mMinBtn addTarget:self action:@selector(minButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.mMinBtn];
    
    //txt field
    self.mTextFld=[[UITextField alloc] initWithFrame:CGRectMake(540, 5,50, 20)];
    [self.mTextFld setKeyboardType:UIKeyboardTypeNumberPad];
    [self.mTextFld setFont:[UIFont regularFontOfSize:14.0 fontKey:kFontNameHelveticaNeueKey]];
    [self.mTextFld setText:[NSString stringWithFormat:@"%@ ",@"0"]];
    [self.mTextFld setTag:2];
    [self.mTextFld setTextAlignment:NSTextAlignmentCenter];
    [self.mTextFld.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [self.mTextFld.layer setBorderWidth:1.0];
    [self.mTextFld setDelegate:self];
    [self.mTextFld setReturnKeyType:UIReturnKeyDone];
    [self addSubview:self.mTextFld];
    
    //plus btn
    mPlusBtn=[[UIButton alloc]initWithFrame:CGRectMake(590, 0, 40, 30)];
  [self.mPlusBtn setImage:kPLUS_IMAGE_PARTS forState:UIControlStateNormal];
    [self.mPlusBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.mPlusBtn setTag:3];
    [self.mPlusBtn setContentMode:UIViewContentModeCenter];

    [self.mPlusBtn addTarget:self action:@selector(plusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.mPlusBtn];
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                            *** Method to create labor view  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)initTheLaborView{
    isParts=FALSE;
    //Header Label
    self.mHeaderLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 5, 100, 20)];
    [self.mHeaderLabel setText:[NSString stringWithFormat:@"%@ hrs ",[self.mItemDict_  objectForKey:KHOURS]]];
    [self.mHeaderLabel setTextColor:[UIColor blackColor]];
    [self.mHeaderLabel setFont:[UIFont regularFontOfSize:14.0 fontKey:kFontNameHelveticaNeueKey]];
    [self addSubview:self.mHeaderLabel];
    
    //Description Label
    self.mDescriptionLabel=[[UILabel alloc] initWithFrame:CGRectMake(110, 5, 390, 20)];
    [self.mDescriptionLabel setText:[NSString stringWithFormat:@"%@ ",[[self.mItemDict_  objectForKey:kPART_NAME] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]]];
    [self.mDescriptionLabel setTextColor:[UIColor blackColor]];
    [self.mDescriptionLabel setFont:[UIFont regularFontOfSize:14.0 fontKey:kFontNameHelveticaNeueKey]];
    [self addSubview:self.mDescriptionLabel];
    
    //Min btn
    self.mMinBtn=[[UIButton alloc] initWithFrame:CGRectMake(500,0, 40, 30)];
    [self.mMinBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.mMinBtn setTag:1];
    [self.mMinBtn setContentMode:UIViewContentModeCenter];

    [self.mMinBtn setImage:kMINUS_IMAGE_PARTS forState:UIControlStateNormal];
    [mMinBtn addTarget:self action:@selector(minButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.mMinBtn];
    
    //txt field
    self.mTextFld=[[UITextField alloc] initWithFrame:CGRectMake(540, 5, 50, 20)];
    [self.mTextFld setKeyboardType:UIKeyboardTypeNumberPad];
    [self.mTextFld setFont:[UIFont regularFontOfSize:14.0 fontKey:kFontNameHelveticaNeueKey]];
    [self.mTextFld setText:[NSString stringWithFormat:@"%@ ",@"0"]];
    [self.mTextFld setTag:2];
    [self.mTextFld setTextAlignment:NSTextAlignmentCenter];
    [self.mTextFld.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [self.mTextFld.layer setBorderWidth:1.0];
    [self.mTextFld setDelegate:self];
    [self.mTextFld setReturnKeyType:UIReturnKeyDone];
    [self addSubview:self.mTextFld];
    
    //plus btn
    mPlusBtn=[[UIButton alloc]initWithFrame:CGRectMake(590, 0, 40, 30)];
    [self.mPlusBtn setImage:kPLUS_IMAGE_PARTS forState:UIControlStateNormal];
    [self.mPlusBtn setContentMode:UIViewContentModeCenter];

    [self.mPlusBtn setTag:3];
    [self.mPlusBtn addTarget:self action:@selector(plusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.mPlusBtn];
    
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                            *** returns request dict for parts  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(NSMutableDictionary*)getPartsDictionary{
    int value=[self.mTextFld.text intValue];
    if(value>0){
        NSMutableDictionary* mTempDict =[[NSMutableDictionary alloc]init];
        [mTempDict setDictionary:[[NSDictionary dictionaryWithObjectsAndKeys:self.mLineID_,kPART_LINE_ID,[NSString stringWithFormat:@"%@ ",[self.mItemDict_  objectForKey:kPART_NUMBER_DICT]],kPART_NUMBER,[NSString stringWithFormat:@"%@ ",self.mTextFld.text ],kPART_QUANTITY, nil]mutableCopy]];
        return mTempDict;
    }
    else
        return nil;
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                            *** returns request dict for labor  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(NSMutableDictionary*)getLaborDictionary{
    int value=[self.mTextFld.text intValue];
    if(value>0){
        NSMutableDictionary* mTempDict =[[NSMutableDictionary alloc]init];
        float Hours=[[NSString stringWithFormat:@"%@ ",[self.mItemDict_  objectForKey:KHOURS]] floatValue]*[mTextFld.text floatValue];
        [mTempDict setDictionary:[[NSDictionary dictionaryWithObjectsAndKeys:self.mLineID_,kPART_ASRLID,[NSString stringWithFormat:@"%.2f ",Hours],KHOURS, nil] mutableCopy]];
        return mTempDict;
    }
    else
        return nil;
}

#pragma mark -  ********************** Button Actions**************************
//--------------------------------------------------- ************** ------------------------------------------------------
//                                            *** Method for plus button action  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)plusButtonClicked:(id)sender{
    int value=[self.mTextFld.text intValue];
    value+=1;
    [self.mTextFld setText:[NSString stringWithFormat:@"%i",value]];
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                            *** Method for minus button action  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)minButtonClicked:(id)sender{
    int value=[self.mTextFld.text intValue];
    if(value>0){
    value-=1;
    [self.mTextFld setText:[NSString stringWithFormat:@"%i",value]];
    }
}

#pragma mark -  ********************** TextField Delegate methods **************************
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    UIScrollView* lScrollView=(UIScrollView*)self.superview.superview;
    CGSize frame= lScrollView.contentSize;
    frame.height+=140;
    [lScrollView setContentSize:frame];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0,240+140, 0.0);
    lScrollView.contentInset = contentInsets;
    lScrollView.scrollIndicatorInsets = contentInsets;
    [UIView commitAnimations];
    CGRect lFrame=[lScrollView convertRect:self.bounds fromView:self];
    [lScrollView scrollRectToVisible:lFrame animated:NO];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    UIScrollView* lScrollView=(UIScrollView*)self.superview.superview;
    CGSize frame= lScrollView.contentSize;
    frame.height-=140;
    [lScrollView setContentSize:frame];
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    lScrollView.contentInset = contentInsets;
    lScrollView.scrollIndicatorInsets = contentInsets;
}

@end
