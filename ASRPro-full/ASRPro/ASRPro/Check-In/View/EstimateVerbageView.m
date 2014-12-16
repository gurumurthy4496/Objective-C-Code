//
//  EstimateVerbageView.m
//  ASRPro
//
//  Created by GuruMurthy on 04/04/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "EstimateVerbageView.h"

@implementation EstimateVerbageView
@synthesize mDisclaimerLabel_;
@synthesize mAcceptButton_;

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

- (void)setBorderForEstimateVerbage {
    [self.layer setBorderColor:[[UIColor ASRProBlueColor] CGColor]];
    [self.layer setBorderWidth:2];
    [self setHeaderLabelForEstimateVerbageView];
}

- (void)setFrameForEstimateVerbageView {
    
}

- (void)setHeaderLabelForEstimateVerbageView {
    UILabel *headerLabel = [[UILabel alloc] init];
    CGFloat x = 0, y = 0, width = self.frame.size.width, height = 35;
    [headerLabel setFrame:CGRectMake(x, y, width, height)];
    [headerLabel setText:@"   Disclaimer"];
    [headerLabel setTextColor:[UIColor whiteColor]];
    [headerLabel setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
    [headerLabel setBackgroundColor:[UIColor ASRProBlueColor]];
    [self addSubview:headerLabel];

    [self codeForAcceptButton];
    NSString *disclaimerString = @"";
   /* if ([[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mLoginDataArray_ valueForKey:@"Disclaimer"] != nil) {
        disclaimerString = [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mLoginDataArray_ valueForKey:@"Disclaimer"];
    }*/
    if ([self containsKey:@"Disclaimer"]) {
        disclaimerString = [[[[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mLoginDataArray_ valueForKey:@"Store"] valueForKey:@"AppSettings"] valueForKey:@"Disclaimer"];
    }
    /*if ([disclaimerString length] == 0 ) {
        disclaimerString = @"Hi, yes a category enables you to add extra functionality to an existing class, my code over on github will stretch the height, but I just changed some stuff and posted the code here in the answer that should stretch the width like you want. If this helps please don't hesitate to up vote and accept as the answer/solution :D thanks –  Daniel Jan 10 '12 at 0:07 ";
    }*/
    /*UIScrollView *scrollView = [[UIScrollView alloc] init];
    [scrollView setFrame:CGRectMake(x, height, self.frame.size.width, self.frame.size.height - 30 - self.mAcceptButton_.frame.size.height - 30)];
    [scrollView setBackgroundColor:[UIColor redColor]];
    UILabel *disclaimerLabel = [[UILabel alloc] init];
    [disclaimerLabel setText:disclaimerString];
    disclaimerLabel.adjustsFontSizeToFitWidth = NO;
    disclaimerLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [disclaimerLabel setFrame:CGRectMake(x+10, 10, self.frame.size.width - 20, 9000)];
    [disclaimerLabel setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
    disclaimerLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [disclaimerLabel setNumberOfLines:0];
    [disclaimerLabel sizeToFit];
    
    // Set the height
    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width - 20,9999);
    CGSize titleSize = [disclaimerLabel.text sizeWithFont:disclaimerLabel.font constrainedToSize:maximumLabelSize lineBreakMode:disclaimerLabel.lineBreakMode];
    
    DLog(@"Height: %.f  Width: %.f", titleSize.height, titleSize.width);
    
    //Adjust the label the the new height
    CGRect newFrame = disclaimerLabel.frame;
    newFrame.size.height = titleSize.height;
    disclaimerLabel.frame = newFrame;
    
    DLog(@"No. of characters in the string :- %d",[disclaimerString length]);
    DLog(@"Lable %@",disclaimerLabel);
    [disclaimerLabel setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
    [disclaimerLabel setBackgroundColor:[UIColor yellowColor]];
    [scrollView addSubview:disclaimerLabel];
    [self addSubview:scrollView];
    [self setMDisclaimerLabel_:disclaimerLabel];
    if (titleSize.height > 150) {
        [scrollView setContentSize:CGSizeMake(self.frame.size.width, titleSize.height)];
    }*/
    UITextView *textview = [[UITextView alloc] init];
    [textview setFrame:CGRectMake(x + 10, height, self.frame.size.width - 20, self.frame.size.height - 30 - self.mAcceptButton_.frame.size.height - 35)];
    [textview setEditable:NO];
    [textview setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
    [textview setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
    [textview setText:disclaimerString];
    [textview setScrollEnabled:YES];
    [self addSubview:textview];
}


- (BOOL)containsKey: (NSString *)key {
    BOOL retVal = 0;
    NSArray *allKeys = [[[[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mLoginDataArray_ valueForKey:@"Store"] valueForKey:@"AppSettings"] allKeys];
    retVal = [allKeys containsObject:key];
    return retVal;
}

- (void)codeForAcceptButton {
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setTitle:@"Accept" forState:UIControlStateNormal];
    [customButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [customButton sizeToFit];
    [[customButton titleLabel] setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
    [customButton setBackgroundColor:[UIColor colorWithRed:229/255.0 green:125/255.0 blue:37/255.0 alpha:1.0f]];
    [customButton addTarget:self action:@selector(acceptButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [customButton setFrame:CGRectMake((self.frame.size.width - 104)/2, 214, 104, 28)];
    [customButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self addSubview:customButton];
    [self setMAcceptButton_:customButton];
}

- (IBAction)acceptButtonAction:(id)sender {
    [self setHidden:YES];
}

@end
