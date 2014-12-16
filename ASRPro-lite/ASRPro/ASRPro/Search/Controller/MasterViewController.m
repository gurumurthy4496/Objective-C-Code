//
//  MasterViewController.m
//  ASRPro
//
//  Created by Santosh Kvss on 1/31/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "MasterViewController.h"
#import "SearchSupportWebEngine.h"

#define DateFormatApp @"dd/MM/yyyy  hh:mm a"
#define TimeFormatApp @"HH:mm"
#define KROWHEIGHT 48

@interface MasterViewController ()

@end

@implementation MasterViewController
@synthesize mSearhBar_;
@synthesize mOpenRODropDownView_;

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
    mAppdelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    [self initData];
    _mOpenROTableView_.mMasterViewController_ =self;
    _mOpenROTableView_->mAppDelegate_= mAppdelegate_;
    [_mOpenROTableView_ setDelegatesForSearchListTableview_];
}

#pragma mark -  ***************** Button Actions ****************

- (IBAction)refreshBtnAction:(id)sender {
    [mAppdelegate_.mModelForEditCustomerScreen_ resetallData];
    [mAppdelegate_.mModelForEditVehicleScreen_ resetallData];
    if (mSearhBar_.text != nil) {
        mSearhBar_.text = @"";
    }
    [mAppdelegate_.mSearchViewController_.mVehicleHistory_ setHidden:TRUE];
    [mAppdelegate_.mSearchViewController_.mVehicleHistoryLbl_ setText:@""];
    [self updateDateAndTime];
    if(mselectedSegment_==2 || mselectedSegment_ == 3) {
        [self postRequestToGetRepairOrders];
    }
}

- (IBAction)BeginVehicleCheckInBtnAction:(id)sender {
    
    [self resetAllData];
    [self.mAppointmentAndInprocessTableView_ reloadData];
    [mAppdelegate_.mSearchViewController_ enableOrdisableEditCustomerOrVehiclebtn];
    [mAppdelegate_.mSearchViewController_.mContinueBtn_ setHidden:TRUE];
    BeginVehicleCheckInViewViewController *lBeginVehicleCheckInView = [[BeginVehicleCheckInViewViewController alloc] initWithNibName:@"BeginVehicleCheckInViewViewController" bundle:nil];
    [mAppdelegate_ setMBeginVehicleCheckInView_:lBeginVehicleCheckInView];
    mAppdelegate_.mViewReference_ = self;
    mAppdelegate_.mBeginVehicleCheckInView_.modalPresentationStyle=UIModalPresentationPageSheet;
    mAppdelegate_.mBeginVehicleCheckInView_.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    [self presentViewController:mAppdelegate_.mBeginVehicleCheckInView_ animated:YES completion:nil];
}

