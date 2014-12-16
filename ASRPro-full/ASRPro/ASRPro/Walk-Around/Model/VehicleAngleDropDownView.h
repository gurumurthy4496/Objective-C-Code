//
//  VehicleAngleDropDownView.h
//  ASRPro
//
//  Created by GuruMurthy on 05/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VehicleAngleDropDownView;

@protocol VehicleAngleDropDownViewDelegate
- (void)vehicleAngleDropDownViewDelegateMethod :(VehicleAngleDropDownView *)sender;
@end


@interface VehicleAngleDropDownView : UIView<UITableViewDelegate, UITableViewDataSource>
{
    NSString *animationDirection;
}
@property (nonatomic, retain) id <VehicleAngleDropDownViewDelegate> delegate;
@property (nonatomic, retain) NSString *animationDirection;

-(void)hideVehicleAngleDropDown:(UIButton *)button;
- (id)showVehicleAngleDropDown:(UIButton *)aButton Height:(CGFloat *)aHeight Array:(NSArray *)aArray Direction:(NSString *)aDirection;

@end
