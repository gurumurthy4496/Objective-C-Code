//
//  VehicleDiagramsImageView.m
//  ASRPro
//
//  Created by GuruMurthy on 05/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "VehicleDiagramsImageView.h"

@implementation VehicleDiagramsImageView
@synthesize mAddDamageViewController_;
@synthesize mOnTapPointButton_;
@synthesize mDamagePopupViewController_;

@synthesize mBuildInspectionDetailsViewController_;

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

#pragma mark --
#pragma mark Public Methods
/**
 * Method to show the border for ImageView 
 * WalkAroundViewController [Line 38].
 */
- (void)setBorderForImageView {
//    [self.layer setBorderColor:[[UIColor ASRProBlueColor] CGColor]];
//    [self.layer setBorderWidth:2];
    
    
    /*CALayer *leftBorder = [CALayer layer];
    leftBorder.borderColor = [UIColor ASRProBlueColor].CGColor;
    leftBorder.borderWidth = 2;
    leftBorder.frame = CGRectMake(self.frame.origin.x - 5 , self.frame.origin.y - 5, 2, self.frame.size.height + 10);
    [self.superview.layer addSublayer:leftBorder];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = [UIColor ASRProBlueColor].CGColor;
    bottomBorder.borderWidth = 2;
    bottomBorder.frame = CGRectMake(self.frame.origin.x - 5, self.frame.origin.y + self.frame.size.height + 5, self.frame.size.width + 10.5, 2);
    [self.superview.layer addSublayer:bottomBorder];
    
    CALayer *rightBorder = [CALayer layer];
    rightBorder.borderColor = [UIColor ASRProBlueColor].CGColor;
    rightBorder.borderWidth = 2;
    rightBorder.frame = CGRectMake(self.frame.origin.x + self.frame.size.width + 5, self.frame.origin.y - 5, 2, self.frame.size.height+10.5);
    [self.superview.layer addSublayer:rightBorder];
    
    [self setUserInteractionEnabled:YES];*/
    CALayer *leftBorder = [CALayer layer];
    leftBorder.borderColor = [UIColor ASRProBlueColor].CGColor;
    leftBorder.borderWidth = 2;
    leftBorder.frame = CGRectMake(self.frame.origin.x - 5 , self.frame.origin.y - 5, 2, self.frame.size.height + 10);
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView].superview.layer addSublayer:leftBorder];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = [UIColor ASRProBlueColor].CGColor;
    bottomBorder.borderWidth = 2;
    bottomBorder.frame = CGRectMake(self.frame.origin.x - 5, self.frame.origin.y + self.frame.size.height + 5, self.frame.size.width + 10.5, 2);
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView].superview.layer addSublayer:bottomBorder];
    
    CALayer *rightBorder = [CALayer layer];
    rightBorder.borderColor = [UIColor ASRProBlueColor].CGColor;
    rightBorder.borderWidth = 2;
    rightBorder.frame = CGRectMake(self.frame.origin.x + self.frame.size.width + 5, self.frame.origin.y - 5, 2, self.frame.size.height+10.5);
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView].superview.layer addSublayer:rightBorder];
    
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView] setUserInteractionEnabled:YES];
    
    
//    [self handleLongPressOnImageView];
}

/**
 * METHOD TO REMOVE BUTTONS ON THE IMAGEVIEW.
 * In VehicleDiagramSetsTableView [Line 377]
 */
- (void)removeButtonFromImageView {
    [self.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        CustomButtonOnImageView *lButton_ = object;
        if ([lButton_ isKindOfClass:[CustomButtonOnImageView class]]) {
            [lButton_ removeFromSuperview];
            DLog(@"Removed button");
        }
    }];
}

#pragma mark --
#pragma mark Protocol Method
/**
 * Method display the vehicle damage points on the imageview
 * In UIImageView+DispatchLoad Method [Line 37](calling method) & In VehicleDiagramSetsTableView [Line 377](setting delegate);
 */