- (IBAction)segmentBtnAction:(id)sender {
    [self.mOpenRODropDownView_ hideOpenRODropDown:self.mOpenROFilterButton_];
    [self opnORDropDownNil];
    [self.mSearhBar_ setText:@""];
    [self.mSearhBar_ endEditing:YES];
    [mAppdelegate_.mSearchViewController_.mVehicleHistory_ setHidden:TRUE];
    [mAppdelegate_.mSearchViewController_.mVehicleHistoryLbl_ setText:@""];
    [self resetAllData];
    UIButton *lBtn = (UIButton*)sender;
    self.mSearchedListTableView_.hidden = YES;
    if (lBtn.tag==2) {
        // @"***** Button Tag :- *****
        [self.mAppointmentAndInprocessTableView_ setScrollEnabled:YES];
        mselectedSegment_ = lBtn.tag;
        [mAppdelegate_.mModelForSearchScreen_ setTopNavigationBarHiddenForOpenROScreen:mAppdelegate_.mSearchViewController_.view Hidden:NO Button:nil];
        self.mOpenROTableView_.hidden = YES;
        [self.mBarCodeBtn_ setHidden:FALSE];
        [self.mBeginVehicleCheckInBtn_ setEnabled:YES];
        self.mAppointmentAndInprocessTableView_.hidden = NO;
        mAppdelegate_.mSearchDataGetter_.mInprocessListData_ = nil;
         [self postRequestToGetRepairOrders];
        [self.mAppointmentAndInprocessTableView_ reloadData];
        //To set the top navigation bar
        [self setTopNavigationBar];
        [self.mOpenROFilterButton_ setHidden:YES];
        [mAppdelegate_.mSearchViewController_ showVehicleHistoryScreen];
        [mAppdelegate_.mSearchViewController_ setMSearchCategory_:SearchDMS];
        
    } else if (lBtn.tag==3) {
        mselectedSegment_ = lBtn.tag;
        self.mOpenROTableView_.hidden = NO;
        for (UIView *lview in self.view.subviews) {
            if([lview isKindOfClass:[UIButton class]]) {
                if(((UIButton *)lview).tag == 50){
                    [((UIButton *)lview) setEnabled:NO];
                }
            }
        }
        mAppdelegate_.mSearchDataGetter_.mOpenROListDisplayData_ = [mAppdelegate_.mSearchDataGetter_.mOpenROListData_ mutableCopy];
        [mAppdelegate_.mSearchViewController_.mVehicleHistory_.superview setHidden:TRUE];
        self.mAppointmentAndInprocessTableView_.hidden = YES;
        [self reloadOpenROData];
        [mAppdelegate_.mSearchViewController_ enableOrdisableEditCustomerOrVehiclebtn];
        //To set the top navigation bar hidden
        [mAppdelegate_.mSearchViewController_ setMSearchCategory_:SearchOpenRO];
        [mAppdelegate_.mModelForSearchScreen_ setTopNavigationBarHiddenForOpenROScreen:mAppdelegate_.mSearchViewController_.view Hidden:YES Button:nil];
        [self.mBarCodeBtn_ setHidden:TRUE];
        [self.mOpenROFilterButton_ setHidden:NO];
        [self.mOpenROFilterButton_ setEnabled:YES];
        [self.view bringSubviewToFront:self.mOpenROFilterButton_];
        [self.mOpenROFilterButton_ setTitle:@"All" forState:UIControlStateNormal];
        [self.mOpenROFilterButton_ setTitle:@"All" forState:UIControlStateSelected];
        [self.mOpenROFilterButton_ setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
        [self.mOpenROFilterButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.mOpenROFilterButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

        [mAppdelegate_.mSearchViewController_ showServicesScreen];
    }
    
    for (UIView *lview in self.view.subviews) {
                if([lview isKindOfClass:[UIButton class]]) {
                    if((UIButton *)lview==(UIButton *)sender){
                        mselectedSegment_ = lview.tag;
                        [(UIButton *)lview setSelected:YES];
                        [(UIButton *)lview setBackgroundColor:[UIColor ASRProBlueColor]];
                    } else {
                        [(UIButton *)lview setSelected:NO];
                        [(UIButton *)lview setBackgroundColor:[UIColor whiteColor]];
                    }
                }
    }
}

//This method is called @Lines 93 & 109
- (void)setTopNavigationBar {
    //To set the top navigation bar
    [self.view.superview.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        UIView *view = (UIView *)object;
        if (view.tag == 1) {
            [view.subviews enumerateObjectsUsingBlock:^(id object1, NSUInteger index1, BOOL *stop1) {
                UIButton *button = (UIButton *)object1;
                if (button.tag == 101) {
                    [mAppdelegate_.mModelForSearchScreen_ setTopNavigationBarHiddenForOpenROScreen:self.view.superview Hidden:NO Button:button];
                    *stop1 = YES;
                    *stop = YES;
                    return;
                }
            }];
        }
    }];
}

- (IBAction)barCodeBtnAction:(id)sender {
    
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
    [self presentViewController:reader animated:YES completion:nil];
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    
    // Setting scanned Barcode data to textfield
    [self.mSearhBar_ setText:symbol.data];
    
    // dismiss the controller
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.mSearhBar_ searchBarSearchButtonClicked:self.mSearhBar_];
    [self.mBarCodeBtn_ setHidden:TRUE];
}

#pragma mark -  ***************** Generic methods ****************

