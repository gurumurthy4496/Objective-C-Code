//
//  VehicleHistoryViewController.m
//  ASRPro
//
//  Created by GuruMurthy on 24/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "VehicleHistoryViewController.h"
#import "VehicleHistorySupportWebEngine.h"

#define kVehicleHistoryTableViewRowHeight 45
@interface VehicleHistoryViewController () {
    AppDelegate *mAppDelegate_;
    int declinedLinesCount_;
    int approvedLinesCount_;
}

@end

@implementation VehicleHistoryViewController

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
    // Do any additional setup after loading the view from its nib.
    [self initializationOfObjectsForVehicleHistoryView];
    declinedLinesCount_ = 1;
    approvedLinesCount_ = 1;
    if (IOS_NEWER_OR_EQUAL_TO_7) {
        if ([self.mTableView_ respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.mTableView_ setSeparatorInset:UIEdgeInsetsZero];
        }
    }
}

#pragma mark --
#pragma mark Private Methods
- (void)initializationOfObjectsForVehicleHistoryView {
    [self.navigationController setNavigationBarHidden:YES];
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    [self.mCancelButton_ setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.mCancelButton_ setTitle:@"Cancel" forState:UIControlStateSelected];
    [self.mCancelButton_ setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
    [self.mCancelButton_ setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateSelected];
    [self.mCancelButton_.titleLabel setFont:[UIFont regularFontOfSize:17 fontKey:kFontNameOpenSansKey]];
    [self.mAcceptButton_ setTitle:@"Accept" forState:UIControlStateNormal];
    [self.mAcceptButton_ setTitle:@"Accept" forState:UIControlStateSelected];
    [self.mAcceptButton_ setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
    [self.mAcceptButton_ setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateSelected];
    [self.mAcceptButton_.titleLabel setFont:[UIFont regularFontOfSize:17 fontKey:kFontNameOpenSansKey]];
    [self.mLabel_ setText:@"Vehicle History"];
    [self.mLabel_ setFont:[UIFont regularFontOfSize:17 fontKey:kFontNameHelveticaNeueKey]];
    [self.mLabel_ setTextColor:[UIColor blackColor]];
}


- (void)setFontsAndTextToSearchScreenView {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.mAcceptButton_ setHidden:NO];
}

// GeneralSettingsViewController
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.view.superview.bounds = CGRectMake(0, 0, 580, 520);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ----------------------------;
// Method to open Default One Section For VehicleHistory TableView;
// ----------------------------;

- (void)openDefaultOneSectionForVehicleHistoryTableView {
    
    VehicleHistorySectionInfo *lTempVehicleHistorySectionInfo = [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mVehicleHistorySectionInfoArray_ objectAtIndex:0];
    if (!lTempVehicleHistorySectionInfo.sectionView)
    {
        NSString *roNumber = NSLocalizedString(@"lNoVehicleHistoryFound", @"lNoVehicleHistoryFound");
        
        if (![lTempVehicleHistorySectionInfo.category.mRONumber isEqualToString:NSLocalizedString(@"lNoVehicleHistoryFound", @"lNoVehicleHistoryFound")]) {
            roNumber = [NSString stringWithFormat:@"RO %@",lTempVehicleHistorySectionInfo.category.mRONumber];
        }
        
        NSString *currentDate = lTempVehicleHistorySectionInfo.category.mCreateDate;
        
        lTempVehicleHistorySectionInfo.sectionView = [[VehicleHistorySectionView alloc] initWithFrame:CGRectMake(0, 0, self.mTableView_.bounds.size.width, 35) WithRONumber:roNumber CreateDate:currentDate Section:0 currentMode:lTempVehicleHistorySectionInfo.category.mCurrentMode delegate:self];
        
        [lTempVehicleHistorySectionInfo.sectionView.discButton setSelected:YES];
        
        [self sectionOpened:0];
    }
    
}

#pragma mark --
#pragma mark Public Methods
// ----------------------------;
// This method is called after succes response for Vehicle History Request;
// ----------------------------;

- (void)initDataInTableView {
    
    // Set the Category array;
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_ setVehicleHistoryCategoryArray];
    
    // Set the Section Array;
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_ setVehicleHistorysectionInfoArray];
    
    // Allocation for RO Search data array;
    [self.mTableView_ reloadData];
    
    // Default open first section for tableview;
    [self openDefaultOneSectionForVehicleHistoryTableView];
    
    // Hiding empty seperatores in ROModes List TableView;
    
    [[SharedUtilities sharedUtilities] hideEmptySeparators:self.mTableView_];
    
}

