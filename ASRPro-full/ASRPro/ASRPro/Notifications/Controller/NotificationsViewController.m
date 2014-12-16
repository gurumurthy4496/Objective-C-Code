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
@synthesize mDateFormatter;;

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
    [self.view customHeaderViewFull:self SelectedButton:@"Notifications"];
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
        
        UILabel *lUILabelDate=[[UILabel alloc]init];
        [lUILabelDate setBackgroundColor:[UIColor clearColor]];
        [lUILabelDate setTextColor:[UIColor grayColor]];
        [lUILabelDate setFont:[UIFont regularFontOfSize:14.0f fontKey:kFontNameHelveticaNeueKey]];
        [lUILabelDate setHighlightedTextColor:[UIColor blackColor]];
        [cell.contentView addSubview:lUILabelDate];
        [lUILabelDate setTag:tagCount+1];
        RELEASE_NIL(lUILabelDate);
    }
    [self resetTableViews:cell];
    [self populateFormsSectionWithIndexPath:indexPath cell:cell tableView:tableView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0;
    if ([[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] count] > 0) {
        height  =  (CGFloat)[[SharedUtilities sharedUtilities] dynamicLabelHeightForTextCharacterWrap:[NSString stringWithFormat:@"%@",[[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] objectAtIndex:indexPath.row] objectForKey:@"aps"] objectForKey:@"alert"]] :800 :[UIFont regularFontOfSize:14.0f fontKey:kFontNameHelveticaNeueKey] :NSLineBreakByWordWrapping];
        height = (height > kNotificationTableViewRowHeight) ?height+20+30 :kNotificationTableViewRowHeight+30;
        
    }else {
        
    }
    return height;
}

#pragma mark --
#pragma mark  Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [mAppDelegate_.mModelForNotifications_ dismissNotificationsViewController];
    mAppDelegate_.mModelForNotifications_.mNotificationsRONumber_ = [[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] objectAtIndex:indexPath.row] objectForKey:@"RONumber"];
    mAppDelegate_.mOnSuccessDelegate_ = self;
    [mAppDelegate_.mModelForNotifications_ threadRequestToGetRepairOrdersInNotifications];
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*[[SharedUtilities sharedUtilities] appDelegateInstance].mRequestMethods_.isReference = TRUE;
     
     [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForRepairOrderModes_] setMRONumber_:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] objectAtIndex:indexPath.row] objectForKey:@"RONumber"]];
     
     [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForInspectionRequestWebEngine_] requestForFormID:[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForRepairOrderModes_].mRONumber_];
     [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForServiceRequestWebEngine_ setMGetServiceReference_:RODETAILVIEWCONTROLLER];
     [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForServiceRequestWebEngine_] RequestForGetROLines:[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForRepairOrderModes_].mRONumber_];*/
    
}

#pragma mark --
#pragma mark Protocol Methods
-(void)OnsuccessResponseForRequest {
    [self.view pushToOpenROs:mAppDelegate_.mModelForNotifications_.mNotificationsRONumber_];

}

#pragma mark --
#pragma mark Table Sections Populate methods

- (void)resetTableViews:(UITableViewCell*)tableViewCell  { // made minor chagnes by Ram
    int tagCount = 1;
	// reset UILabels;
    UILabel *lUILabel = (UILabel*)[tableViewCell viewWithTag:tagCount];
    lUILabel.text = @"";
    UILabel *lUILabel1 = (UILabel*)[tableViewCell viewWithTag:tagCount+1];
    lUILabel1.text = @"";

}

- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView  {
    
    //----- local coordinates for setting frames of the internal UI Elements -----
    
    CGFloat xCoord = 15, yCoord = 0, width = 800/*, height = [tabelView rowHeight]*/;
    CGFloat flexibleheight = 0.0;
    if ([[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] count] > 0) {
        flexibleheight  =  (CGFloat)[[SharedUtilities sharedUtilities] dynamicLabelHeightForTextCharacterWrap:[NSString stringWithFormat:@"%@",[[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] objectAtIndex:indexPath.row] objectForKey:@"aps"] objectForKey:@"alert"]] :800 :[UIFont regularFontOfSize:14.0f fontKey:kFontNameHelveticaNeueKey] :NSLineBreakByWordWrapping];
        
        flexibleheight = (flexibleheight > kNotificationTableViewRowHeight) ?flexibleheight+20 :kNotificationTableViewRowHeight;
        
    }else {
        return;
    }
    
    // ----------------------------;
    // To display title(Tag#,Customer,Promised Date,Promised Time) for labels;
    // ----------------------------;
    
    /*NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] objectAtIndex:indexPath.row] objectForKey:@"aps"] objectForKey:@"alert"]]];
    
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
    lRONotificationText.attributedText = str;*/
    
    
    
    // ----------------------------;
    // To display date for labels;
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
    [str addAttribute:NSFontAttributeName value:[UIFont boldFontOfSize:17.0 fontKey:kFontNameHelveticaNeueKey] range:NSMakeRange(firstCharacterPosition, range.length)];
    
    
    UILabel *lRONotificationText = (UILabel*)[tableViewCell.contentView viewWithTag:1];
    [lRONotificationText setFrame:CGRectMake(xCoord, yCoord, width, flexibleheight)];
    [lRONotificationText setFont:[UIFont regularFontOfSize:14.0f fontKey:kFontNameHelveticaNeueKey]];
    [lRONotificationText setLineBreakMode:NSLineBreakByWordWrapping];
    [lRONotificationText setNumberOfLines:0];
    //    [lRONotificationText setText:[[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] objectAtIndex:indexPath.row] objectForKey:@"aps"] objectForKey:@"alert"]];
    [lRONotificationText setAttributedText:str];
    
    // ----------------------------;
    // To display title(Tag#,Customer,Promised Date,Promised Time) for labels;
    // ----------------------------;
    
    UILabel *lDateText = (UILabel*)[tableViewCell.contentView viewWithTag:2];
    [lDateText setFrame:CGRectMake(xCoord, yCoord +flexibleheight, width, 20)];
    [lDateText setFont:[UIFont regularFontOfSize:10.0f fontKey:kFontNameHelveticaNeueKey]];
    [lDateText setLineBreakMode:NSLineBreakByWordWrapping];
    [lDateText setNumberOfLines:0];
    //Employee name, Rime Label
    NSDate * lDate = [[SharedUtilities sharedUtilities]dateFromDotNetJSONString:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNotificationsArray_] objectAtIndex:indexPath.row] objectForKey:@"CreateDate"]];
    [self setDateFormatter:@"MM/dd/yyyy hh:mm a"];
    
    NSString *dateString = [self.mDateFormatter stringFromDate:lDate];
    [lDateText setText:[self calculateRefreshTime:dateString]];
    
}

- (void)setDateFormatter :(NSString *)formatter {
    self.mDateFormatter = [[NSDateFormatter alloc] init];
    [self.mDateFormatter setDateFormat:formatter];
}

#pragma mark To calculate Refresh time
- (NSString *) calculateRefreshTime:(NSString *)dateStr
{
    NSDate *curDate =[NSDate date];
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [self.mDateFormatter setTimeZone:gmt];
    
    NSString *currentDateStr = [self.mDateFormatter stringFromDate:curDate];
    
    NSDate *date1 = [self.mDateFormatter dateFromString:dateStr];
    
    NSDate *date2 = [self.mDateFormatter dateFromString:currentDateStr];
    
    if (date1 != nil) {
        NSCalendar *sysCalendar = [NSCalendar currentCalendar];
        // Get conversion to months, days, hours, minutes
        unsigned int unitFlags = NSSecondCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
        NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:date1  toDate:date2  options:0];
//        NSLog(@"Conversion: %dsec %dmin %dhours %ddays %dmoths %dyears",[conversionInfo second],[conversionInfo minute], [conversionInfo hour], [conversionInfo day], [conversionInfo month], [conversionInfo year]);
        NSString *tempStr1 = @"";
        
        
        if ([conversionInfo day] > 0) {
            if ([conversionInfo day] == 1) {
                [self setDateFormatter:@"hh:mm a"];
                NSString *actualTime = [self.mDateFormatter stringFromDate:date1];
                return tempStr1 = [NSString stringWithFormat:@"Yesterday at %@",actualTime];
                
                //                return tempStr1 = [NSString stringWithFormat:@"%d day ago",[conversionInfo day]];
                //                return tempStr1 = [NSString stringWithFormat:@"Today at %@",actualTime];
            }else if ([conversionInfo day] == 2) {
                [self setDateFormatter:@"hh:mm a"];
                NSString *actualTime = [self.mDateFormatter stringFromDate:date1];
                [self setDateFormatter:@"MM/dd/yyyy"];
                NSString *actualDate = [self.mDateFormatter stringFromDate:date1];
                
                return tempStr1 = [NSString stringWithFormat:@"%@ at %@",actualDate, actualTime];
                
                //                return tempStr1 = [NSString stringWithFormat:@"Yesterday at %@",actualTime];
            }
            else {
                [self setDateFormatter:@"hh:mm a"];
                NSString *actualTime = [self.mDateFormatter stringFromDate:date1];
                [self setDateFormatter:@"MM/dd/yyyy"];
                NSString *actualDate = [self.mDateFormatter stringFromDate:date1];
                
                return tempStr1 = [NSString stringWithFormat:@"%@ at %@",actualDate, actualTime];
            }
        }
        else {
            [self setDateFormatter:@"hh:mm a"];
            NSString *actualTime = [self.mDateFormatter stringFromDate:date1];
            
            return tempStr1 = [NSString stringWithFormat:@"Today at %@",actualTime];
        }
    }
    return @"";
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