- (void)initData {
    
    UISearchBar *lSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 45, 302, 35)];
    CGRect frame = lSearchBar.frame;
    lSearchBar.tag = 1;
    [lSearchBar CustomSearchBar:frame];
    self.mSearhBar_ = lSearchBar;
    // Get the instance of the UITextField of the search bar
    UITextField *searchField = [self.mSearhBar_ valueForKey:@"_searchField"];
    // Change the search bar placeholder text color
    [searchField setValue:[UIColor ASRProBlueColor] forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:[UIFont systemFontOfSize:15.0] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.mSearhBar_];
    UIImage *lImg = [UIImage imageNamed:@"Barcode.png"];
    UIButton *lBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lBtn.frame = CGRectMake(260, 54, lImg.size.width, lImg.size.height);
    [self setMBarCodeBtn_:lBtn];
    [_mBarCodeBtn_ setImage:lImg forState:UIControlStateNormal];
    [_mBarCodeBtn_ addTarget:self action:@selector(barCodeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_mBarCodeBtn_];
    [[SharedUtilities sharedUtilities] hideEmptySeparators:_mAppointmentAndInprocessTableView_];
    [self setBorderColor];
    [self updateDateAndTime];
    [self setFontsAndTextToSearchScreenView];
    
    for (UIView *lview in self.view.subviews) {
        if([lview isKindOfClass:[UIButton class]]) {
            if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Technician"]) {
                if (lview.tag == 3) {
                    mAppdelegate_.mSearchViewController_.isFromInProcess = TRUE;
                    self.isFromLogin = TRUE;
                    [(UIButton *)lview setSelected:YES];
                    [(UIButton *)lview setBackgroundColor:[UIColor ASRProBlueColor]];
                    [self segmentBtnAction:(UIButton *)lview];
                    [self.mBarCodeBtn_ setHidden:TRUE];
                    mselectedSegment_ = 3;
                }else {
                    [(UIButton *)lview setSelected:NO];
                    if (((UIButton *)lview).tag != 20) {
                        [(UIButton *)lview setEnabled:NO];                        
                    }
                    [(UIButton *)lview setBackgroundColor:[UIColor whiteColor]];
                }
            }else {
                if (lview.tag == 2) {
                    mAppdelegate_.mSearchViewController_.isFromInProcess = TRUE;
                    self.isFromLogin = TRUE;
                    [self.mOpenROFilterButton_ setHidden:YES];
                    [self.mBarCodeBtn_ setHidden:FALSE];
                    [(UIButton *)lview setSelected:YES];
                    [(UIButton *)lview setBackgroundColor:[UIColor ASRProBlueColor]];
                    mselectedSegment_ = 2;
                }
            }
        }
    }
    _mSearchedListTableView_.mMasterViewController_ = self;
    _mSearchedListTableView_->mAppDelegate_ = mAppdelegate_;
    [_mSearchedListTableView_ setDelegatesForSearchListTableview_];
}

- (void)setFontsAndTextToSearchScreenView {

}

- (void)setBorderColor {
    
    [self.view.layer setBorderColor:[[UIColor ASRProBlueColor] CGColor]];
    [self.view.layer setBorderWidth:2.0];
    for(UIView *lView in self.view.subviews) {
        if ([lView isKindOfClass:[UIButton class]]) {
            DLog(@"%i",lView.tag);
            if(lView.tag != 50) {
                [lView.layer setBorderColor:[[UIColor ASRProBlueColor] CGColor]];
                [lView.layer setBorderWidth:0.5];
            }
        }
        if ([lView isKindOfClass:[UITableView class]]) {
            UITableView *mTableView = (UITableView*)lView;
            if ([mTableView respondsToSelector:@selector(setSeparatorInset:)]) {
                [mTableView setSeparatorInset:UIEdgeInsetsZero];
            }
        }
    }
}

- (void)errorResponseForVehicleHistory {
    
        NSMutableDictionary *lTempDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:NSLocalizedString(@"lNoVehicleHistoryFound", Nil),@"RONumber",@"",@"DMSClosedDate", nil];
        NSMutableArray *lTempArray = [[NSMutableArray alloc] initWithObjects:lTempDictionary, nil];
        mAppdelegate_.mSearchDataGetter_.mVehicleHistoryData_ = lTempArray;
        DLog(@"%@",mAppdelegate_.mSearchDataGetter_.mVehicleHistoryData_);
}

