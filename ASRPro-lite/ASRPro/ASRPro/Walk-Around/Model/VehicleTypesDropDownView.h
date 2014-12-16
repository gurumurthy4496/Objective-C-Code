//
//  VehicleTypesDropDownView.h
//  ASRPro
//
//  Created by GuruMurthy on 05/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImageView.h"

@class VehicleTypesDropDownView;

@protocol VehicleTypesDropDownViewDelegate
- (void)vehicleTypesDropDownViewDelegateMethod: (VehicleTypesDropDownView *) sender;
@end

@interface VehicleTypesDropDownView : UIView <UITableViewDelegate, UITableViewDataSource>
{
    NSString *animationDirection;
    CustomImageView *imgView;
    UILabel *mLabel;
}
@property (nonatomic, retain) id <VehicleTypesDropDownViewDelegate> delegate;
@property (nonatomic, retain) NSString *animationDirection;
-(void)hideVehicleTypesDropDown:(UIButton *)button;
- (id)showVehicleTypesDropDown:(UIButton *)aButton Height:(CGFloat *)aHeight Array:(NSArray *)aArray ImageArray:(NSArray *)aImageArray Direction:(NSString *)aDirection;
@end
