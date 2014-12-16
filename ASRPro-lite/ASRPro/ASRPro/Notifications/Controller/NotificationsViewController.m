//
//  NotificationsViewController.m
//  ASRPro
//
//  Created by GuruMurthy on 28/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "NotificationsViewController.h"
#define kNotificationTableViewRowHeight 47
@interface NotificationsViewController () {
    AppDelegate *mAppDelegate_;
}

@end

@implementation NotificationsViewController

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
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    [self initializationOfObjectsForNotificationsView];
    [self setFontsAndTextForNotificationsView];
}

- (void)viewWillAppear:(BOOL)animated {
    [mAppDelegate_.mModelForNotifications_ setTopNavigationBarHiddenForNotificationsScreen:self.view Hidden:YES Button:nil];
    if ([[mAppDelegate_ mModelForNotifications_].mNotificationsArray_ count] >0) {
        [self.mclearAllButton_ setHidden:NO];
    }else {
        [self.mclearAllButton_ setHidden:YES];
    }
    [[SharedUtilities sharedUtilities] hideEmptySeparators:self.mNotificationTableView_];
}

// GeneralSettingsViewController
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
//    self.view.superview.bounds = CGRectMake(0, 0, 980, 660);
}

#pragma mark --
#pragma mark Private Methods
- (void)initializationOfObjectsForNotificationsView {
    [self.navigationController setNavigationBarHidden:YES];
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];

    [self.mclearAllButton_ setTitle:@"Clear All" forState:UIControlStateNormal];
    [self.mclearAllButton_ setTitle:@"Clear All" forState:UIControlStateSelected];
    [self.mclearAllButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.mclearAllButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.mclearAllButton_.titleLabel setFont:[UIFont regularFontOfSize:17 fontKey:kFontNameOpenSansKey]];
    
    [self.mNotifiationLabel_ setBackgroundColor:[UIColor ASRProBlueColor]];
    [self.mNotifiationLabel_ setText:@"   Notifications"];
    [self.mNotifiationLabel_ setFont:[UIFont regularFontOfSize:17 fontKey:kFontNameHelveticaNeueKey]];
    [self.mNotifiationLabel_ setTextColor:[UIColor whiteColor]];
    [self.mNotifiationLabel_ setTextAlignment:NSTextAlignmentLeft];
    
    [self.mView_.layer setBorderColor:[UIColor ASRProBlueColor].CGColor];
    [self.mView_.layer setBorderWidth:2.0f];
}


- (void)setFontsAndTextForNotificationsView {
    
}


#pragma mark --
#pragma mark Public Methods
// ----------------------------;
// This method is called after succes response for ROList Request;
// ----------------------------;
- (void)reloadNotificationDataInTableView {
    [self.mNotificationTableView_ reloadData];
    
}

#pragma mark --
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_].mNotificationsArray_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //Configure cell format for the tableView,
        //Same format for all the three sections.
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.alpha=0.30;
        
        int tagCount = 1;
        
        UILabel *lUILabel=[[UILabel alloc]init];
        [lUILabel setBackgroundColor:[UIColor clearColor]];
        [lUILabel setTextColor:[UIColor blackColor]];
        [lUILabel setFont:[UIFont regularFontOfSize:14.0f fontKey:kFontNameHelveticaNeueKey]];
        [lUILabel setHighlightedTextColor:[UIColor blackColor]];
        [cell.contentView addSubview:lUILabel];
        [lUILabel setTag:tagCount];
        RELEASE_NIL(lUILabel);
        
    }
    [self resetTableViews:cell];
    [self populateFormsSectionWithIndexPath:indexPath cell:cell tableView:tableView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0;
    if ([[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] count] > 0) {
        height  =  (CGFloat)[[SharedUtilities sharedUtilities] dynamicLabelHeightForTextCharacterWrap:[NSString stringWithFormat:@"%@",[[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] objectAtIndex:indexPath.row] objectForKey:@"aps"] objectForKey:@"alert"]] :700 :[UIFont regularFontOfSize:14.0f fontKey:kFontNameHelveticaNeueKey] :NSLineBreakByWordWrapping];
        height = (height > kNotificationTableViewRowHeight) ?height+20 :kNotificationTableViewRowHeight;
        
    }else {
        
    }
    return height;
}

#pragma mark --
#pragma mark  Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   [ self.view pushToOpenROs:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] objectAtIndex:indexPath.row] objectForKey:@"RONumber"]];
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*[[SharedUtilities sharedUtilities] appDelegateInstance].mRequestMethods_.isReference = TRUE;
     
     [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForRepairOrderModes_] setMRONumber_:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] objectAtIndex:indexPath.row] objectForKey:@"RONumber"]];
     
     [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForInspectionRequestWebEngine_] requestForFormID:[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForRepairOrderModes_].mRONumber_];
     [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForServiceRequestWebEngine_ setMGetServiceReference_:RODETAILVIEWCONTROLLER];
     [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForServiceRequestWebEngine_] RequestForGetROLines:[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForRepairOrderModes_].mRONumber_];*/
    
}


