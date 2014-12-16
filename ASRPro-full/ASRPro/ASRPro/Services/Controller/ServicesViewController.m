//
//  ServicesViewController.m
//  ASRPro
//
//  Created by GuruMurthy on 30/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ServicesViewController.h"
#define DateFormatApp @"MM/dd/yyyy  hh:mm a"
#define TimeFormatApp @"HH:mm"


@interface ServicesViewController () {
    AppDelegate *mAppDelegate_;
}
- (void)initializationOfObjectsForSearchScreenView;
- (void)setFontsAndTextToSearchScreenView;

@end

@implementation ServicesViewController
@synthesize mServicesScheduleTableViewController_;
@synthesize mRecommendedServicesTableViewController_;
@synthesize mAddServicesViewController_;
@synthesize lTempArray;
@synthesize mServicesPackageTableViewController_;
@synthesize mServicePackageView_;
@synthesize mSearchBar_;
@synthesize mUpdateDateLabel_;
@synthesize mRefreshButton_;

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
    [self.view customHeaderViewFull:self SelectedButton:@"Services"];
    [self initializationOfObjectsForSearchScreenView];
    [self setFontsAndTextToSearchScreenView];
    [self updateDateAndTime];
    [self calculateAllTotals];
    [self setLandScapeOrientationView];
    [self showSearchBar];
    [self.mServicePackageView_.layer setBorderWidth:2.0];
    [self.mServicePackageView_.layer setBorderColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0].CGColor];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [mAppDelegate_.mModelForNotifications_ checkTheNotifiationBadgeCount:self.view];
    // ----------------------------;
    // ADD LeftView to ECS_Sliding -> WalkAroundLeftSlider;
    // ----------------------------;
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