- (void)getVehicleDamagePointsOnTheImageViewIndex:(int)aVehicleDiagramViewAngleID VehicleDiagramSetID:(int)aVehicleDiagramSetID {

    
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] setNextPreviousButtons];
   
    int index = [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView].contentOffset.x/981;
    
//    VehicleDiagramsImageView *imageView = [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] imagesArray] objectAtIndex:[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_]mTempmVehicleAngleForDamagesSetID_]];
    
    VehicleDiagramsImageView *imageView = [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] imagesArray] objectAtIndex:index];

    
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView].subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop){
        if ([object isKindOfClass:[CustomButtonOnImageView class]]) {
            CustomButtonOnImageView *object1 = object;
            [object1 removeFromSuperview];
        }
    }];
    
    // ----------------------------;
    // Method display the vehicle damage points on the imageview;
    // ----------------------------;
    if ([self.activityView superview]) {
        [self.activityView startAnimating];
        [self.activityView removeFromSuperview];
    }
    
    if ([[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_].mDamageDetailsArray_ count] > 0 || [[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_].mDamageDetailsArray_ != nil) {
        
        [[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_].mDamageDetailsArray_ enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            if ([[[object valueForKey:@"VehicleDiagram"] valueForKey:@"VehicleDiagramViewAngleID"] integerValue] == aVehicleDiagramViewAngleID && [[[object valueForKey:@"VehicleDiagram"] valueForKey:@"VehicleDiagramSetID"] integerValue] == aVehicleDiagramSetID) {
                
                /*float xCoord = ([[object valueForKey:@"X"] floatValue] * imageView.frame.size.width) + [[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_].imageStartPositionOnScrollView;
                float yCoord = ([[object valueForKey:@"Y"] floatValue] * imageView.frame.size.height);*/
                
//                float xCoord = ([[object valueForKey:@"X"] floatValue] * imageView.frame.size.width) + /**[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_].imageStartPositionOnScrollView +*/ imageView.frame.origin.x - 5;
//                float yCoord = ([[object valueForKey:@"Y"] floatValue] * imageView.frame.size.height) + imageView.frame.origin.y - 5;
                
                //The width of the Button
                float xCoord = ([[object valueForKey:@"X"] floatValue] * imageView.frame.size.width) + imageView.frame.origin.x - (30/2);
                float yCoord = ([[object valueForKey:@"Y"] floatValue] * imageView.frame.size.height) + imageView.frame.origin.y - (30/2);
                
                
                DLog(@"xCoord :%f yCoord :%f",xCoord,yCoord);
//                NSString *damageOrSeverityTypeString = [self returnDamageTypeOrSeverityType:[[object valueForKey:@"VehicleDamageSeverityID"] integerValue] isSeverity:YES];
                CustomButtonOnImageView * addButtonOnTapPoint = [CustomButtonOnImageView buttonWithType:UIButtonTypeCustom];
                addButtonOnTapPoint.frame = CGRectMake(xCoord, yCoord, 30, 30);
                addButtonOnTapPoint.layer.cornerRadius = 15;//half of the width
                addButtonOnTapPoint.mID_ = [object valueForKey:@"ID"];
                addButtonOnTapPoint.mVehicleDamageDetailTypeID_ = [object valueForKey:@"VehicleDamageDetailTypeID"];
                addButtonOnTapPoint.mVehicleDamageSeverityID_ = [object valueForKey:@"VehicleDamageSeverityID"];
                addButtonOnTapPoint.mNotes_ = [object valueForKey:@"Notes"];
                NSMutableArray *lImageArray = [object valueForKey:@"VehicleDamageDetailImages"];
                DLog(@"%@",lImageArray);
                if ([lImageArray count] > 0) {
                    addButtonOnTapPoint.mImageURL_ = [[[object valueForKey:@"VehicleDamageDetailImages"] objectAtIndex:0] valueForKey:@"ImageURL"];
                }
                [addButtonOnTapPoint addTarget:imageView action:@selector(onTapPointButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                [addButtonOnTapPoint setBackgroundColor:[UIColor clearColor]];
                [addButtonOnTapPoint setUserInteractionEnabled:TRUE];
                [addButtonOnTapPoint setClipsToBounds:YES];
                [addButtonOnTapPoint setSelected:YES];
                [imageView setClipsToBounds:YES];
                
                
                [addButtonOnTapPoint setMDamageType_:[self returnDamageTypeOrSeverityType:[[object valueForKey:@"VehicleDamageDetailTypeID"] integerValue] isSeverity:NO]];
                [addButtonOnTapPoint setMSeverityType_:[self returnDamageTypeOrSeverityType:[[object valueForKey:@"VehicleDamageSeverityID"] integerValue] isSeverity:YES]];
                
                NSString *severityTypeString = [self returnDamageTypeOrSeverityType:[[object valueForKey:@"VehicleDamageSeverityID"] integerValue] isSeverity:YES];
                NSString *damageTypeString = [self returnDamageTypeOrSeverityType:[[object valueForKey:@"VehicleDamageDetailTypeID"] integerValue] isSeverity:NO];
                
                [addButtonOnTapPoint setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_%@",damageTypeString,severityTypeString]] forState:UIControlStateNormal];
                [addButtonOnTapPoint setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_%@",damageTypeString,severityTypeString]] forState:UIControlStateSelected];
                
               /* if ([damageOrSeverityTypeString isEqualToString:@"Mild"]) {
                    [addButtonOnTapPoint setBackgroundColor:[UIColor ASRProRGBColor:241.0 Green:196.0 Blue:13.0]];
                }else if ([damageOrSeverityTypeString isEqualToString:@"Moderate"]) {
                    [addButtonOnTapPoint setBackgroundColor:[UIColor ASRProRGBColor:230.0 Green:126.0 Blue:34.0]];
                } else if ([damageOrSeverityTypeString isEqualToString:@"Severe"]) {
                    [addButtonOnTapPoint setBackgroundColor:[UIColor ASRProRGBColor:231.0 Green:76.0 Blue:60.0]];
                }*/
                //            [self addSubview:addButtonOnTapPoint];
                //            [self bringSubviewToFront:addButtonOnTapPoint];
                

                [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView] addSubview:addButtonOnTapPoint];
                [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView] bringSubviewToFront:addButtonOnTapPoint];
            }
        }];
    }
}

- (NSString *)getTextFromVehicleDiagramViewAngleID :(int)VehicleDiagramViewAngleID {
    NSString *vehicleAngleName;
    
    switch (VehicleDiagramViewAngleID) {
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

#pragma mark --
#pragma mark Private Methods
/**
 * Method for handle Longpress On ImageView called in this class
 * Self Called this method in [Line 46];
 */
- (void)handleLongPressOnImageView {
    /*UILongPressGestureRecognizer *lLongPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lLongPressGestureRecognizer.minimumPressDuration = 0.3;//user must press for 2 seconds
    lLongPressGestureRecognizer.delegate = self;
    lLongPressGestureRecognizer.delaysTouchesBegan = YES;
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:lLongPressGestureRecognizer];*/
}

/**
 * Selector method for UILongPressGestureRecognizer
 * Self Called this method in [Line 129];
 */
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    
    VehicleDiagramsImageView *view = (VehicleDiagramsImageView *)gestureRecognizer.view;
    DLog(@"Vehicle Image Frame :%@",NSStringFromCGRect(view.frame));
    CGPoint point = [gestureRecognizer locationInView:view];
    DLog(@"%@",gestureRecognizer);
    DLog(@"%@",NSStringFromCGPoint(point));
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        // GESTURE STATE BEGAN
        
    }else {
        return;
    }
    if (view.image == nil) {
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lALERT_TITLE", nil) message:@"No VehicleType Image Found"];
        return;
    }
    [self showAddDamageView :point];
}

/**
 * Show the Add Damage View on Walk-Around view.
 * Self Called this method in [Line 169]
 */
- (void)showAddDamageView :(CGPoint)aCGPoint {
    //Below Lines are commented as per the issue 56 reported in google doc.[Remove add damage icon and go back to India way, where user clicks and holds for damage moda window to come up];
    /*if([self.mAddDamageViewController_.view superview]) {
        [self.mAddDamageViewController_.view removeFromSuperview];
    }
    
    if (self.mAddDamageViewController_ == nil) {
        AddDamageViewController *lViewController = [[AddDamageViewController alloc]initWithNibName:@"AddDamageViewController" bundle:nil];
        self.mAddDamageViewController_ =lViewController;
    }
    //If LogoutViewController is not a superview then add to Subview.
    
    [self.mAddDamageViewController_.view setBackgroundColor:[UIColor clearColor]];
    
    [self.superview addSubview:self.mAddDamageViewController_.view];
    [self.superview bringSubviewToFront:self.mAddDamageViewController_.view];*/
    
    [[WalkAroundSupportWebEngine walkAroundSharedInstance] setMVehicleDiagramRequest_:VehicleDiagramPOSTRequest];
    BuildInspectionDetailsViewController *lViewCotroller = [[BuildInspectionDetailsViewController alloc] initWithNibName:@"BuildInspectionDetailsViewController" bundle:nil];
    self.mBuildInspectionDetailsViewController_ = lViewCotroller;
    [[SharedUtilities sharedUtilities] appDelegateInstance]. buildInspectionDetailsViewController = self.mBuildInspectionDetailsViewController_;
    self.mBuildInspectionDetailsViewController_.modalPresentationStyle = UIModalPresentationFormSheet;
    self.mBuildInspectionDetailsViewController_.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_.topViewController presentViewController:self.mBuildInspectionDetailsViewController_ animated:YES completion:nil];
    
//    [self.mAddDamageViewController_ setGCPointForAddDamageView:aCGPoint];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] setXCoordAndYCoord:aCGPoint];
}