- (void)setAcceptButtonHiddenForVehicleCheckIn {
    [self.mCancelButton_ setHidden:YES];
}

#pragma mark --
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mVehicleHistoryCategoryList_ count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    declinedLinesCount_ = 1;
    approvedLinesCount_ = 1;
    VehicleHistorySectionInfo *array = [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mVehicleHistorySectionInfoArray_ objectAtIndex:section];
    NSInteger rows = [array.category.mROServiceLinesListArray count];
    return (array.open) ? rows : 0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return kVehicleHistoryTableViewRowHeight;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    VehicleHistorySectionInfo *array  = [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mVehicleHistorySectionInfoArray_ objectAtIndex:section];
    
    if (!array.sectionView) {
        NSString *roNumber = NSLocalizedString(@"lNoVehicleHistoryFound", @"lNoVehicleHistoryFound");
        NSString *currentDate = array.category.mCreateDate;
        if (![array.category.mRONumber isEqualToString:NSLocalizedString(@"lNoVehicleHistoryFound", @"lNoVehicleHistoryFound")]) {
            roNumber = [NSString stringWithFormat:@"RO %@",array.category.mRONumber];
        }
        array.sectionView = [[VehicleHistorySectionView alloc] initWithFrame:CGRectMake(0, 0, self.mTableView_.bounds.size.width, 35) WithRONumber:roNumber CreateDate:currentDate Section:section currentMode:array.category.mCurrentMode delegate:self];
    }
    return array.sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //Configure cell format for the tableView,
        //Same format for all the three sections.
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.alpha = 0.30;
        
        int tagCount = 1;
        for (; tagCount <= 2; tagCount++) {
            UILabel *lUILabel=[[UILabel alloc]init];
            [lUILabel setBackgroundColor:[UIColor clearColor]];
            [lUILabel setFont:[UIFont regularFontOfSize:14.0f fontKey:kFontNameHelveticaNeueKey]];
            [cell.contentView addSubview:lUILabel];
            [lUILabel setTag:tagCount];
            RELEASE_NIL(lUILabel);
        }
        CustomButtonForAddServices *button = [CustomButtonForAddServices buttonWithType:UIButtonTypeCustom];
        [button setTag:3];
        [button setHidden:YES];
        [button.titleLabel setFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [cell.contentView addSubview:button];
        
        UIView *lSelectedView_ = [[UIView alloc] init];
        lSelectedView_.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = lSelectedView_;
        
    }
    [self resetTableViews:cell];
    [self populateFormsSectionWithIndexPath:indexPath cell:cell tableView:tableView];
    
    return cell;
}

#pragma mark --
#pragma mark Table Sections Populate methods

- (void)resetTableViews:(UITableViewCell*)tableViewCell { // made minor chagnes by Ram
    int tagCount = 1;
	// reset UILabels;
	for (; tagCount <= 2; tagCount ++) {
        UILabel *lUILabel = (UILabel*)[tableViewCell viewWithTag:tagCount];
        lUILabel.text = nil;
	}
    CustomButtonForAddServices *button = (CustomButtonForAddServices *)[tableViewCell viewWithTag:3];
    [button setTitle:@"" forState:UIControlStateNormal];
}

- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView  {
    
    //----- local coordinates for setting frames of the internal UI Elements -----
    
    VehicleHistoryCategory *category = (VehicleHistoryCategory *)[[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForVehicleHistoryTableView_.mVehicleHistoryCategoryList_ objectAtIndex:indexPath.section];
    
    CGFloat xCoord = 10, yCoord = 0, width = 200, height = 45;
    
    // ----------------------------;
    // To display RO# and CurrentDate for labels;
    // ----------------------------;
    
    UILabel *lServiceNameLabel = (UILabel*)[tableViewCell.contentView viewWithTag:1];
    [lServiceNameLabel setFrame:CGRectMake(xCoord, yCoord, width, height)];
    [lServiceNameLabel setNumberOfLines:2];
    [lServiceNameLabel setLineBreakMode:NSLineBreakByCharWrapping];
    
    if ([[[category.mROServiceLinesListArray objectAtIndex:indexPath.row] objectForKey:@"Declined"] boolValue] == TRUE) {
        [lServiceNameLabel setText:[NSString stringWithFormat:@"Declined Line %d: %@ - %@",declinedLinesCount_,[[[category.mROServiceLinesListArray objectAtIndex:indexPath.row] objectForKey:@"PayTypeCode"] objectForKey:@"Code"],[[category.mROServiceLinesListArray objectAtIndex:indexPath.row] objectForKey:@"ServiceName"]]];
        [lServiceNameLabel setTextColor:[UIColor redColor]];
        [lServiceNameLabel setHighlightedTextColor:[UIColor redColor]];
        declinedLinesCount_++;
    }else {
          [lServiceNameLabel setText:[NSString stringWithFormat:@"Primary Line %d: %@ - %@",approvedLinesCount_,[[[category.mROServiceLinesListArray objectAtIndex:indexPath.row] objectForKey:@"PayTypeCode"] objectForKey:@"Code"],[[category.mROServiceLinesListArray objectAtIndex:indexPath.row] objectForKey:@"ServiceName"]]];
        [lServiceNameLabel setTextColor:[UIColor blackColor]];
        [lServiceNameLabel setHighlightedTextColor:[UIColor blackColor]];
        approvedLinesCount_++;
    }
   
    
    CGFloat lPriceLaborPartsTotal = [[[category.mROServiceLinesListArray objectAtIndex:indexPath.row] objectForKey:@"Price"] integerValue];
    NSString *lTotal = [NSString stringWithFormat:@"%2f",lPriceLaborPartsTotal];
    
    CGSize lTextWidth = [lTotal sizeWithFont:[UIFont regularFontOfSize:14.0f fontKey:kFontNameHelveticaNeueKey]];
    
    UILabel *lPriceLaborPartsTotalLabel = (UILabel*)[tableViewCell.contentView viewWithTag:2];
    [lPriceLaborPartsTotalLabel setFrame:CGRectMake(width + 60, yCoord, lTextWidth.width, height)];
    [lPriceLaborPartsTotalLabel setText:[NSString stringWithFormat:@"$ %.2f",lPriceLaborPartsTotal]];
    
    if( ([[[category.mROServiceLinesListArray objectAtIndex:indexPath.row] objectForKey:@"Declined"] boolValue] == TRUE)&& ((mAppDelegate_.mMasterViewController_->mselectedSegment_==3)||([[[[SharedUtilities sharedUtilities] appDelegateInstance] isCustomHeaderViewFullOrLight] isEqualToString:@"FULL"]))){
        
    CustomButtonForAddServices *button = (CustomButtonForAddServices *)[tableViewCell.contentView viewWithTag:3];
        UIImage *image = [UIImage imageNamed:@"AddServices"];
        button->row=indexPath.row;
        button->section=indexPath.section;
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setBackgroundImage:image forState:UIControlStateNormal];

    [button setFrame:CGRectMake(width + 150 + 60, (self.mTableView_.rowHeight - image.size.height)/2, image.size.width, image.size.height)];
    [button addTarget:self action:@selector(addDeclinedServicesButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    [button setHidden:FALSE];
    }else {
        CustomButtonForAddServices *button = (CustomButtonForAddServices *)[tableViewCell.contentView viewWithTag:3];
        [button setHidden:YES];
    }
}

#pragma mark --
#pragma mark  Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)addDeclinedServicesButtonAction:(CustomButtonForAddServices*)sender {
    VehicleHistoryCategory *category = (VehicleHistoryCategory *)[[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForVehicleHistoryTableView_.mVehicleHistoryCategoryList_ objectAtIndex:sender->section];
    NSMutableDictionary* lTempDict = [category.mROServiceLinesListArray objectAtIndex:sender->row];
    if (mAppDelegate_.mModelForWalkAround_.mShowVehicleHistoryPopUp_ == ShowVehicleHistoryPopUpFromAppointments) {
        [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForServiceRequestWebEngine_ setMGetServiceReference_:VEHICLEHISTORYSERVICES];
        [[[SharedUtilities sharedUtilities]appDelegateInstance].mServiceDataGetter_.mModelForSelectedService_ saveAddDictToModel:lTempDict];
        [mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_ convertModelToDict:TRUE];
        mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_->isAdd_=TRUE;

        [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForServiceRequestWebEngine_ RequestToAddService:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ ServiceDict:[[NSDictionary dictionaryWithObjectsAndKeys:[lTempDict objectForKey:KSGCID],KSGCID, nil] mutableCopy]];
    }else {
        [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelforOpenROSupportEngine_ setMGetServiceReference_:VEHICLEHISTORYSERVICES];
        [[[SharedUtilities sharedUtilities]appDelegateInstance].mServiceDataGetter_.mModelForSelectedService_ saveDictToModel:lTempDict];
        [mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_ convertModelToDict:FALSE];
        [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelforOpenROSupportEngine_ RequestForAddServiceLine:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_ SGCID:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mSGCID_];
    }
}

#pragma mark --
#pragma mark protocol delegate methods
- (void) sectionClosed : (NSInteger) section {
    /*
     Create an array of the index paths of the rows in the section that was closed, then delete those rows from the table view.
     */
	VehicleHistorySectionInfo *sectionInfo = [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForVehicleHistoryTableView_.mVehicleHistorySectionInfoArray_ objectAtIndex:section];
	
    sectionInfo.open = NO;
    NSInteger countOfRowsToDelete = [self.mTableView_ numberOfRowsInSection:section];
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:section]];
        }
        [self.mTableView_ deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    }
    [[SharedUtilities sharedUtilities]appDelegateInstance].mModelForVehicleHistoryTableView_.mVehicleHistoryOpenSectionIndex_ = NSNotFound;
}

