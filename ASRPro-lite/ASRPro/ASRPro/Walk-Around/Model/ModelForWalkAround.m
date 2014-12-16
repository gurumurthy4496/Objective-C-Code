//
//  ModelForWalkAround.m
//  ASRPro
//
//  Created by GuruMurthy on 05/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ModelForWalkAround.h"

#import "CustomImageView.h"
#import "CheckInSupportWebEngine.h"

@implementation ModelForWalkAround
@synthesize mButtonID_;
@synthesize mVehicleName_;
@synthesize mPRE_RONumber;
@synthesize mTempPRE_RONumber;
@synthesize mVehicleDiagramSetsArray_;
@synthesize mSelectedVehicleDiagramDictionary_;
@synthesize mRepairOrderDetailsArray_;
@synthesize mDamageDetailsArray_;
@synthesize mTempmVehicleDiagramForDamagesSetID_;

@synthesize mNotesString_;
@synthesize mDamageTypeString_;
@synthesize mSeverityString_;
@synthesize mDamageTypeIndex_;
@synthesize mSeverityTypeIndex_;
@synthesize mVehicleDiagramSetID_;
@synthesize mVehicleDiagramViewAngleID_;
@synthesize mXCoord_;
@synthesize mYCoord_;
@synthesize mImageData_;

/**
 * Method to set the WalkAroundData
 * In WalkAroundSupportWebEngine [Line 353] after success response for RepairOrderDetails API;
 */
- (void)setWalkAroundData :(NSMutableArray *)aRODetailsArray {
    self.mVehicleDiagramSetID_ = [[aRODetailsArray valueForKey:@"VehicleDiagramSetID"] integerValue];
    DLog(@"%d",self.mVehicleDiagramSetID_);
    self.mDamageTypeIndex_ = NSNotFound;
    self.mSeverityTypeIndex_ = NSNotFound;
}

/**
 * Method to set the X_Coord & Y_Coord
 * In VehicleDiagramsImageView [Line 67] after logpress on the imageview storing the X_Coord & Y_Coord;
 */
- (void)setXCoordAndYCoord :(CGPoint)aCGPoint {
    self.mXCoord_ = aCGPoint.x/[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.frame.size.width;
    self.mYCoord_ = aCGPoint.y/[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.frame.size.height;
    NSLog(@"x and y points %f,%f",self.mXCoord_,self.mYCoord_);
}
- (void)setTempararyPRERONumber :(NSString *)aTempPRERONumber {
    self.mTempPRE_RONumber = aTempPRERONumber;
}

- (void)setPRERONumber :(NSString *)aPRERONumber {
    self.mPRE_RONumber = aPRERONumber;
}

- (void)setDataForSelectedVehicleTypes {
    [self setCategoryArray];
    [self setVehicleTypeAndAngleButtonNames];
    [self tableViewSelectedAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

- (void) setCategoryArray
{
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    [self.mVehicleDiagramSetsArray_ enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop){
        CategoryWalkAround *category = [[CategoryWalkAround alloc] init];
        //        if ([[object valueForKey:@"ID"] integerValue] <= 10) {
        category.mVehicleName = [object valueForKey:@"Name"];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0; i < 5; i++) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            NSString *VehicleDiagramSetID = [NSString stringWithFormat:@"%d",[[object valueForKey:@"ID"] integerValue]];
            NSString *VehicleDiagramViewAngleID = [NSString stringWithFormat:@"%d",i + 1];
            NSString *str = [NSString stringWithFormat:@"http://static.asrpro.com/Images/VehicleDiagrams/%@/%@.png",VehicleDiagramSetID,VehicleDiagramViewAngleID];
            [dict setValue:VehicleDiagramSetID forKey:@"VehicleDiagramSetID"];
            [dict setValue:VehicleDiagramViewAngleID forKey:@"VehicleDiagramViewAngleID"];
            [dict setValue:str forKey:@"ImageURL"];
            [array addObject:dict];
            DLog(@"%@",array);
        }
        category.mVehicleDiagramsList = array;
        [categoryArray addObject:category];
        //        }
    }];
    self.mCategoryListArray_ = categoryArray;
}

- (void)setVehicleTypeAndAngleButtonNames {
    
    [self.mVehicleDiagramSetsArray_ enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if (self.mVehicleDiagramSetID_ == [[object valueForKey:@"ID"] integerValue]) {
            self.mVehicleDiagramForDamagesSetID_ = [[object valueForKey:@"ID"] integerValue];
//             self.mTempmVehicleDiagramForDamagesSetID_ = [[object valueForKey:@"ID"] integerValue] - 1;
            //mTempmVehicleDiagramForDamagesSetID_ is used to store the index for the VehicleTypes TableView
            self.mTempmVehicleDiagramForDamagesSetID_ = index;
            [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleTypeButton_ setTitle:@"" forState:UIControlStateNormal];
            [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleTypeButton_ setTitle:@"" forState:UIControlStateSelected];
            CustomImageView *imageView = [[CustomImageView alloc] init];
            imageView.frame = CGRectMake(15, 5, 69, 30);
            imageView.tag = 1001;
            NSString *image = [[object valueForKey:@"Name"] stringByReplacingOccurrencesOfString:@" " withString:@""];
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_blue",image]];
            imageView.highlightedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",image]];
            imageView.mImageName_ = image;
            UILabel *label = [[UILabel alloc] init];
            [label setFrame:CGRectMake(15 + 100 + 20, 0, 280, 40)];
            label.tag = 1002;
            [label setText:[object valueForKey:@"Name"]];
            [label setTextColor:[UIColor ASRProBlueColor]];
            [label setHighlightedTextColor:[UIColor whiteColor]];
            
            [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleTypeButton_ addSubview:imageView];
            [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleTypeButton_ addSubview:label];

            *stop = YES;
        }
    }];
    
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleAngleButton_ setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 50)];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleAngleButton_ setTitle:@"Top" forState:UIControlStateNormal];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleAngleButton_ setTitle:@"Top" forState:UIControlStateSelected];
    self.mTempmVehicleAngleForDamagesSetID_ = 0;
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleTypeButton_ setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleTypeButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleTypeButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    
    
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleAngleButton_ setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleAngleButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].
     mVehicleAngleButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];


}