- (void)updateDateAndTime {
    
    NSDate* date=[NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    // [self setMFormatter_:formatter];
    [formatter setDateFormat:DateFormatApp];
    NSString *lDateStr=[formatter stringFromDate:date];
    mUpdateDateLabel_.text=(lDateStr)?[NSString stringWithFormat:@"Last updated  %@",lDateStr]:[NSString stringWithFormat:@"Last updated  %@",@""];
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
#pragma mark Private Methods
- (void)initializationOfObjectsForSearchScreenView {
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)setFontsAndTextToSearchScreenView {
    
}

-(void)calculateAllTotals{

    //  mAppDelegate_.mServiceDataGetter_.mShopCharges= [mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ valueForKey:@"ShopCharges"];
    //    mAppDelegate_.mServiceDataGetter_.mTax= [mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ valueForKey:@"Tax"];
    //    float total=0;
    //    total=[mAppDelegate_.mServiceDataGetter_.mServicesScheduledTotal floatValue]+[mAppDelegate_.mServiceDataGetter_.mRecommendedServicesTotal floatValue]+[mAppDelegate_.mServiceDataGetter_.mShopCharges floatValue]+[mAppDelegate_.mServiceDataGetter_.mTax floatValue];
    //    mAppDelegate_.mServiceDataGetter_.mFinalServicesTotall=[NSString stringWithFormat:@"%.2f",total];

//  mAppDelegate_.mServiceDataGetter_.mShopCharges= [mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ valueForKey:@"ShopCharges"];
//    mAppDelegate_.mServiceDataGetter_.mTax= [mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ valueForKey:@"Tax"];
//    float total=0;
//    total=[mAppDelegate_.mServiceDataGetter_.mServicesScheduledTotal floatValue]+[mAppDelegate_.mServiceDataGetter_.mRecommendedServicesTotal floatValue]+[mAppDelegate_.mServiceDataGetter_.mShopCharges floatValue]+[mAppDelegate_.mServiceDataGetter_.mTax floatValue];
//    mAppDelegate_.mServiceDataGetter_.mFinalServicesTotall=[NSString stringWithFormat:@"%.2f",total];

}

-(void)setLandScapeOrientationView{
    NSMutableArray * lServicesArray=[[FileUtils fileUtils] loadArrayFromFile:kALLSERVICESPACKAGE];
    mAppDelegate_.mServiceDataGetter_.mAllServicesArray_=[[FileUtils fileUtils] loadArrayFromFile:kALLSERVICESPATH];
    if(lServicesArray==nil)
    {
        mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_=SERVICEPACKAGEVIEWCONTROLLER;
        [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForServiceLines];
    }
    else{
        [mAppDelegate_.mServiceDataGetter_ setMServicePackagesArray_:lServicesArray];
        [mAppDelegate_.mServiceDataGetter_ setMTempServicePackagesArray_:lServicesArray];

        
    }
    
    // Do any additional setup after loading the view from its nib.
    self.mServicesPackageTableViewController_=[[ServicesPackageTableViewController alloc] init];
    [self.mServicesPackageTableViewController_.view setFrame:CGRectMake(0, 35, 300, 608)];
    [self.mServicePackageView_ addSubview:mServicesPackageTableViewController_.view];
    //self.mServicesScheduleTableViewController_=[[ServicesScheduleTableViewController alloc] initWithNibName:@"ServicesScheduleTableViewController" bundle:nil];
   // [mServicesScheduleTableViewController_.view setFrame:CGRectMake(324, 90, 690, 250)];
    mRecommendedServicesTableViewController_=[[RecommendedServicesTableViewController alloc] initWithNibName:@"RecommendedServicesTableViewController" bundle:nil];
    [mRecommendedServicesTableViewController_.view setFrame:CGRectMake(324, 90, 690, 600)];
   //[self.view addSubview:mServicesScheduleTableViewController_.view];
    [self.view addSubview:mRecommendedServicesTableViewController_.view];
    [mRecommendedServicesTableViewController_.tableView reloadData];
    [mServicesScheduleTableViewController_.tableView reloadData];
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]
                                          initWithTarget:self.mServicesPackageTableViewController_ action:@selector(handlePanning:)];
    [recognizer setDelegate:self.mServicesPackageTableViewController_];
    [mServicePackageView_ addGestureRecognizer:recognizer];

    

}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    int height=self.mRecommendedServicesTableViewController_.tableView.contentSize.height;
    int maxheight=600;
    if(height>maxheight)
        height=maxheight;
    CGRect frame = self.mRecommendedServicesTableViewController_.tableView.frame;
    frame.size.height = height;
    self.mRecommendedServicesTableViewController_.tableView.frame = frame;
   }


- (void)showSearchBar {
    UISearchBar *lSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    CGRect frame = lSearchBar.frame;
    lSearchBar.tag = 3;
    [lSearchBar CustomSearchBar:frame];
    self.mSearchBar_ = lSearchBar;
    // Get the instance of the UITextField of the search bar
    UITextField *searchField = [self.mSearchBar_ valueForKey:@"_searchField"];
    // Change the search bar placeholder text color
    [searchField setValue:[UIColor ASRProBlueColor] forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:[UIFont systemFontOfSize:15.0] forKeyPath:@"_placeholderLabel.font"];
    [self.mServicePackageView_ addSubview:self.mSearchBar_];
}

- (IBAction)RefreshBtnClicked:(id)sender {
    [self updateDateAndTime];
    
    mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_=SERVICEPACKAGEVIEWCONTROLLER;
    [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForServiceLines];
    
}