- (void)onSelectionOfInProcess {
    [mAppdelegate_.mSearchViewController_.mContinueBtn_ setHidden:YES];
    [self pushDataintoModalCustomerAndVehicleForApp];
    [mAppdelegate_.mSearchViewController_ enableOrdisableEditCustomerOrVehiclebtn];
    [mAppdelegate_.mSearchViewController_ setCustomerInfomationLabelsTextFromModel];
    [mAppdelegate_.mSearchViewController_ setVehicleInfomationLabelsTextFromModel];
    (![mAppdelegate_.mModelForEditCustomerScreen_.mCustomerID_ isEqualToString:@"00000000000000000000000000000000"] && ![mAppdelegate_.mModelForEditCustomerScreen_.mCustomerID_ isEqualToString:@"00000000000000000000000000000000"])?[self setRequestforVehicleHistory]:[self errorResponseForVehicleHistory];
    [mAppdelegate_.mSearchViewController_.mVehicleHistoryLbl_ setText:NSLocalizedString(@"NO_VEHICLE_HISTORY", nil)];
}

- (void)pushDataintoModalCustomerAndVehicleForApp {

        mAppdelegate_.mModelForSearchScreen_.mAdvisorID_ = [[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:_mselectedInprocessindex_] objectForKey:@"AdvisorID"];
        mAppdelegate_.mModelForSearchScreen_.mMileage = [[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:_mselectedInprocessindex_] objectForKey:@"Vehicle"] objectForKey:@"Mileage"];
        [mAppdelegate_.mModelForEditCustomerScreen_ setValues:(NSMutableDictionary*)[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:_mselectedInprocessindex_] objectForKey:@"Customer"]];
        [mAppdelegate_.mModelForEditVehicleScreen_ setValues:(NSMutableDictionary*)[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:_mselectedInprocessindex_] objectForKey:@"Vehicle"]];
}

- (void)reloadInProcessData {
    
    [self updateDateAndTime];
    [self resetAllData];
    [self.mAppointmentAndInprocessTableView_ reloadData];
    [mAppdelegate_.mSearchViewController_ enableOrdisableEditCustomerOrVehiclebtn];
}

- (void)reloadOpenROData {
    
    [mAppdelegate_.mModelForSplashScreen_ setMEmployeesDataArray_:[[SharedUtilities sharedUtilities] retrieveArrayFromFile:kEmployeesData]];
    [self updateDateAndTime];
    [self.mOpenROTableView_ reloadData];
}