#pragma mark --
#pragma mark Table Sections Populate methods

- (void)resetTableViews:(UITableViewCell*)tableViewCell  { // made minor chagnes by Ram
    int tagCount = 1;
	// reset UILabels;
    UILabel *lUILabel = (UILabel*)[tableViewCell viewWithTag:tagCount];
    lUILabel.text = nil;
}

- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView  {
    
    //----- local coordinates for setting frames of the internal UI Elements -----
    
    CGFloat xCoord = 15, yCoord = 0, width = 700/*, height = [tabelView rowHeight]*/;
    CGFloat flexibleheight = 0.0;
    if ([[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] count] > 0) {
        flexibleheight  =  (CGFloat)[[SharedUtilities sharedUtilities] dynamicLabelHeightForTextCharacterWrap:[NSString stringWithFormat:@"%@",[[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] objectAtIndex:indexPath.row] objectForKey:@"aps"] objectForKey:@"alert"]] :260 :[UIFont regularFontOfSize:14.0f fontKey:kFontNameHelveticaNeueKey] :NSLineBreakByWordWrapping];
        
        flexibleheight = (flexibleheight > kNotificationTableViewRowHeight) ?flexibleheight+20 :kNotificationTableViewRowHeight;
        
    }else {
        return;
    }
    
    // ----------------------------;
    // To display title(Tag#,Customer,Promised Date,Promised Time) for labels;
    // ----------------------------;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] objectAtIndex:indexPath.row] objectForKey:@"aps"] objectForKey:@"alert"]]];
    
    NSString *tempString = [NSString stringWithFormat:@"%@",[[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] objectAtIndex:indexPath.row] objectForKey:@"aps"] objectForKey:@"alert"]];
    
    // Intermediate
    NSString *numberString = [NSString stringWithFormat:@"RO# %@",[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] objectAtIndex:indexPath.row] objectForKey:@"RONumber"]];
    
    NSRange range = [tempString rangeOfString:numberString];
    
    NSUInteger firstCharacterPosition = range.location;
    NSUInteger lastCharacterPosition = range.location + range.length;
    
    
    DLog(@"%d",firstCharacterPosition);
    DLog(@"%d",lastCharacterPosition);
    [str addAttribute:NSFontAttributeName value:[UIFont boldFontOfSize:17.0 fontKey:kFontNameHelveticaNeueKey] range:NSMakeRange(0, lastCharacterPosition)];
    
    UILabel *lRONotificationText = (UILabel*)[tableViewCell.contentView viewWithTag:1];
    [lRONotificationText setFrame:CGRectMake(xCoord, yCoord, width, flexibleheight)];
    [lRONotificationText setFont:[UIFont regularFontOfSize:14.0f fontKey:kFontNameHelveticaNeueKey]];
    [lRONotificationText setLineBreakMode:NSLineBreakByWordWrapping];
    [lRONotificationText setNumberOfLines:0];
    //    [lRONotificationText setText:[[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] objectAtIndex:indexPath.row] objectForKey:@"aps"] objectForKey:@"alert"]];
    lRONotificationText.attributedText = str;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {// If yes
        
        NSMutableArray* lDeleteArray=[[NSMutableArray alloc] init];
        for (int i = [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_]mAllDataForNotificationsArray_] count]-1; i >= 0; i--) {
            if ([[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_].mAllDataForNotificationsArray_ objectAtIndex:i] objectForKey:@"RecipientID"] integerValue] == [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeID_ integerValue]) {
                [lDeleteArray addObject:[NSString stringWithFormat:@"%i",i]];
            }
        }
        
        for(int i=0;i<[lDeleteArray count];i++){
            [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mAllDataForNotificationsArray_] removeObjectAtIndex:[[lDeleteArray objectAtIndex:i] intValue]];
        }
        
        RELEASE_NIL(lDeleteArray);
        
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_].mNotificationsArray_ removeAllObjects];
        [self.mNotificationTableView_ reloadData];
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] methodToSetNewNotificationCount:0];
    }
}

- (IBAction)closeButtonAction:(id)sender {
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] dismissNotificationsViewController];
}
- (IBAction)clearallButtonAction:(id)sender {
    if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_].mNotificationsArray_ count] >0) {
        UIAlertView *lAlertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Do you want to delete all notifications?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [lAlertView show];
    }
}

#pragma mark --
#pragma mark MemoryManagement Methods
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
