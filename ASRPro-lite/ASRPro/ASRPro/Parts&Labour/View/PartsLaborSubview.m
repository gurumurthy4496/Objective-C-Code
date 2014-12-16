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
@synthesize mSelectBtn;
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

-(void)initThePartView{
    isParts=TRUE;
    //Header Label
    self.mHeaderLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 5, 100, 20)];
    [self.mHeaderLabel setText:[NSString stringWithFormat:@"%@ ",[self.mItemDict_  objectForKey:@"Number"]]];
    [self.mHeaderLabel setTextColor:[UIColor blackColor]];
    [self.mHeaderLabel setFont:[UIFont regularFontOfSize:13.0 fontKey:kFontNameHelveticaNeueKey]];
    [self addSubview:self.mHeaderLabel];
    //Description Label
    self.mDescriptionLabel=[[UILabel alloc] initWithFrame:CGRectMake(110, 5, 400, 20)];
    [self.mDescriptionLabel setText:[NSString stringWithFormat:@"%@ ",[self.mItemDict_  objectForKey:@"Name"]]];
    [self.mDescriptionLabel setTextColor:[UIColor blackColor]];
    [self.mDescriptionLabel setFont:[UIFont regularFontOfSize:13.0 fontKey:kFontNameHelveticaNeueKey]];
    [self addSubview:self.mDescriptionLabel];
    //Min btn
    self.mMinBtn=[[UIButton alloc] initWithFrame:CGRectMake(510,3, 20, 20)];
    [self.mMinBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.mMinBtn setTag:1];
    [self.mMinBtn setImage:[UIImage imageNamed:@"IMG_minus.png"] forState:UIControlStateNormal];

    [mMinBtn addTarget:self action:@selector(minButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.mMinBtn];
    //txt field
    self.mTextFld=[[UITextField alloc] initWithFrame:CGRectMake(545, 5,50, 20)];
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
    mPlusBtn=[[UIButton alloc]initWithFrame:CGRectMake(600, 3, 20, 20)];
  [self.mPlusBtn setImage:[UIImage imageNamed:@"IMG_plus.png"] forState:UIControlStateNormal];

    [self.mPlusBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.mPlusBtn setTag:3];
    [self.mPlusBtn addTarget:self action:@selector(plusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.mPlusBtn];
    //select btn
    
    
}

-(void)initTheLaborView{
    isParts=FALSE;
    //Header Label
    self.mHeaderLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 5, 100, 20)];
    [self.mHeaderLabel setText:[NSString stringWithFormat:@"%@ hrs ",[self.mItemDict_  objectForKey:@"Hours"]]];
    [self.mHeaderLabel setTextColor:[UIColor blackColor]];
    [self.mHeaderLabel setFont:[UIFont regularFontOfSize:14.0 fontKey:kFontNameHelveticaNeueKey]];
    [self addSubview:self.mHeaderLabel];
    //Description Label
    self.mDescriptionLabel=[[UILabel alloc] initWithFrame:CGRectMake(110, 5, 400, 20)];
    [self.mDescriptionLabel setText:[NSString stringWithFormat:@"%@ ",[self.mItemDict_  objectForKey:@"Name"]]];
    [self.mDescriptionLabel setTextColor:[UIColor blackColor]];
    [self.mDescriptionLabel setFont:[UIFont regularFontOfSize:14.0 fontKey:kFontNameHelveticaNeueKey]];
    [self addSubview:self.mDescriptionLabel];
    //Min btn
    self.mMinBtn=[[UIButton alloc] initWithFrame:CGRectMake(510,3, 20, 20)];
    [self.mMinBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.mMinBtn setTag:1];
    [self.mMinBtn setImage:[UIImage imageNamed:@"IMG_minus.png"] forState:UIControlStateNormal];
    [mMinBtn addTarget:self action:@selector(minButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.mMinBtn];
    //txt field
    self.mTextFld=[[UITextField alloc] initWithFrame:CGRectMake(545, 5, 50, 20)];
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
    mPlusBtn=[[UIButton alloc]initWithFrame:CGRectMake(600, 3, 20, 20)];
    [self.mPlusBtn setImage:[UIImage imageNamed:@"IMG_plus.png"] forState:UIControlStateNormal];
    [self.mPlusBtn setTag:3];
    [self.mPlusBtn addTarget:self action:@selector(plusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.mPlusBtn];
    //select btn
}

-(void)plusButtonClicked:(id)sender{
    int value=[self.mTextFld.text intValue];

    value+=1;
    [self.mTextFld setText:[NSString stringWithFormat:@"%i",value]];
}

-(void)minButtonClicked:(id)sender{
    int value=[self.mTextFld.text intValue];
    if(value>0){

    value-=1;
    [self.mTextFld setText:[NSString stringWithFormat:@"%i",value]];
    }

    }
-(void)selectButtonClicked:(UIButton*)sender{
    if(mSelectBtn.isSelected){
      [ mMinBtn setSelected:FALSE];
    [ mPlusBtn setSelected:FALSE];
    [ mSelectBtn setSelected:FALSE];
    }
    else{
        [ mMinBtn setSelected:TRUE];
        [ mPlusBtn setSelected:TRUE];
        [ mSelectBtn setSelected:TRUE];
   
    }

        }

# pragma mark ***** TextFieldDelegatemethods *****
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

-(NSMutableDictionary*)getPartsDictionary{
      int value=[self.mTextFld.text intValue];
    if(value>0){
        
        NSMutableDictionary* mTempDict =[[NSMutableDictionary alloc]init];
        [mTempDict setDictionary:[[NSDictionary dictionaryWithObjectsAndKeys:self.mLineID_,@"LineID",[NSString stringWithFormat:@"%@ ",[self.mItemDict_  objectForKey:@"Number"]],@"PartNumber",[NSString stringWithFormat:@"%@ ",self.mTextFld.text ],@"Quantity", nil]mutableCopy]];
//   [self.mTextFld setText:@"0"];
         return mTempDict;
    }
    else
        return nil;
}

-(NSMutableDictionary*)getLaborDictionary{
    int value=[self.mTextFld.text intValue];
    if(value>0){
        NSMutableDictionary* mTempDict =[[NSMutableDictionary alloc]init];
            [mTempDict setDictionary:[[NSDictionary dictionaryWithObjectsAndKeys:self.mLineID_,@"LineID",[NSString stringWithFormat:@"%@ ",[self.mItemDict_  objectForKey:@"Hours"]],@"Hours", nil] mutableCopy]];
//   [self.mTextFld setText:@"0"];
        return mTempDict;
    }
    else
        return nil;
 }


@end
