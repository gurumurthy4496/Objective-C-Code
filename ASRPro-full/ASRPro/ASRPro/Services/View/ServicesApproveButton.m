//
//  ServicesApproveButton.m
//  ASRPro
//
//  Created by Kalyani on 05/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ServicesApproveButton.h"

#define UNDECIDED_IMAGE [UIImage imageNamed:@"IMG_grey_hand_icon.png"]
#define APPROVE_IMAGE [UIImage imageNamed:@"IMG_green_thumbsup_icon.png"]
#define DECLINE_IMAGE [UIImage imageNamed:@"IMG_green_thumbsDown_icon.png"]


@implementation ServicesApproveButton
@synthesize approvestate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        cellRow=0;
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

-(void)setApprovestate:(gettbuttonstate)anapprovestate{
    approvestate=anapprovestate;
    if(approvestate ==APPROVESTATE)
      [ self setBackgroundImage:APPROVE_IMAGE forState:UIControlStateNormal];
    else if (approvestate==DECLINESTATE)
        [ self setBackgroundImage:DECLINE_IMAGE forState:UIControlStateNormal];
else if (approvestate==UNDECIDEDSTATE)
    [ self setBackgroundImage:UNDECIDED_IMAGE forState:UIControlStateNormal];

}

@end
