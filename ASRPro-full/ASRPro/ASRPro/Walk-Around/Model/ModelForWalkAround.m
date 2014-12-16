//
//  ModelForWalkAround.m
//  ASRPro
//
//  Created by GuruMurthy on 05/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ModelForWalkAround.h"

#import "CustomImageView.h"

#define kCount 4
//#define kWidth 3924
#define kWidth 4905

#define kMaximumContentOffset 4905
#define kMinimumContentOffset 981

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
@synthesize mTempmVehicleAngleForDamagesSetID_;

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
    self.mVehicleDiagramSetID_ = ([aRODetailsArray valueForKey:@"VehicleDiagramSetID"] != nil ?[[aRODetailsArray valueForKey:@"VehicleDiagramSetID"] integerValue]:1);
    DLog(@"%d",self.mVehicleDiagramSetID_);
    self.mDamageTypeIndex_ = NSNotFound;
    self.mSeverityTypeIndex_ = NSNotFound;
    self.mTempmVehicleAngleForDamagesSetID_ = NSNotFound;
}

/**
 * Method to set the X_Coord & Y_Coord
 * In VehicleDiagramsImageView [Line 67] after logpress on the imageview storing the X_Coord & Y_Coord;
 */
- (void)setXCoordAndYCoord :(CGPoint)aCGPoint {
    
     int index = [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView].contentOffset.x/981;
    
//    VehicleDiagramsImageView *imageView = [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] imagesArray] objectAtIndex:[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_]mTempmVehicleAngleForDamagesSetID_]];
    
    VehicleDiagramsImageView *imageView = [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] imagesArray] objectAtIndex:index];

    
    DLog(@"Vehicle Image Frame :%@",NSStringFromCGRect(imageView.frame));