- (void)reloadOPenROTableViewAfterDoneCheckIn {
    [self updateDateAndTime];
    [self.mOpenROTableView_ reloadData];
    NSIndexPath *lSelectedIndexPath;
    DLog(@"CUSTOMER_ID :-%@",[mAppdelegate_.mModelForCheckIn_.mCustomerAndVehicleInfoArray_ valueForKey:@"ID"]);
    for (int i=0; i<[mAppdelegate_.mSearchDataGetter_.mOpenROListDisplayData_ count]; i++) {
        if ([[[mAppdelegate_.mModelForCheckIn_.mCustomerAndVehicleInfoArray_ valueForKey:@"ID"] stringByReplacingOccurrencesOfString:@"-" withString:@""] isEqualToString:[[[mAppdelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:i] valueForKey:@"Customer"] objectForKey:@"ID"]]) {
            lSelectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        }
    }
    [mAppdelegate_.mMasterViewController_.mOpenROTableView_ selectRowAtIndexPath:lSelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    [mAppdelegate_.mMasterViewController_.mOpenROTableView_ onSelectionOfOpenRO:lSelectedIndexPath.row];
    mAppdelegate_.mModelforOpenROSupportEngine_.mGetServiceReference_= OPENROMAINVIEWCONTROLLER;
//    [mAppdelegate_.mModelforOpenROSupportEngine_  RequestForGetROLines:[NSString stringWithFormat:@"%@",[[mAppdelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:lSelectedIndexPath.row] objectForKey:@"RONumber"]]];
    [mAppdelegate_.mModelforOpenROSupportEngine_  RequestForRepairOrderServiceLines:[NSString stringWithFormat:@"%@",[[mAppdelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:lSelectedIndexPath.row] objectForKey:@"RONumber"]]];
}

- (void)reloadSearchData {
    
    self.mSearchedListTableView_.hidden=NO;
    [self updateDateAndTime];
    [self.mSearchedListTableView_ reloadData];
}

- (void)resetAllData {
    mAppdelegate_.mModelForSearchScreen_.mMileage = @"";
    mAppdelegate_.mModelForSearchScreen_.mTag_ = @"";
    [mAppdelegate_.mModelForEditCustomerScreen_ resetallData];
    [mAppdelegate_.mModelForEditVehicleScreen_ resetallData];
    [mAppdelegate_.mSearchViewController_ setCustomerInfomationLabelsTextFromModel];
    [mAppdelegate_.mSearchViewController_ setVehicleInfomationLabelsTextFromModel];
}

- (void)updateDateAndTime {
    
    self.mUpdatedDate_=[NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [self setMFormatter_:formatter];
    [_mFormatter_ setDateFormat:DateFormatApp];
    NSString *lDateStr=[_mFormatter_ stringFromDate:self.mUpdatedDate_];
    _mUpdateDateLbl_.text=(lDateStr)?[NSString stringWithFormat:@"Last updated  %@",lDateStr]:[NSString stringWithFormat:@"Last updated  %@",@""];
}

//--------------------------------------------------- ************** ------------------------------------------------------
//            *** this method is used to return the string (includes Time,Salutation,FirstName,LastName & MiddleName) which is used to display in the cell to avoid crash  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(NSString *)returnString1:(NSString *)apppoinmenttime salutaion:(NSString *)salutation firstName:(NSString *)firstName middleName:(NSString *)middleName lastName:(NSString *)lastName // For Appointments
{
    // *** convert json date to actual date
    apppoinmenttime = [apppoinmenttime stringByReplacingOccurrencesOfString:@"0530" withString:@"0000"];
    
    if(![apppoinmenttime isEqualToString:@""]&&apppoinmenttime!=nil) {
        NSDate* date=[self mfDateFromDotNetJSONString:apppoinmenttime];
        NSDateFormatter *mFormatter_ = [NSDateFormatter new];
        [mFormatter_ setDateFormat:TimeFormatApp];
        apppoinmenttime= [mFormatter_ stringFromDate:date];
    }
    firstName = (firstName!=nil)?firstName:@"";
    lastName = (lastName!=nil)?lastName:@"";
    salutation =  (salutation!=nil)?salutation:@"";
    middleName = (middleName!=nil)?middleName:@"";
    apppoinmenttime = (apppoinmenttime!=nil)?apppoinmenttime:@"";
    NSString *returnStr=@"";
    returnStr = [NSString stringWithFormat:@"%@ %@ %@ %@",salutation,firstName,middleName,lastName];
    returnStr = [returnStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return returnStr;
}

//--------------------------------------------------- ************** ------------------------------------------------------
//            *** this method is used to return the string which is used to display in the cell to avoid crash  ***
//--------------------------------------------------- ************** ------------------------------------------------------

-(NSString *)returnString2:(NSString *)vehicleYear make:(NSString *)make model:(NSString *)model
{
    vehicleYear = (vehicleYear!=nil&&[vehicleYear length]>0)?[NSString stringWithFormat:@"%@ ",vehicleYear]:@"";
    make = (make!=nil&&[make length]>0)?[NSString stringWithFormat:@"%@ ",make]:@"";
    model = (model!=nil&&[model length]>0)?[NSString stringWithFormat:@"%@ ",model]:@"";
    model = [model stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
    
    NSString *returnStr=@"";
        returnStr = [NSString stringWithFormat:@"%@%@%@",vehicleYear,make,model];
    return returnStr;
}

//--------------------------------------------------- ************** ------------------------------------------------------
//            *** this method is used to return the string(includes RONumber,Salutation,FirstName,LastName & MiddleName) which is used to display in the cell to avoid crash  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(NSString *)returnString3:(NSString *)RONumber salutaion:(NSString *)salutation firstName:(NSString *)firstName middleName:(NSString *)middleName lastName:(NSString *)lastName // For In-process
{
        RONumber = (RONumber!=nil)?RONumber:@"";
    firstName = (firstName!=nil)?firstName:@"";
    lastName = (lastName!=nil)?lastName:@"";
    salutation =  (salutation!=nil)?salutation:@"";
    middleName = (middleName!=nil)?middleName:@"";
    NSString *returnStr=@"";
    returnStr = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",RONumber,salutation,firstName,middleName,lastName];

    return returnStr;
}

- (NSDate *)mfDateFromDotNetJSONString:(NSString *)string {
    static NSRegularExpression *dateRegEx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateRegEx = [[NSRegularExpression alloc] initWithPattern:@"^\\/date\\((-?\\d++)(?:([+-])(\\d{2})(\\d{2}))?\\)\\/$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    NSTextCheckingResult *regexResult = [dateRegEx firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    if (regexResult) {
        // milliseconds
        NSTimeInterval seconds = [[string substringWithRange:[regexResult rangeAtIndex:1]] doubleValue] / 1000.0;
        // timezone offset
        if ([regexResult rangeAtIndex:2].location != NSNotFound) {
            NSString *sign = [string substringWithRange:[regexResult rangeAtIndex:2]];
            // hours
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:3]]] doubleValue] * 60.0 * 60.0;
            // minutes
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:4]]] doubleValue] * 60.0;
        }
        
        return [NSDate dateWithTimeIntervalSince1970:seconds];
    }
    return nil;
}

