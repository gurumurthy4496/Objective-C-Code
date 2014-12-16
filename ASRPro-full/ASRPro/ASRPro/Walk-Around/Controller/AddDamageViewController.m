//
//  AddDamageViewController.m
//  ASRPro
//
//  Created by GuruMurthy on 10/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "AddDamageViewController.h"
#import "WalkAroundSupportWebEngine.h"
@interface AddDamageViewController () {
    AppDelegate *mAppDelegate_;
}

/**
 * Add Damage Button Instance.
 */
@property (nonatomic, assign) CGPoint mCGPoint_;

- (void) initializationOfObjectsForAddDamageView;
- (void) setFontsAndTextToAddDamageView;
@end

@implementation AddDamageViewController
@synthesize mBuildInspectionDetailsViewController_;
@synthesize mCGPoint_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark --
#pragma mark ViewLifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializationOfObjectsForAddDamageView];
    [self setFontsAndTextToAddDamageView];
}

- (void)viewDidLayoutSubviews {
    [self.mAddDamageButton_ setFrame:CGRectMake(mCGPoint_.x + mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.frame.origin.x - (self.mAddDamageButton_.frame.size.width/2), mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.frame.origin.y + mCGPoint_.y - self.mAddDamageButton_.frame.size.height, self.mAddDamageButton_.frame.size.width, self.mAddDamageButton_.frame.size.height)];
    
    [self.mDamagePointImageView_ setFrame:CGRectMake(mCGPoint_.x + mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.frame.origin.x - 10, mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.frame.origin.y + mCGPoint_.y , self.mDamagePointImageView_.frame.size.width, self.mDamagePointImageView_.frame.size.height)];
}

#pragma mark --
#pragma mark Memory Management Methods
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --
#pragma mark Orientations Methods
- (BOOL)shouldAutorotate // iOS 6/7 autorotation fix
{
	return YES;
}

- (NSUInteger)supportedInterfaceOrientations // iOS 6/7 autorotation fix
{
    //	return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    return UIInterfaceOrientationMaskAll;
}

#pragma mark --
#pragma mark Button Action Methods
- (IBAction)addDamageButtonAction:(id)sender {
     [self.view removeFromSuperview];
     [[WalkAroundSupportWebEngine walkAroundSharedInstance] setMVehicleDiagramRequest_:VehicleDiagramPOSTRequest];
    BuildInspectionDetailsViewController *lViewCotroller = [[BuildInspectionDetailsViewController alloc] initWithNibName:@"BuildInspectionDetailsViewController" bundle:nil];
    self.mBuildInspectionDetailsViewController_ = lViewCotroller;
    
    self.mBuildInspectionDetailsViewController_.modalPresentationStyle = UIModalPresentationFormSheet;
    self.mBuildInspectionDetailsViewController_.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [mAppDelegate_.mECSlidingViewController_.topViewController presentViewController:self.mBuildInspectionDetailsViewController_ animated:YES completion:nil];
}

#pragma mark --
#pragma mark Public Methods
/**
 * Set CGPoint to Show the Add Damage View at point.
 *@Param CGPoint = aCGPoint.
 */
- (void)setGCPointForAddDamageView :(CGPoint)aCGPoint {
    self.mCGPoint_ = aCGPoint;
}

#pragma mark --
#pragma mark Private Methods
- (void) initializationOfObjectsForAddDamageView {
    [self.navigationController setNavigationBarHidden:YES];
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
}

- (void) setFontsAndTextToAddDamageView {
    [self.mAddDamageButton_ setTitle:NSLocalizedString(@"ADD_DAMAGE_TITLE", nil) forState:UIControlStateNormal];
    [self.mAddDamageButton_ setTitle:NSLocalizedString(@"ADD_DAMAGE_TITLE", nil) forState:UIControlStateSelected];
    [self.mAddDamageButton_ setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 10, 0)];
    [self.mAddDamageButton_ setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
    [self.mAddDamageButton_ setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateSelected];
}

- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
    // some custom code to process a specific touch
    // To remove AddDamage view from the Superview.
    [self.view removeFromSuperview];
}
@end