- (void) sectionOpened : (NSInteger) section
{
    VehicleHistorySectionInfo *array = [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForVehicleHistoryTableView_.mVehicleHistorySectionInfoArray_ objectAtIndex:section];
    
    array.open = YES;
    NSInteger count = [array.category.mROServiceLinesListArray count];
    NSMutableArray *indexPathToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i<count;i++)
    {
        [indexPathToInsert addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    NSInteger previousOpenIndex = [[SharedUtilities sharedUtilities]appDelegateInstance].mModelForVehicleHistoryTableView_.mVehicleHistoryOpenSectionIndex_;
    
    if (previousOpenIndex != NSNotFound)
    {
        VehicleHistorySectionInfo *sectionArray = [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForVehicleHistoryTableView_.mVehicleHistorySectionInfoArray_ objectAtIndex:previousOpenIndex];
        sectionArray.open = NO;
        NSInteger counts = [sectionArray.category.mROServiceLinesListArray count];
        [sectionArray.sectionView toggleButtonPressed:FALSE];
        for (NSInteger i = 0; i<counts; i++)
        {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenIndex]];
        }
    }
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (previousOpenIndex == NSNotFound || section < previousOpenIndex)
    {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }
    else
    {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
    
    [self.mTableView_ beginUpdates];
    [self.mTableView_ insertRowsAtIndexPaths:indexPathToInsert withRowAnimation:insertAnimation];
    [self.mTableView_ deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self.mTableView_ endUpdates];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mVehicleHistoryOpenSectionIndex_ = section;
}

- (IBAction)cancelButtonAction:(id)sender {
    mAppDelegate_.mModelForWalkAround_.mShowVehicleHistoryPopUp_ = 0;
    DLog(@"topViewController :-%@",mAppDelegate_.mECSlidingViewController_.topViewController);
    [mAppDelegate_.mModelForVehicleHistoryTableView_ dismissVehicleHistoryViewController:mAppDelegate_.mECSlidingViewController_.topViewController];
    [[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForVehicleHistoryTableView_].mToshowVehicleHistoryViewOrNot_  = NO;

}

- (IBAction)acceptButtonAction:(id)sender {
    
    [mAppDelegate_.mModelForVehicleHistoryTableView_ dismissVehicleHistoryViewController:mAppDelegate_.mECSlidingViewController_.topViewController];
    if (mAppDelegate_.mModelForWalkAround_.mShowVehicleHistoryPopUp_) {
        
    }else {
        [[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForVehicleHistoryTableView_].mToshowVehicleHistoryViewOrNot_  = NO;
         [[VehicleHistorySupportWebEngine sharedInstance] methodToChangeModeFormDispatchModeToInspectionView];
    }
    mAppDelegate_.mModelForWalkAround_.mShowVehicleHistoryPopUp_ = 0;
    if ([[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_.topViewController isKindOfClass:[SearchViewController class]]) {
        [[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_.topViewController.view addGestureRecognizer:[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_.panGesture];
        [[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_ setAnchorRightRevealAmount:340.0f];
        if ([[SharedUtilities sharedUtilities]appDelegateInstance].mWalkAroundLeftViewController_ == nil) {
            WalkAroundLeftViewController *lViewControler = [[WalkAroundLeftViewController alloc] init];
            [[[SharedUtilities sharedUtilities]appDelegateInstance] setMWalkAroundLeftViewController_:lViewControler];
            [[[SharedUtilities sharedUtilities]appDelegateInstance].mWalkAroundLeftViewController_.view setBackgroundColor:[UIColor ASRProRGBColor:66 Green:66 Blue:68]];
            
        }
        if (![[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_.underLeftViewController isKindOfClass:[WalkAroundLeftViewController class]]) {
            [[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_.underLeftViewController  = [[SharedUtilities sharedUtilities]appDelegateInstance].mWalkAroundLeftViewController_;
        }
        
    }

}

@end



@implementation CustomButtonForAddServices

@end;