//--------------------------------------------------- ************** ------------------------------------------------------
//               *** This method is used to update the in-proces list data/ customer search ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)refreshAppointmentOrInprocessData {
        
        if(mselectedSegment_==2) { // in-Process
                [[SearchSupportWebEngine sharedInstance] threadRequestToGetRepairOrders];
            }else if (mselectedSegment_ == 3) { // OpenRO's
                [[SearchSupportWebEngine sharedInstance] threadRequestToGetRepairOrders];
            }
         else { // walk-in customer
             if ([mAppdelegate_.mViewReference_ isKindOfClass:[SearchedListTableView class]]) {
                 [self.mSearhBar_ setText:mAppdelegate_.mModelForEditCustomerScreen_.mFirstName_];
                 [[SearchSupportWebEngine sharedInstance] threadRequestForSearchCustomerInfo:mAppdelegate_.mModelForEditCustomerScreen_.mFirstName_];
             }else {
                 mAppdelegate_.mViewReference_ = self;
                 [[SearchSupportWebEngine sharedInstance] threadRequestForSearchCustomerInfo:mSearhBar_.text];
             }
        }
}

//--------------------------------------------------- ************** ------------------------------------------------------
//   *** this methods make wheather to have customer search or not and for the appointment case the searched customer may be in the appointment, if there in the appointment then show from appointment list ***
//--------------------------------------------------- ************** ------------------------------------------------------
- (void)showSearchlistViewOrHide:(int)showOrhide searchText:(NSString *)searchText {
    if(showOrhide==1){// '1' search list
        mselectedSegment_ = 0; // made 0...because this is useful while adding a new customer
        [self.mSearchedListTableView_ resetData];
        self.mAppointmentAndInprocessTableView_.hidden=YES;
        [self.mAppointmentAndInprocessTableView_ reloadData];
        [mAppdelegate_.mSearchViewController_.mCustomerInfoView_ setHidden:TRUE];
        [mAppdelegate_.mSearchViewController_.mVehicleInfoView_ setHidden:TRUE];
        [mAppdelegate_.mSearchViewController_.mVehicleHistoryView_ setHidden:TRUE];
        [self.mOpenROTableView_ setHidden:TRUE];
        [self.mOpenROFilterButton_ setHidden:TRUE];
        [mAppdelegate_.mSearchCustomerInfoView_.view setHidden:FALSE];
        [mAppdelegate_.mSearchVehicleInfoView_.view setHidden:FALSE];
        for (UIView *btnview in self.view.subviews)  {
            if([btnview isKindOfClass:[UIButton class]]) {
                [(UIButton *)btnview setSelected:NO];
                [(UIButton *)btnview setBackgroundColor:[UIColor clearColor]];
                if (((UIButton *)btnview).tag !=50) {
                    UIButton *lbtn = (UIButton *)btnview;
                    lbtn.titleLabel.textColor = [UIColor ASRProBlueColor];
                }
                [(UIButton *)btnview setEnabled:NO];
                [self.mRefreshBtn_ setEnabled:NO];
            }
        }
    }else {// '0' appointment list
        self.mSearchedListTableView_.hidden=YES;
        self.mAppointmentAndInprocessTableView_.hidden=NO;
        [mAppdelegate_.mSearchViewController_.mCustomerInfoView_ setHidden:FALSE];
        [mAppdelegate_.mSearchViewController_.mVehicleInfoView_ setHidden:FALSE];
        [mAppdelegate_.mSearchViewController_.mVehicleHistoryView_ setHidden:FALSE];
        [mAppdelegate_.mSearchViewController_.mContinueBtn_ setHidden:TRUE];
        [mAppdelegate_.mSearchCustomerInfoView_.view setHidden:TRUE];
        [mAppdelegate_.mSearchVehicleInfoView_.view setHidden:TRUE];
        for (UIView *btnview in self.view.subviews)  {
            if([btnview isKindOfClass:[UIButton class]]) {
                if (searchText.length>0) {
                    [(UIButton *)btnview setEnabled:NO];
                    [self.mRefreshBtn_ setEnabled:NO];
                        [(UIButton *)btnview setSelected:NO];
                        [(UIButton *)btnview setEnabled:NO];
                }else {
                    if (((UIButton *)btnview).tag !=50)
                        [(UIButton *)btnview setEnabled:YES];
                    [self.mRefreshBtn_ setEnabled:YES];
                    if(((UIButton *)btnview).tag == 2){
                        [(UIButton *)btnview setSelected:YES];
                        [(UIButton *)btnview setBackgroundColor: [UIColor ASRProBlueColor]];
                        mselectedSegment_ = 2;
                    }else
                        [(UIButton *)btnview setSelected:NO];
                }
            }
        }
        if([searchText length]>0) { // show searched appoinments
        }
    }
    [self appointmentORCustomerSearchScreen];
}

