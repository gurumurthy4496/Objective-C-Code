//
//  WalkAroundViewController.m
//  ASRPro
//
//  Created by GuruMurthy on 29/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "WalkAroundViewController.h"
#import "ServicesNavigationController.h"
#import "CustomImageView.h"

@interface WalkAroundViewController () {
    AppDelegate *mAppDelegate_;
}
- (void)initializationOfObjectsForWalkAroundView;
- (void)setFontsAndTextToSearchScreenView;
@end

@implementation WalkAroundViewController
@synthesize mWalkAroundLaneInspectionView;
@synthesize mVehicleAngleDropDownView_;
@synthesize mVehicleTypesDropDownView_;
@synthesize mChangeVehicleImageAndNameColor_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark --
#pragma mark View Lifecycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view customHeaderViewFull:self SelectedButton:@"Walk-Around"];
    [self initializationOfObjectsForWalkAroundView];
    [self setFontsAndTextToSearchScreenView];
    [self.mVehicleDiagramsImageView_ setBorderForImageView];
    [self.mVehicleDiagramSetsTableView_ setBorderForTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setMChangeVehicleImageAndNameColor_:self];
    DLog(@"topViewController :-%@",mAppDelegate_.mECSlidingViewController_.topViewController);
    if (mAppDelegate_.mModelForWalkAround_.mShowVehicleHistoryPopUp_ == ShowVehicleHistoryPopUpFromAppointments) {
        [mAppDelegate_.mModelForVehicleHistoryTableView_ presentVehicleHistoryViewController:nil];
        [mAppDelegate_.mVehicleHistoryViewController_ setAcceptButtonHiddenForVehicleCheckIn];
        [[mAppDelegate_ mVehicleHistoryViewController_] initDataInTableView];
        [mAppDelegate_.mVehicleHistoryViewController_.mTableView_ reloadData];
    }
    [self.view addGestureRecognizer:mAppDelegate_.mECSlidingViewController_.panGesture];
    [mAppDelegate_.mECSlidingViewController_ setAnchorRightRevealAmount:340.0f];
    if (mAppDelegate_.mWalkAroundLeftViewController_ == nil) {
        WalkAroundLeftViewController *lViewControler = [[WalkAroundLeftViewController alloc] init];
        [mAppDelegate_ setMWalkAroundLeftViewController_:lViewControler];
        [mAppDelegate_.mWalkAroundLeftViewController_.view setBackgroundColor:[UIColor ASRProRGBColor:66 Green:66 Blue:68]];
        
    }
    if (![mAppDelegate_.mECSlidingViewController_.underLeftViewController isKindOfClass:[WalkAroundLeftViewController class]]) {
        mAppDelegate_.mECSlidingViewController_.underLeftViewController  = mAppDelegate_.mWalkAroundLeftViewController_;
    }
}

- (void)viewDidLayoutSubviews  {

}

#pragma mark -
#pragma mark Memory Management Methods
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Orientations Methods
/*- (BOOL)shouldAutorotate // iOS 6/7 autorotation fix
{
	return YES;
}

- (NSUInteger)supportedInterfaceOrientations // iOS 6/7 autorotation fix
{
    //	return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    return UIInterfaceOrientationMaskAll;
}*/

