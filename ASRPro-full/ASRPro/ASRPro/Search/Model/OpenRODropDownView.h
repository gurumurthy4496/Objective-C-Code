//
//  OpenRODropDownView.h
//  ASRPro
//
//  Created by GuruMurthy on 22/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OpenRODropDownView;

@protocol OpenRODropDownDelegate
- (void) OpenRODropDownDelegateMethod :(OpenRODropDownView *)sender;
@end

@interface OpenRODropDownView : UIView <UITableViewDelegate, UITableViewDataSource>
{
    NSString *animationDirection;
}
@property (nonatomic, retain) id <OpenRODropDownDelegate> delegate;
@property (nonatomic, retain) NSString *animationDirection;

-(void)hideOpenRODropDown:(UIButton *)button;
- (id)showOpenRODropDown:(UIButton *)aButton Height:(CGFloat *)aHeight Array:(NSArray *)aArray Direction:(NSString *)aDirection;

@end