//    float xCoord = ([[object valueForKey:@"X"] floatValue] * imageView.image.size.width) + [[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_].imageStartPositionOnScrollView;
//    float yCoord = ([[object valueForKey:@"Y"] floatValue] * imageView.image.size.height);
    
    self.mXCoord_ = aCGPoint.x/[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.frame.size.width;
    self.mYCoord_ = aCGPoint.y/[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.frame.size.height;
    DLog(@"x and y points %f,%f",self.mXCoord_,self.mYCoord_);
    

    self.mXCoord_ = aCGPoint.x/imageView.image.size.width;
    self.mYCoord_ = aCGPoint.y/imageView.image.size.height;
    DLog(@"x and y points %f,%f",self.mXCoord_,self.mYCoord_);
    
}
- (void)setTempararyPRERONumber :(NSString *)aTempPRERONumber {
    self.mTempPRE_RONumber = aTempPRERONumber;
}

- (void)setPRERONumber :(NSString *)aPRERONumber {
    self.mPRE_RONumber = aPRERONumber;
}

- (void)setDataForSelectedVehicleTypes {
    self.imagesArray = [[NSMutableArray alloc] init];
    [self setCategoryArray];
    [self setVehicleTypeAndAngleButtonNames];
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
    
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleTypeButton_.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[CustomImageView class]] || [object isKindOfClass:[UILabel class]]) {
            UIView *object1 = object;
            if (object1.tag == 1001 || object1.tag == 1002) {
                [object1 removeFromSuperview];
            }
        }
    }];
    
    
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
    
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleTypeButton_ setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleTypeButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleTypeButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    /*if ([self.mDamageDetailsArray_ count] > 0 || self.mDamageDetailsArray_ != nil) {
        [self.mDamageDetailsArray_ enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            if (self.mVehicleDiagramSetID_ == [[[object valueForKey:@"VehicleDiagram"] valueForKey:@"VehicleDiagramSetID"] integerValue]) {
                self.mTempmVehicleAngleForDamagesSetID_ = [[[object valueForKey:@"VehicleDiagram"] valueForKey:@"VehicleDiagramViewAngleID"] integerValue]-1;
                [self tableViewSelectedAtIndexPath:[NSIndexPath indexPathForRow:self.mTempmVehicleAngleForDamagesSetID_ inSection:0]];
                [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleAngleButton_ setTitle:[self getTextFromVehicleDiagramViewAngleID:[object valueForKey:@"VehicleDiagram"]] forState:UIControlStateNormal];
                [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleAngleButton_ setTitle:[self getTextFromVehicleDiagramViewAngleID:[object valueForKey:@"VehicleDiagram"]] forState:UIControlStateSelected];
                *stop = YES;
            }
        }];
    }else */{
        self.mTempmVehicleAngleForDamagesSetID_ = 0;
        [self tableViewSelectedAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleAngleButton_ setTitle:@"Left" forState:UIControlStateNormal];
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleAngleButton_ setTitle:@"Left" forState:UIControlStateSelected];
    }
    
    if (self.mTempmVehicleAngleForDamagesSetID_ == 0 || self.mTempmVehicleAngleForDamagesSetID_ == NSNotFound) {
        self.mTempmVehicleAngleForDamagesSetID_ = 0;
        [self tableViewSelectedAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleAngleButton_ setTitle:@"Left" forState:UIControlStateNormal];
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleAngleButton_ setTitle:@"Left" forState:UIControlStateSelected];
    }
    
    
    
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
//    CategoryWalkAround *category = (CategoryWalkAround *)[self.mCategoryListArray_ objectAtIndex:self.mTempmVehicleDiagramForDamagesSetID_] ;
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_ setImage:[UIImage imageNamed:@""]];
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_ removeButtonFromImageView];
    if ([[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.activityView superview]) {
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.activityView stopAnimating];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.activityView removeFromSuperview];
    }
    
    [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.activityView = nil;
    
    [self setImagesOnScrolLView];
//    [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_ setCustomImageURL:[NSURL URLWithString:[self getImageUrlFromVehicleDiagramViewAngleID:[category.mVehicleDiagramsList objectAtIndex:indexPath.row]]]];
    
    self.mVehicleDiagramViewAngleID_ = indexPath.row + 1;
    [[SharedUtilities sharedUtilities] appDelegateInstance].mGetVehicleDamagepointOnImageView_ = [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_;

}

#pragma mark --
#pragma mark Set Images On the scrollView Method
- (void)setImagesOnScrolLView {
    DLog(@"WalkAround Memory :-%@",[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_]);
    if ([[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] == nil) {
        return;
    }
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[VehicleDiagramsImageView class]]) {
            VehicleDiagramsImageView *object1 = object;
            [object1 removeFromSuperview];
        }
    }];
    
    CategoryWalkAround *category = (CategoryWalkAround *)[self.mCategoryListArray_ objectAtIndex:self.mTempmVehicleDiagramForDamagesSetID_] ;
    
    __block CGFloat cx = 5.0f;
    self.imageStartPositionOnScrollView = cx;
    [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView.delegate = self;
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView setPagingEnabled:YES];
    //Adding last image at the first.
    [category.mVehicleDiagramsList enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if (index < 4) {
            DLog(@"Do not add the images from index 1 to 3. Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
        }else {
            CGRect rect = [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView.frame;
            rect.size.height = rect.size.height;
            rect.size.width = rect.size.width - 10.0f;
            rect.origin.x = cx;
            rect.origin.y = 0.0f;
            [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_ = [[VehicleDiagramsImageView alloc] init];
            [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.mUIImageViewDispatchLoader_ = IsVehicleTypeImage;
            [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.frame = rect;
            [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_  setUserInteractionEnabled:YES];
            [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_ handleLongPressOnImageView];
            [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_ setCustomImageURL:[NSURL URLWithString:[self getImageUrlFromVehicleDiagramViewAngleID:[category.mVehicleDiagramsList objectAtIndex:index]]]];
            [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_ setContentMode:UIViewContentModeScaleAspectFit];
            cx += [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.frame.size.width + 10.0f;
            DLog(@"Image Frame :- %@",[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_);
            
            [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView addSubview:[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_];
            [self.imagesArray addObject:[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_];
            *stop = YES;
        }
    }];
    
    
    //Adding all images.
    [category.mVehicleDiagramsList enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        CGRect rect = [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView.frame;
        rect.size.height = rect.size.height;
        rect.size.width = rect.size.width - 10.0f;
        rect.origin.x = cx;
        rect.origin.y = 0.0f;
        [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_ = [[VehicleDiagramsImageView alloc] init];
        [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.mUIImageViewDispatchLoader_ = IsVehicleTypeImage;
        [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.frame = rect;
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_  setUserInteractionEnabled:YES];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_ handleLongPressOnImageView];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_ setCustomImageURL:[NSURL URLWithString:[self getImageUrlFromVehicleDiagramViewAngleID:[category.mVehicleDiagramsList objectAtIndex:index]]]];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_ setContentMode:UIViewContentModeScaleAspectFit];
        cx += [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.frame.size.width + 10.0f;
        DLog(@"Image Frame :- %@",[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_);
        
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView addSubview:[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_];
        [self.imagesArray addObject:[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_];
    }];
    
    //Adding first image at the last.
    [category.mVehicleDiagramsList enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        CGRect rect = [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView.frame;
        rect.size.height = rect.size.height;
        rect.size.width = rect.size.width - 10.0f;
        rect.origin.x = cx;
        rect.origin.y = 0.0f;
        [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_ = [[VehicleDiagramsImageView alloc] init];
        [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.mUIImageViewDispatchLoader_ = IsVehicleTypeImage;
        [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.frame = rect;
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_  setUserInteractionEnabled:YES];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_ handleLongPressOnImageView];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_ setCustomImageURL:[NSURL URLWithString:[self getImageUrlFromVehicleDiagramViewAngleID:[category.mVehicleDiagramsList objectAtIndex:index]]]];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_ setContentMode:UIViewContentModeScaleAspectFit];
        cx += [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_.frame.size.width + 10.0f;
        DLog(@"Image Frame :- %@",[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_);
        
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView addSubview:[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_];
        [self.imagesArray addObject:[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_];
        *stop = YES;
    }];
    
    [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView.contentSize = CGSizeMake([[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView.frame.size.width *
                                                                                                                           ([category.mVehicleDiagramsList count] + 2),
                                                                                                                           [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView.frame.size.height);
    if (self.mTempmVehicleAngleForDamagesSetID_ == NSNotFound || self.mTempmVehicleAngleForDamagesSetID_ == nil) {
           [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView setContentOffset:CGPointMake([[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView.frame.size.width * 1, 0.0f)];
    }else {
        int index = self.mTempmVehicleAngleForDamagesSetID_ + 1;
           [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView setContentOffset:CGPointMake([[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView.frame.size.width * index, 0.0f)];
    }
 }

- (void)adjustAreaScroll:(int)vehicleDiagramViewAngleID
{
    int lVehicleDiagramViewAngleID = vehicleDiagramViewAngleID + 1;
    
    switch (lVehicleDiagramViewAngleID) {
        case 0:
            [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView setContentOffset:CGPointMake([[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView.frame.size.width * lVehicleDiagramViewAngleID, 0.0f)];
            break;
        case 1:
            [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView setContentOffset:CGPointMake([[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView.frame.size.width * lVehicleDiagramViewAngleID, 0.0f)];
            break;
        case 2:
            [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView setContentOffset:CGPointMake([[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView.frame.size.width * lVehicleDiagramViewAngleID, 0.0f)];
            break;
        case 3:
            [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView setContentOffset:CGPointMake([[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView.frame.size.width * lVehicleDiagramViewAngleID, 0.0f)];
            break;
        case 4:
            [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView setContentOffset:CGPointMake([[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView.frame.size.width * lVehicleDiagramViewAngleID, 0.0f)];
            break;
        default:
            [[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView setContentOffset:CGPointMake([[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView.frame.size.width * lVehicleDiagramViewAngleID, 0.0f)];
            break;
    }
     self.imageStartPositionOnScrollView = [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView .contentOffset.x;
    DLog(@"target position -----> %f", [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView.contentOffset.x);
}

#pragma mark --
#pragma mark Scroll View Delegate Methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == nil) {
        [self adjustAreaScroll:self.mTempmVehicleAngleForDamagesSetID_];
    }else {
        //update the page position when reached the start and end pages
        if ( scrollView.contentOffset.x < kMinimumContentOffset) {
            [scrollView setContentOffset:CGPointMake(kMaximumContentOffset,0) animated:NO];
        }
        else if ( scrollView.contentOffset.x > kMaximumContentOffset) {
            [scrollView setContentOffset:CGPointMake(kMinimumContentOffset,0) animated:NO];
        }

        int imageIdentifier = ([[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView .contentOffset.x - 981)/[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView .frame.size.width;
        [[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].nextCount = imageIdentifier;
        self.imageStartPositionOnScrollView = [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.scrollView .contentOffset.x;
        self.mTempmVehicleAngleForDamagesSetID_ = imageIdentifier;
        self.mVehicleDiagramViewAngleID_ = imageIdentifier + 1;
    }

    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleAngleButton_ setTitle:[self getTextFromVehicleDiagramViewAngleID:nil] forState:UIControlStateNormal];
    
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleAngleButton_ setTitle:[self getTextFromVehicleDiagramViewAngleID:nil] forState:UIControlStateSelected];
    
    
    if ([[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_].mDamageDetailsArray_ count] > 0 || [[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_].mDamageDetailsArray_ != nil) {
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mGetVehicleDamagepointOnImageView_] getVehicleDamagePointsOnTheImageViewIndex:self.mVehicleDiagramViewAngleID_ VehicleDiagramSetID:self.mVehicleDiagramForDamagesSetID_];
    }
//    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] setNextPreviousButtons];
}

- (NSString *)getTextFromVehicleDiagramViewAngleID :(NSMutableDictionary *)aMutableDictionary {
    NSString *vehicleAngleName;
    __block int vehicleDiagramViewAngleID;
    if (aMutableDictionary != nil) {
        [aMutableDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
            if ([key isEqualToString:@"VehicleDiagramViewAngleID"]) {
                vehicleDiagramViewAngleID = [object integerValue];
                *stop = YES;
            }
        }];
    }else {
        vehicleDiagramViewAngleID = self.mTempmVehicleAngleForDamagesSetID_;
        vehicleDiagramViewAngleID = vehicleDiagramViewAngleID + 1;
    }
    
    switch (vehicleDiagramViewAngleID) {
        case 1:
            vehicleAngleName = @"Left";
            break;
        case 2:
            vehicleAngleName = @"Front";
            break;
        case 3:
            vehicleAngleName = @"Right";
            break;
        case 4:
            vehicleAngleName = @"Rear";
            break;
        case 5:
            vehicleAngleName = @"Top";
            break;
        default:
            break;
    }
    return vehicleAngleName;
}

@end