- (NSString *)getImageUrlFromVehicleDiagramViewAngleID :(NSMutableDictionary *)aMutableDictionary {
    __block NSString *imageUrl;
    [aMutableDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
        if ([key isEqualToString:@"ImageURL"]) {
            imageUrl = object;
            *stop = YES;
        }
    }];
    return imageUrl;
}


#pragma mark --
#pragma mark Class Public Methods

-(void)tableViewSelectedAtIndexPath:(NSIndexPath *)indexPath {
    CategoryWalkAround *category = (CategoryWalkAround *)[self.mCategoryListArray_ objectAtIndex:self.mTempmVehicleDiagramForDamagesSetID_] ;
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_ setImage:[UIImage imageNamed:@""]];
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_ removeButtonFromImageView];
    if ([[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.activityView superview]) {
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.activityView stopAnimating];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.activityView removeFromSuperview];
    }
    
    [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.mUIImageViewDispatchLoader_ = IsVehicleTypeImage;
    
    [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.activityView = nil;
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_ setCustomImageURL:[NSURL URLWithString:[self getImageUrlFromVehicleDiagramViewAngleID:[category.mVehicleDiagramsList objectAtIndex:indexPath.row]]]];
    
    self.mVehicleDiagramViewAngleID_ = indexPath.row + 1;
    [[SharedUtilities sharedUtilities] appDelegateInstance].mGetVehicleDamagepointOnImageView_ = [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_;

}

- (NSString *)getTextFromVehicleDiagramViewAngleID :(NSMutableDictionary *)aMutableDictionary {
    NSString *vehicleAngleName;
    __block int vehicleDiagramViewAngleID;
    [aMutableDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
        if ([key isEqualToString:@"VehicleDiagramViewAngleID"]) {
            vehicleDiagramViewAngleID = [object integerValue];
            *stop = YES;
        }
    }];
    switch (vehicleDiagramViewAngleID) {
        case 1:
            vehicleAngleName = @"Top";
            break;
        case 2:
            vehicleAngleName = @"Left";
            break;
        case 3:
            vehicleAngleName = @"Right";
            break;
        case 4:
            vehicleAngleName = @"Front";
            break;
        case 5:
            vehicleAngleName = @"Rear";
            break;
        default:
            break;
    }
    return vehicleAngleName;
}

@end