/**
 * Method to show the damage type in the imageview when taped on the damage spot 
 * Self Called this method in [Line 104];
 */
- (IBAction)onTapPointButtonAction : (id)sender {
    self.mOnTapPointButton_ = (CustomButtonOnImageView *)sender;
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] mVehicleDiagramsImageView_] setMOnTapPointButton_:self.mOnTapPointButton_];
    __block float xCoord = 0.0f;
    __block float yCoord = 0.0f;
    if ([[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] mDamageDetailsArray_] count] > 0 || [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] mDamageDetailsArray_] != nil) {

    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] mDamageDetailsArray_] enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([self.mOnTapPointButton_.mID_ isEqualToString:[object valueForKey:@"ID"]]) {
            DLog(@"%@",self.mOnTapPointButton_.mID_);
            DLog(@"%@",[object valueForKey:@"ID"]);
             xCoord = ([[object valueForKey:@"X"] floatValue] * self.frame.size.width);
             yCoord = ([[object valueForKey:@"Y"] floatValue] * self.frame.size.height);
        }
    }];
    }
    CGPoint xyCoord = CGPointMake(xCoord, yCoord);
    [self showDamagePopupView:xyCoord DamageType:self.mOnTapPointButton_.mDamageType_];
}

/**
 * Show the Damage Popup View.
 * Self Called this method in [Line 155]
 */
