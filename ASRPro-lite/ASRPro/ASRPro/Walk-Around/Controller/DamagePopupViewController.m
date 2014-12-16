//
//  DamagePopupViewController.m
//  ASRPro
//
//  Created by GuruMurthy on 14/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "DamagePopupViewController.h"
#import "WalkAroundSupportWebEngine.h"
@interface DamagePopupViewController () {
    AppDelegate *mAppDelegate_;
}
@property (nonatomic, readwrite) NSString *mDamageImageString_;
/**
 * Add Damage Button Instance.
 */
@property (nonatomic, assign) CGPoint mCGPoint_;

- (void) initializationOfObjectsForAddDamageView;
- (void) setFontsAndTextToAddDamageView;
@end

@implementation DamagePopupViewController
@synthesize mCGPoint_;
@synthesize mBuildInspectionDetailsViewController_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark --
#pragma mark View Life Cycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializationOfObjectsForAddDamageView];
    [self setFontsAndTextToAddDamageView];
}

- (void)viewDidLayoutSubviews {
    [self.mDamagePopupButton_ setFrame:CGRectMake(mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.frame.origin.x + mCGPoint_.x  - (self.mDamagePopupButton_.frame.size.width/2) + 13, mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.frame.origin.y + mCGPoint_.y - self.mDamagePopupButton_.frame.size.height, self.mDamagePopupButton_.frame.size.width, self.mDamagePopupButton_.frame.size.height)];
}

#pragma mark --
#pragma mark Memory Management Methods
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --
#pragma mark Public Methods
/**
 * Set CGPoint to Show the Add Damage View at point.
 *@Param CGPoint = aCGPoint.
 */
- (void)setGCPointForDamagePopupView :(CGPoint)aCGPoint {
    self.mCGPoint_ = aCGPoint;
}

- (void)setDamageString :(NSString *)aDamageString_ {
    self.mDamageImageString_ = [NSString stringWithFormat:@"damage_popup_%@",aDamageString_];
    [self setDamageImageForButton];
}

#pragma mark --
#pragma mark Private Methods
- (void) initializationOfObjectsForAddDamageView {
    [self.navigationController setNavigationBarHidden:YES];
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
}

- (void) setFontsAndTextToAddDamageView {

}

- (void)setDamageImageForButton {
    [self.mDamagePopupButton_ setImage:[UIImage imageNamed:self.mDamageImageString_] forState:UIControlStateNormal];
}

#pragma mark --
#pragma mark Button Methods
- (IBAction)damagePopupButtonAction:(id)sender {
    [self.view removeFromSuperview];
     [[WalkAroundSupportWebEngine walkAroundSharedInstance] setMVehicleDiagramRequest_:VehicleDiagramPUTRequest];
    BuildInspectionDetailsViewController *lViewController = [[BuildInspectionDetailsViewController alloc] initWithNibName:@"BuildInspectionDetailsViewController" bundle:nil];
    self.mBuildInspectionDetailsViewController_ = lViewController;
    
    self.mBuildInspectionDetailsViewController_.modalPresentationStyle = UIModalPresentationFormSheet;
    self.mBuildInspectionDetailsViewController_.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [mAppDelegate_.mECSlidingViewController_.topViewController presentViewController:self.mBuildInspectionDetailsViewController_ animated:YES completion:nil];
    
    [self.mBuildInspectionDetailsViewController_ setBuildInspectionDetailsViewForPostRequestDamageID:mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.mOnTapPointButton_.mID_ VehicleDamageDetailTypeID:mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.mOnTapPointButton_.mVehicleDamageDetailTypeID_ VehicleDamageSeverityID:mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.mOnTapPointButton_.mVehicleDamageSeverityID_ Notes:mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.mOnTapPointButton_.mNotes_ ImageURL:mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.mOnTapPointButton_.mImageURL_];
}


#pragma mark --
#pragma mark TouchEvent Methods
- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
    // some custom code to process a specific touch
    // To remove AddDamage view from the Superview.
    [self.view removeFromSuperview];
}
@end