- (IBAction)getPartsAndLabour:(id)sender {
    [mAppDelegate_.mModelForPartsSupportEngine_ setMGetPartsReference_:INPROCESSOPARTSVIEWCONTROLLER];
    [mAppDelegate_.mModelForPartsSupportEngine_ requestToGetParts:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_];
}
- (void) initPopUpView {
    PartsLabourMainViewController *lPartsLabourMainViewController = [[PartsLabourMainViewController alloc] initWithNibName:@"PartsLabourMainViewController" bundle:nil];
    mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mLocationArray_=[[FileUtils fileUtils] loadArrayFromFile:kPARTSLOCATIONSPATH];
    [mAppDelegate_.mPartLabourDataGetter_ setMRONumber_:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_];
    [mAppDelegate_.mPartLabourDataGetter_ setMPartsLabourMainViewController_:lPartsLabourMainViewController];
    [mAppDelegate_.mPartLabourDataGetter_ setMAddedPartsArray_:[mAppDelegate_.mServiceDataGetter_.mSelectedServicesArray_  mutableCopy]];
    //    mAppDelegate_.mPartLabourDataGetter_.mPartsLabourMainViewController_.view.frame = CGRectMake (0, 0, 1024, 768);
    [self.view addSubview:mAppDelegate_.mPartLabourDataGetter_.mPartsLabourMainViewController_.view];
    [mAppDelegate_.mPartLabourDataGetter_.mPartsLabourMainViewController_ initTheViews];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [mAppDelegate_.mPartLabourDataGetter_.mPartsLabourMainViewController_.view setFrame:CGRectMake(0, -768, 1024, 768)];
    [mAppDelegate_.mPartLabourDataGetter_.mPartsLabourMainViewController_.view setFrame:CGRectMake(0, 0, 1024, 768)];
    [UIView commitAnimations];
    
}




- (IBAction)CustomerPlanClicked:(id)sender {
    [mAppDelegate_.mModelforOpenROSupportEngine_ setMGetServiceReference_:SERVICESVIEWCONTROLLER];
    [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForCustomerPlanPDF:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_];
}

-(void)showAddServicePopup{
    //   if(mAppDelegate_.mServiceDataGetter_.mAllServicesArray_==nil)
    mAppDelegate_.mServiceDataGetter_.mPayTypesArray_=[[FileUtils fileUtils] loadArrayFromFile:kPAYTYPESPATH];
    if(mAppDelegate_.mServiceDataGetter_.mPayTypesArray_==nil){
        [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForGetPayTypes];
    }
    
    mAppDelegate_.mServiceDataGetter_.mAllServicesArray_ =[[FileUtils fileUtils] loadArrayFromFile:kALLSERVICESPATH] ;
    if(mAppDelegate_.mServiceDataGetter_.mAllServicesArray_==nil)
    {
        mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_=SERVICESVIEWCONTROLLER;
        [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForServiceLines];
    }
    else{
        
        [self pushToServicesList];
    }
}

-(void)pushToServicesList{
    AddServicesViewController *lAddServicesViewController = [[AddServicesViewController alloc] initWithNibName:@"AddServicesViewController" bundle:nil];
    [mAppDelegate_.mServiceDataGetter_ setMAddServicesViewController_:lAddServicesViewController];
    [mAppDelegate_.mServiceDataGetter_.mAddServicesViewController_ setMGetServiceReference_:SERVICESVIEWCONTROLLER];
    
    lAddServicesViewController.modalPresentationStyle=UIModalPresentationFormSheet;
    lAddServicesViewController.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    [self presentViewController:lAddServicesViewController animated:YES completion:nil];
    [mAppDelegate_.mServiceDataGetter_.mAddServicesViewController_.mSaveButton_ setEnabled:TRUE];
    
    
}

-(void)pushToPDFView{
    ServicesPdfView *lServicesPdfView = [[ServicesPdfView alloc] initWithNibName:@"ServicesPdfView" bundle:nil];
    [lServicesPdfView setMTitle:@"Customer Plan"];
    [lServicesPdfView setMWebURl:mAppDelegate_.mOpenRoServiceDataGetter_.mPdfURL];
    lServicesPdfView.modalPresentationStyle=UIModalPresentationFormSheet;
    lServicesPdfView.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    [self presentViewController:lServicesPdfView animated:YES completion:nil];
    [[SharedUtilities sharedUtilities] removeLoadView];
}



@end