- (void)showDamagePopupView :(CGPoint)aCGPoint DamageType :(NSString *)aDamageType {
    
    /*if([self.mDamagePopupViewController_.view superview]) {
        [self.mDamagePopupViewController_.view removeFromSuperview];
        self.mDamagePopupViewController_ = nil;
    }
    
    if (self.mDamagePopupViewController_ == nil) {
        DamagePopupViewController *lViewController = [[DamagePopupViewController alloc]initWithNibName:@"DamagePopupViewController" bundle:nil];
        self.mDamagePopupViewController_ =lViewController;
    }
    //If LogoutViewController is not a superview then add to Subview.
    
    [self.mDamagePopupViewController_.view setBackgroundColor:[UIColor clearColor]];
    
    
    [self.mDamagePopupViewController_ setDamageString:aDamageType];
    [self.mDamagePopupViewController_ setGCPointForDamagePopupView:aCGPoint];*/
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] setXCoordAndYCoord:aCGPoint];
    /*[self.mDamagePopupViewController_.view setFrame:CGRectMake([[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView].frame.origin.x - 5, [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView].frame.origin.y - 5, [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView].contentSize.width, [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView].contentSize.height)];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView] addSubview:self.mDamagePopupViewController_.view];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView] bringSubviewToFront:self.mDamagePopupViewController_.view];*/
    
    {
        [[WalkAroundSupportWebEngine walkAroundSharedInstance] setMVehicleDiagramRequest_:VehicleDiagramPUTRequest];
        BuildInspectionDetailsViewController *lViewController = [[BuildInspectionDetailsViewController alloc] initWithNibName:@"BuildInspectionDetailsViewController" bundle:nil];
        [[[SharedUtilities sharedUtilities] appDelegateInstance] setBuildInspectionDetailsViewController: lViewController];
        
        [[SharedUtilities sharedUtilities] appDelegateInstance].buildInspectionDetailsViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [[SharedUtilities sharedUtilities] appDelegateInstance].buildInspectionDetailsViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        if( [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            [[SharedUtilities sharedUtilities] appDelegateInstance].buildInspectionDetailsViewController.preferredContentSize = CGSizeMake(543, 334);
        }
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_.topViewController presentViewController:[[SharedUtilities sharedUtilities] appDelegateInstance].buildInspectionDetailsViewController animated:YES completion:nil];
        
        [[[SharedUtilities sharedUtilities] appDelegateInstance].buildInspectionDetailsViewController setBuildInspectionDetailsViewForPostRequestDamageID:self.mOnTapPointButton_.mID_ VehicleDamageDetailTypeID:self.mOnTapPointButton_.mVehicleDamageDetailTypeID_ VehicleDamageSeverityID:self.mOnTapPointButton_.mVehicleDamageSeverityID_ Notes:self.mOnTapPointButton_.mNotes_ ImageURL:self.mOnTapPointButton_.mImageURL_];
    }
    
}

