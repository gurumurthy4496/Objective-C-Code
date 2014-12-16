//
//  CustomerSignatureView.m
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "CustomerSignatureView.h"
#import "CheckInSupportWebEngine.h"

@implementation CustomerSignatureView
@synthesize mCustomerSignatureUIImageView_;
@synthesize mSaveButton_;
@synthesize mClearButton_;

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

- (void)setBorderForCustomerSignatureView {
    [self.layer setBorderColor:[[UIColor ASRProBlueColor] CGColor]];
    [self.layer setBorderWidth:2];
    [self setHeaderLabelForCustomerSignatureView];
}

- (void)setFrameForCustomerSignatureView {
    
}

- (void)setHeaderLabelForCustomerSignatureView {
    UILabel *headerLabel = [[UILabel alloc] init];
    CGFloat x = 0, y = 0, width = self.frame.size.width, height = 30;
    [headerLabel setFrame:CGRectMake(x, y, width, height)];
    [headerLabel setText:@"   Customer Signature"];
    [headerLabel setTextColor:[UIColor whiteColor]];
    [headerLabel setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
    [headerLabel setBackgroundColor:[UIColor ASRProBlueColor]];
    [self addSubview:headerLabel];
    CustomerSignatureUIImageView *imageView = [[CustomerSignatureUIImageView alloc] init];
    [imageView setFrame:CGRectMake(x, height, width, self.frame.size.height - height)];
    [imageView setUserInteractionEnabled:TRUE];
    self.mCustomerSignatureUIImageView_ = imageView;
    [self addSubview:self.mCustomerSignatureUIImageView_];
    [self codeForCancelButton];
    [self codeForSaveButton];
    [self.mCustomerSignatureUIImageView_ initializationForSignatureImageView];
    
    
}

- (void)codeForCancelButton {
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setFrame:CGRectMake(self.frame.size.width - 120, 0, 60, 30)];
    [customButton setTitle:@"Clear" forState:UIControlStateNormal];
    [customButton setContentEdgeInsets:UIEdgeInsetsMake(4, 0, 0, 0)];
    [customButton sizeToFit];
    [[customButton titleLabel] setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
//    [customButton setBackgroundImage:[[UIImage imageNamed:@"Button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
    
//    [customButton setBackgroundImage:[[UIImage imageNamed:@"ButtonHighlighted.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateHighlighted];
    [customButton addTarget:self action:@selector(clearButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [customButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self addSubview:customButton];
    [self setMClearButton_:customButton];
}

- (void)codeForSaveButton {
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setFrame:CGRectMake(self.mClearButton_.frame.origin.x + self.mClearButton_.frame.size.width + 10, 0, 60, 30)];
    [customButton setTitle:@"Save" forState:UIControlStateNormal];
    [customButton setContentEdgeInsets:UIEdgeInsetsMake(4, 0, 0, 0)];
    [customButton sizeToFit];
    [[customButton titleLabel] setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
//    [customButton setBackgroundImage:[[UIImage imageNamed:@"Button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
    
//    [customButton setBackgroundImage:[[UIImage imageNamed:@"ButtonHighlighted.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateHighlighted];
    [customButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [customButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self addSubview:customButton];
    [self setMSaveButton_:customButton];
}

- (IBAction)saveButtonAction:(id)sender {
    if (self.mCustomerSignatureUIImageView_.image != nil) {
        [[CheckInSupportWebEngine checkInSharedInstance] postRequestForSaveCustomerSignature];
    }
}

- (IBAction)clearButtonAction:(id)sender {
    if (self.mCustomerSignatureUIImageView_.image == nil) {
        return;
    }else {
        self.mCustomerSignatureUIImageView_.image = nil;
        [[SharedUtilities sharedUtilities] appDelegateInstance].mCheckInViewController_.mCustomerSignatureView_.mCustomerSignatureUIImageView_.mSignatureData_ = nil;
        if([[[SharedUtilities sharedUtilities] appDelegateInstance].mCheckInViewController_.mCustomerSignatureView_.mCustomerSignatureUIImageView_.lastPointsArr count ])
            [[[SharedUtilities sharedUtilities] appDelegateInstance].mCheckInViewController_.mCustomerSignatureView_.mCustomerSignatureUIImageView_.lastPointsArr removeAllObjects];
        if([[[SharedUtilities sharedUtilities] appDelegateInstance].mCheckInViewController_.mCustomerSignatureView_.mCustomerSignatureUIImageView_.currentPointsArr count])
            [[[SharedUtilities sharedUtilities] appDelegateInstance].mCheckInViewController_.mCustomerSignatureView_.mCustomerSignatureUIImageView_.currentPointsArr removeAllObjects];
        [[SharedUtilities sharedUtilities] deleteFileFromPath:kSIGNATURE_DATA_PATH];
    }
}

@end