#pragma mark --
#pragma mark Private Methods
- (void)initializationOfObjectsForWalkAroundView {
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    [self.mWalkAroundLaneInspectionView initTheViews];
    
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)setFontsAndTextToSearchScreenView {
    [self.mVehicleTypeButton_ setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
    [self.mVehicleTypeButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//    [self.mVehicleTypeButton_ setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 550)];

    
    [self.mVehicleAngleButton_ setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
    [self.mVehicleAngleButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
}

-(void)pushToServicesList {
    mAppDelegate_.mServiceDataGetter_.mAllServicesArray_=[mWalkAroundLaneInspectionView getServiceLines];
    AddServicesViewController *lAddServicesViewController = [[AddServicesViewController alloc] initWithNibName:@"AddServicesViewController" bundle:nil];
 [mAppDelegate_.mServiceDataGetter_ setMAddServicesViewController_:lAddServicesViewController];
    [mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_ resetAllValues];
    [mAppDelegate_.mServiceDataGetter_.mAddServicesViewController_ setMGetServiceReference_:WALKAROUNDCONTROLLER];
    lAddServicesViewController.modalPresentationStyle=UIModalPresentationFormSheet;
    lAddServicesViewController.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    [self presentViewController:lAddServicesViewController animated:YES completion:nil];
    
}

#pragma mark --
#pragma mark VehicleTypes Button Methods
- (IBAction)vehicletypeButtonAction:(id)sender {
//    [self.mVehicleTypeButton_ setSelected:YES];
    self.mVehicleTypeButton_.selected = !self.mVehicleTypeButton_.selected;
    
    [self.mChangeVehicleImageAndNameColor_ methodToChangeVehicleImageAndNameColor:sender];
    if(self.mVehicleAngleDropDownView_ != nil) {
        [self.mVehicleAngleDropDownView_ hideVehicleAngleDropDown:self.mVehicleAngleButton_];
        [self vehicleAngleDropDownNil];
    }
    
    if(self.mVehicleTypesDropDownView_ == nil) {
        CGFloat heightForTableView = [mAppDelegate_.mModelForWalkAround_.mCategoryListArray_ count] * 40;
        if (heightForTableView > self.view.frame.size.height - 90) {
            heightForTableView = self.view.frame.size.height - 290;
        }
        self.mVehicleTypesDropDownView_ = [[VehicleTypesDropDownView alloc] showVehicleTypesDropDown:sender Height:&heightForTableView Array:mAppDelegate_.mModelForWalkAround_.mCategoryListArray_ ImageArray:nil Direction:@"down"];
        self.mVehicleTypesDropDownView_.delegate = self;
//        [self.mVehicleTypesDropDownView_ setUserInteractionEnabled:FALSE];
    }
    else {
        [self.mVehicleTypesDropDownView_ hideVehicleTypesDropDown:sender];
        [self vehicleTypesDropDownNil];
    }
    
}

- (IBAction)vehicleangleButtonAction:(id)sender {
    
    self.mVehicleAngleButton_.selected = !self.mVehicleAngleButton_.selected;
    if(self.mVehicleTypesDropDownView_ != nil) {
        [self.mVehicleTypesDropDownView_ hideVehicleTypesDropDown:self.mVehicleTypeButton_];
        [self vehicleTypesDropDownNil];
    }
    if(self.mVehicleAngleDropDownView_ == nil) {
        CGFloat heightForTableView = 5 * 40;
        self.mVehicleAngleDropDownView_ = [[VehicleAngleDropDownView alloc] showVehicleAngleDropDown:sender Height:&heightForTableView Array:mAppDelegate_.mModelForWalkAround_.mCategoryListArray_ Direction:@"down"];
        self.mVehicleAngleDropDownView_.delegate = self;
//        [self.mVehicleAngleDropDownView_ setUserInteractionEnabled:FALSE];
    }
    else {
        [self.mVehicleAngleDropDownView_ hideVehicleAngleDropDown:sender];
        [self vehicleAngleDropDownNil];
    }
    
}

#pragma mark --
#pragma mark VehicleTypes DropDown Methods
- (void)vehicleTypesDropDownViewDelegateMethod:(OpenRODropDownView *)sender{
    [self vehicleTypesDropDownNil];
}

- (void)vehicleAngleDropDownViewDelegateMethod:(OpenRODropDownView *)sender{
    [self vehicleAngleDropDownNil];
}

-(void)vehicleTypesDropDownNil {
    self.mVehicleTypesDropDownView_  = nil;
    [self.mVehicleTypesDropDownView_ setUserInteractionEnabled:TRUE];
}

-(void)vehicleAngleDropDownNil {
    self.mVehicleAngleDropDownView_  = nil;
    [self.mVehicleAngleDropDownView_ setUserInteractionEnabled:TRUE];
}

#pragma mark --
#pragma mark TouchEvent
- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
    // some custom code to process a specific touch
    [self.mVehicleTypeButton_ setSelected:NO];
    [self.mChangeVehicleImageAndNameColor_ methodToChangeVehicleImageAndNameColor:self.mVehicleTypeButton_];
    if(self.mVehicleAngleDropDownView_ != nil) {
        [self.mVehicleAngleDropDownView_ hideVehicleAngleDropDown:self.mVehicleAngleButton_];
        [self vehicleAngleDropDownNil];
    }
    if(self.mVehicleTypesDropDownView_ != nil) {
        [self.mVehicleTypesDropDownView_ hideVehicleTypesDropDown:self.mVehicleTypeButton_];
        [self vehicleTypesDropDownNil];
    }
    
    /*[self.mVehicleTypesDropDownView_ hideVehicleTypesDropDown:self.mVehicleTypeButton_];
    [self vehicleTypesDropDownNil];
    
    [self.mVehicleAngleDropDownView_ hideVehicleAngleDropDown:self.mVehicleAngleButton_];
    [self vehicleAngleDropDownNil];*/
    
}

#pragma mark --
#pragma mark Protocol Methods
- (void)methodToChangeVehicleImageAndNameColor:(id)aButton {
    UIButton *button = (UIButton *)aButton;
    if (button.selected) {
        [button.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            NSLog(@"Object %@",object);
            CustomImageView *imageview = (CustomImageView *)object;
            UILabel *label = (UILabel *)object;
            if ([object isKindOfClass:[CustomImageView class]] || [object isKindOfClass:[UILabel class]]) {
                if (imageview.tag == 1001) {
                    
                    NSString *imageString = [imageview.mImageName_ stringByReplacingOccurrencesOfString:@" " withString:@""];
                    imageString = [imageview.mImageName_ stringByReplacingOccurrencesOfString:@"_blue" withString:@""];
                    [imageview setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageString]]];
                }else if (label.tag == 1002) {
                    [label setTextColor:[UIColor whiteColor]];
                }
            }
        }];
    }else {
        [button.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            CustomImageView *imageview = (CustomImageView *)object;
            UILabel *label = (UILabel *)object;
            if ([object isKindOfClass:[CustomImageView class]] || [object isKindOfClass:[UILabel class]]) {
                if (imageview.tag == 1001) {
                    NSString *imageString = [imageview.mImageName_ stringByReplacingOccurrencesOfString:@" " withString:@""];
                    imageString = [NSString stringWithFormat:@"%@_blue",imageview.mImageName_];
                    [imageview setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageString]]];
                }else if (label.tag == 1002) {
                    [label setTextColor:[UIColor ASRProBlueColor]];
                }
            }
        }];
    }
}

@end