/**
 * Method to return string of damage/severity type based on ID;
 * Self [Line 99]
 */
- (NSString *)returnDamageTypeOrSeverityType : (int)aSeverityOrDamageTypeID isSeverity :(BOOL)aBoolValue {
    
    NSString *damageOrSeverityTypeString = @"";
    if (aBoolValue) {
        switch (aSeverityOrDamageTypeID) {
            case 1:
                damageOrSeverityTypeString = @"Severe";
                break;
            case 2:
                damageOrSeverityTypeString = @"Moderate";
                break;
            case 3:
                damageOrSeverityTypeString = @"Mild";
                break;
            default:
                break;
        }
    }else {
        switch (aSeverityOrDamageTypeID) {
            case 1:
                damageOrSeverityTypeString = @"Ding";
                break;
            case 2:
                damageOrSeverityTypeString = @"Dent";
                break;
            case 3:
                damageOrSeverityTypeString = @"Scratch";
                break;
            case 4:
                damageOrSeverityTypeString = @"Chip";
                break;
            case 5:
                damageOrSeverityTypeString = @"Crack";
                break;
            default:
                break;
        }
    }
    return damageOrSeverityTypeString;
}
@end


@implementation CustomButtonOnImageView
@synthesize mSeverityType_;
@synthesize mDamageType_;
@synthesize mID_;
@synthesize mVehicleDamageSeverityID_;
@synthesize mVehicleDamageDetailTypeID_;
@synthesize mNotes_;
@synthesize mImageURL_;
@end;
