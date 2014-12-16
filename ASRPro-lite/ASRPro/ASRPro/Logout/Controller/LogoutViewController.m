//
//  LogoutViewController.m
//  ASRPro
//
//  Created by GuruMurthy on 31/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "LogoutViewController.h"

@interface LogoutViewController () {
    AppDelegate *mAppDelegate_;
}

@end

@implementation LogoutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    // Do any additional setup after loading the view from its nib.
    UIImage *lLoginUserDetailsImage = [UIImage imageNamed:@"logout"];
    [self.mLogoutButton_ setFrame:CGRectMake(840, 63+7 , lLoginUserDetailsImage.size.width, lLoginUserDetailsImage.size.height-10)];
    [self.mLogoutButton_.layer setBorderWidth:1];
    [self.mLogoutButton_.layer setBorderColor:[[UIColor ASRProLoginBackgroundColor] CGColor]];
    [self.mLogoutButton_ setTitle:@"Log out" forState:UIControlStateNormal];
    [self.mLogoutButton_ setTitle:@"Log out" forState:UIControlStateSelected];
}

- (void)viewWillAppear:(BOOL)animated {

}

- (void)viewDidLayoutSubviews {
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutButtonAction:(id)sender {
    
    [mAppDelegate_.mModelForNotifications_ saveDataForNotifications];
    if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Advisor"]) {
        mAppDelegate_.mModelForNotifications_.mAdvisorNotificationCount_ = [mAppDelegate_ mModelForNotifications_].mNotificationsCount_;
        DLog(@"%d",mAppDelegate_.mModelForNotifications_.mAdvisorNotificationCount_);
    }else if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Technician"]){
        mAppDelegate_.mModelForNotifications_.mTechnicianNotificationCount_ = [mAppDelegate_ mModelForNotifications_].mNotificationsCount_;
        DLog(@"%d",mAppDelegate_.mModelForNotifications_.mTechnicianNotificationCount_);
    }else {
        mAppDelegate_.mModelForNotifications_.mManagerNotificationCount_ = [mAppDelegate_ mModelForNotifications_].mNotificationsCount_;
        DLog(@"%d",mAppDelegate_.mModelForNotifications_.mManagerNotificationCount_);
    }
    
    [self removeTheCacheData];

    [self removeLogoutView];
    
    mAppDelegate_.mSplashScreenViewController_.view.frame = [[UIScreen mainScreen] applicationFrame];
        
    [mAppDelegate_.window setRootViewController:[mAppDelegate_ mSplashScreenViewController_]];
    //  [[mAppDelegate_ window]addSubview:[[mAppDelegate_ mSplashScreenViewController_iPad_]view]];
    [mAppDelegate_ showLogin:mAppDelegate_.mSplashScreenViewController_.mSplashScreenImageView_];
}

- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event
{
    // some custom code to process a specific touch
    // To remove LogoutView from the Superview.
    UIView *lView = self.view.superview;
    __block UIButton *lButton;
    [lView.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop){
        UIView *lTempView1 = object;
        if (lTempView1.tag == 1) {
            [lTempView1.subviews enumerateObjectsUsingBlock:^(id object1 , NSUInteger index1, BOOL *stop1) {
                UIView *lTempView = object1;
               
                if (lTempView.tag == 5) {
                    lButton = (UIButton *)lTempView;
                }
            }];
        }
    }];
    [mAppDelegate_.mChangeUsernameAndAcronymTextColor_ changeTheTextForUsernameAndAcronymLabel:lButton];
     [self.view removeFromSuperview];
}


#pragma mark --
#pragma mark Private Methods

- (void)removeTheCacheData {
    [[SharedUtilities sharedUtilities] saveDictionaryInToFile:nil :kEmployeesData];
    [[SharedUtilities sharedUtilities] writeObjectToUserDefaults:nil forKey:kUserDefaults_TokenAndUserID_Key];
    [[SharedUtilities sharedUtilities] writeObjectToUserDefaults:nil forKey:kStore_Username_Role_In_Files];
    
    [[SharedUtilities sharedUtilities] saveDictionaryInToFile:nil :kStore_VehicleDiagrams_sets_Array];
    [[FileUtils fileUtils] deleteAllFilesFromPath:kINSPECTIONFORMSFOLDERPATH];
    [[FileUtils fileUtils] deleteFileFromPath:kALLSERVICESPATH];
    [[FileUtils fileUtils] deleteFileFromPath:KLOCATIONVALUES];
    [[FileUtils fileUtils] deleteFileFromPath:kINSPECTIONFORMSLISTPATH];
    [mAppDelegate_.mOpenRoServiceDataGetter_.mScheduledServicesArray_ removeAllObjects];
    [mAppDelegate_.mOpenRoServiceDataGetter_.mSelectedServicesArray_ removeAllObjects];
    
    [mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ removeAllObjects];
    mAppDelegate_.mSearchViewController_ =nil;


}

-(void)removeLogoutView
{
    UIView *lView = self.view.superview;
    [lView.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop){
        UIView *lTempView1 = object;
        if (lTempView1.tag == 1) {
            [lTempView1.subviews enumerateObjectsUsingBlock:^(id object1 , NSUInteger index1, BOOL *stop1) {
                UIView *lTempView = object1;
                UIButton *lButton;
                UILabel *lUsername;
                UILabel *lAcronym;
                if (lTempView.tag == 5) {
                    lButton = (UIButton *)lTempView;
                    lButton.selected = !lButton.selected;
                }else if (lTempView.tag == 6) {
                    lUsername = (UILabel *)lTempView;
                    [lUsername setTextColor:[UIColor ASRProBlueColor]];
                }else if (lTempView.tag == 7) {
                    lAcronym = (UILabel *)lTempView;
                    [lAcronym setTextColor:[UIColor ASRProBlueColor]];
                }
            }];
        }
    }];
    // To remove LogoutView from the Superview.
    [self.view removeFromSuperview];
}

@end