// to make the screen empty for cases search or when no row is selected
-(void)appointmentORCustomerSearchScreen {
    
    if(!self.mAppointmentAndInprocessTableView_.hidden){//appointment case
        [self.mAppointmentAndInprocessTableView_ reloadData];
    } else if (!self.mSearchedListTableView_.hidden){ // customer search case
        mAppdelegate_.mSearchDataGetter_.mSearchedCustomerListData_ = nil;
        [self.mSearchedListTableView_ reloadData];
    }
    
}

- (void)postRequestToGetRepairOrders {

    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        [mAppdelegate_.mRequestMethods_ getRepairOrders];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

-(void)requestForCustomerSearch:(NSString *)searchValue  {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        [mAppdelegate_.mRequestMethods_ searchCustomerInformation:searchValue];
        
    } else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
    
}

- (void)setRequestforVehicleHistory {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        [mAppdelegate_.mRequestMethods_ getRequestForVehicleHistory:mAppdelegate_.mModelForSplashScreen_.mStoreID_ CustomerID:mAppdelegate_.mModelForEditCustomerScreen_.mCustomerID_ VehicleID:mAppdelegate_.mModelForEditVehicleScreen_.mVehicleID_];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

#pragma mark -  ***************** TableView Delegate methods ****************
#pragma mark -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return KROWHEIGHT;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  [mAppdelegate_.mSearchDataGetter_.mInprocessListData_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        int tagCount = 1;
        for (; tagCount <= 2; tagCount++) {
            UILabel *lUILabel=[[UILabel alloc]init];
            [lUILabel setBackgroundColor:[UIColor clearColor]];
            [lUILabel setHighlightedTextColor:[UIColor whiteColor]];
            [lUILabel setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
            if (tagCount == 1) {
                [lUILabel setFont:[UIFont systemFontOfSize:13.0]];
            }else
                [lUILabel setFont:[UIFont systemFontOfSize:12.0]];
            
            [lUILabel setTag:tagCount];
            [cell.contentView addSubview:lUILabel];
        }
        
        UIView *lSelectedView_ = [[UIView alloc] init];
        lSelectedView_.backgroundColor =[UIColor colorWithRed:229/255.0 green:125/255.0 blue:37/255.0 alpha:1.0f];
        cell.selectedBackgroundView = lSelectedView_;
        
    }
    [self resetTableViews:cell];
    [self populateFormsSectionWithIndexPath:indexPath cell:cell tableView:tableView];
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    mAppdelegate_.mModelForWalkAround_.mPRE_RONumber = @"";
    mAppdelegate_.mWalkAroundViewController_ = nil;
    mAppdelegate_.mCheckInViewController_ = nil;
    [mAppdelegate_.mSearchViewController_.mVehicleHistory_ setHidden:TRUE];
        self.mselectedInprocessindex_=indexPath.row;
        [mAppdelegate_.mModelForWalkAround_ setMTempPRE_RONumber:[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"RONumber"]];
        mAppdelegate_.mModelForEditCustomerScreen_.mRONumber_ = [[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"RONumber"];
        [self onSelectionOfInProcess];
}

#pragma mark --
#pragma mark Table Sections Populate methods

- (void)resetTableViews:(UITableViewCell*)tableViewCell  {
    int tagCount = 1;
	// reset UILabels;
	for (; tagCount <= 2; tagCount ++) {
        UILabel *lUILabel = (UILabel*)[tableViewCell viewWithTag:tagCount];
        lUILabel.text = nil;
	}
}

- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView  {
    
    //----- local coordinates for setting frames of the internal UI Elements -----
    
    CGFloat xCoord = 15, yCoord = 5;
    
    // ----------------------------;
    // To display time and customer name for labels;
    // ----------------------------;
    
//    UILabel *lTimeLabel = (UILabel*)[tableViewCell.contentView viewWithTag:1];
//    [lTimeLabel setFrame:CGRectMake(xCoord, yCoord, 60, 18)];
//    [lTimeLabel setText:@"10:00am"];
//    xCoord += lTimeLabel.frame.size.width + 3;
    UILabel *lTimeAndCustomerNameLabel = (UILabel*)[tableViewCell.contentView viewWithTag:1];
    [lTimeAndCustomerNameLabel setFrame:CGRectMake(xCoord, yCoord, 280, 18)];
    [lTimeAndCustomerNameLabel setText:[NSString stringWithFormat:@"%@",[self returnString3:[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"RONumber"] salutaion:[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"Salutation"] firstName:[[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"Customer"] objectForKey:@"FirstName"] middleName:[[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"Customer"] objectForKey:@"MiddleName"] lastName:[[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"Customer"] objectForKey:@"LastName"]]]];
    xCoord = 15.0;
    yCoord += lTimeAndCustomerNameLabel.frame.size.height + 1;
    // ----------------------------;
    // To display year,make and model for labels;
    // ----------------------------;
    
    UILabel *lYearMakeModelLabel = (UILabel*)[tableViewCell.contentView viewWithTag:2];
    [lYearMakeModelLabel setFrame:CGRectMake(xCoord, yCoord, 300, 18)];
    [lYearMakeModelLabel setText:[NSString stringWithFormat:@"%@",[self returnString2:[[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"Vehicle"] objectForKey:@"Year"] make:[[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"Vehicle"] objectForKey:@"Make"] model:[[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"Vehicle"] objectForKey:@"Model"]]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --
#pragma mark OpenRO DropDown Methods
- (IBAction)OpenROFilterButtonAction:(id)sender {
    NSMutableArray * openROModesArray = [[NSMutableArray alloc] initWithObjects:@"All",@"Dispatch",@"Inspection",@"Approval",@"Repair",@"Review", nil];
    if(self.mOpenRODropDownView_ == nil) {
        CGFloat heightForTableView = [openROModesArray count] * 26;
        self.mOpenRODropDownView_ = [[OpenRODropDownView alloc] showOpenRODropDown:sender Height:&heightForTableView Array:openROModesArray Direction:@"down"];
        self.mOpenRODropDownView_.delegate = self;
        [self.mOpenROTableView_ setUserInteractionEnabled:FALSE];
    }
    else {
        [self.mOpenRODropDownView_ hideOpenRODropDown:sender];
        [self opnORDropDownNil];
    }
}

- (void)OpenRODropDownDelegateMethod:(OpenRODropDownView *)sender{
    [self opnORDropDownNil];
}

-(void)opnORDropDownNil {
    self.mOpenRODropDownView_  = nil;
    [self.mOpenROTableView_ setUserInteractionEnabled:TRUE];
}

#pragma mark TouchEvent
- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
    // some custom code to process a specific touch
    [self.mOpenRODropDownView_ hideOpenRODropDown:self.mOpenROFilterButton_];
    [self opnORDropDownNil];
}

@end
