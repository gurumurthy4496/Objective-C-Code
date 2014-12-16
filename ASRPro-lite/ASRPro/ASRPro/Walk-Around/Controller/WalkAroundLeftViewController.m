//
//  WalkAroundLeftViewController.m
//  ASRPro
//
//  Created by GuruMurthy on 31/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "WalkAroundLeftViewController.h"
#define kCustomerROInfoTableViewRowHeight 24

@interface WalkAroundLeftViewController () {
    AppDelegate *mAppDelegate_;
    int declinedLinesCount_;
    int approvedLinesCount_;
}
- (void)setFontsAndTextToROModesScreen;
@property (nonatomic, readwrite) int mCurrentSelectedRow_;

@end

@implementation WalkAroundLeftViewController

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
    [self initializationOfObjectsForCustomerInformationTableView];
    [self setFontsAndTextToROModesScreen];
}

- (void)viewWillAppear:(BOOL)animated {
    declinedLinesCount_ = 1;
    approvedLinesCount_ = 1;
    [self initDataForCustomerROInformationTableView];
}

- (void)initializationOfObjectsForCustomerInformationTableView {
    
    [self.navigationController setNavigationBarHidden:YES];
    
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    
    self.mCurrentSelectedRow_ = 0;
    
    [mAppDelegate_ mModelForVehicleHistory_].mVehicleHistoryArray_ = nil;
    
    [mAppDelegate_ mModelForVehicleHistory_].mRODetailsArray_ = nil;
}

- (void)setFontsAndTextToROModesScreen {
    [self.mCustomerROInformationTableView_ setBackgroundColor:[UIColor ASRProRGBColor:66 Green:66 Blue:68]];
}

- (void)initDataForCustomerROInformationTableView {
    
    
    if (self.mShowVehicleHistoryForOpenRO_ == ShowVehicleHistoryForOpenROSection) {
        [mAppDelegate_ mModelForVehicleHistory_].mVehicleHistoryArray_ = [mAppDelegate_.mModelForVehicleHistoryTableView_.mVehicleHistoryArray_ mutableCopy];
        DLog(@"%@",mAppDelegate_.mModelForVehicleHistoryTableView_.mVehicleHistoryArray_);

//        [mAppDelegate_ mModelForVehicleHistory_].mRODetailsArray_ = [mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ mutableCopy];
    }else {
        [mAppDelegate_ mModelForVehicleHistory_].mVehicleHistoryArray_ = [mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_ mutableCopy];
        
        [mAppDelegate_ mModelForVehicleHistory_].mRODetailsArray_ = [mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ mutableCopy];
    }
    
    [[mAppDelegate_ mModelForVehicleHistory_] setRoAndCustomerInformation];
    
    [self.mCustomerROInformationTableView_ reloadData];
    
    // Hiding empty seperatores in ROModes List TableView;
    
    [[SharedUtilities sharedUtilities] hideEmptySeparators:self.mCustomerROInformationTableView_];
    
}

#pragma mark --
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[mAppDelegate_ mModelForVehicleHistory_].mCustomerRoInformationLeftSideStaticNamesArray_ count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *lSectionName = @"";
    switch (section) {
        case 0:
            lSectionName = kROInformation;
            break;
        case 1:
            lSectionName = kCustomerInformation;
            break;
        case 2:
            lSectionName = kVehicleHistory;
            break;
        default:
            break;
    }
    NSMutableArray* lTempArray=[[[mAppDelegate_ mModelForVehicleHistory_].mCustomerRoInformationLeftSideStaticNamesArray_ objectAtIndex:section] objectForKey:lSectionName];

    int lRowCount = [lTempArray count];
    return lRowCount;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    CGFloat lSelectedRowHeight = 0;
    UIView *lExpandView;
    if (indexPath.section == 2) {
        NSMutableArray* lTempArray=[[[[[mAppDelegate_ mModelForVehicleHistory_].mCustomerRoInformationLeftSideStaticNamesArray_ objectAtIndex:indexPath.section] objectForKey:kVehicleHistory] objectAtIndex:indexPath.row] valueForKey:@"RepairOrderLines"];

        if ([lTempArray count]>0) {
            lExpandView = (UIView *)[self methodForReturnExpandedViewServicesArray:[[[[[mAppDelegate_ mModelForVehicleHistory_].mCustomerRoInformationLeftSideStaticNamesArray_ objectAtIndex:indexPath.section] objectForKey:kVehicleHistory] objectAtIndex:indexPath.row] valueForKey:@"RepairOrderLines"] :nil];
            lSelectedRowHeight = lExpandView.frame.size.height;
            if (indexPath.row == self.mCurrentSelectedRow_) {
                return (kCustomerROInfoTableViewRowHeight + lSelectedRowHeight);
            }
        }
    }
    return kCustomerROInfoTableViewRowHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, tableView.frame.size.width, 21)];
    [label setFont:[UIFont boldFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
    [label setTextColor:[UIColor blackColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    NSString *lSectionTitle = @"";
    if (section == 0)
        lSectionTitle = kROInformation;
    else if (section == 1)
        lSectionTitle = kCustomerInformation;
    else if (section == 2)
        lSectionTitle = kVehicleHistory;
    
    [label setText:lSectionTitle];
    [view addSubview:label];
    RELEASE_NIL(label);
    [view setBackgroundColor:[UIColor whiteColor]]; //your background color...
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    cell = nil;
    int tagCount = 1;
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //Configure cell format for the tableView,
        //Same format for all the three sections.
        [cell setBackgroundColor:[UIColor clearColor]];
        
        
        UILabel *lStaticTextUILabel=[[UILabel alloc]init];
        [lStaticTextUILabel setBackgroundColor:[UIColor clearColor]];
        [lStaticTextUILabel setTextColor:[UIColor whiteColor]];
        [lStaticTextUILabel setFont:[UIFont regularFontOfSize:14.0f fontKey:kFontNameHelveticaNeueKey]];
        [lStaticTextUILabel setHighlightedTextColor:[UIColor whiteColor]];
        [lStaticTextUILabel setTag:tagCount];
        [cell.contentView addSubview:lStaticTextUILabel];
        RELEASE_NIL(lStaticTextUILabel);
        
        UILabel *lUILabel=[[UILabel alloc]init];
        [lUILabel setBackgroundColor:[UIColor clearColor]];
        [lUILabel setTextColor:[UIColor whiteColor]];
        [lUILabel setFont:[UIFont regularFontOfSize:14.0f fontKey:kFontNameHelveticaNeueKey]];
        [lUILabel setHighlightedTextColor:[UIColor whiteColor]];
        [lUILabel setTag:tagCount + 1];
        [cell.contentView addSubview:lUILabel];
        RELEASE_NIL(lUILabel);
        
        UIImageView *lUIImageView = [[UIImageView alloc]init];
        [lUIImageView setBackgroundColor:[UIColor clearColor]];
        [lUIImageView setTag:tagCount + 2];
        [cell.contentView addSubview:lUIImageView];
        RELEASE_NIL(lUIImageView);
        
        /*UIView *lSelectedView_ = [[[UIView alloc] init] autorelease];
         lSelectedView_.backgroundColor =[UIColor ASRProSelectedTableViewCellColor];
         cell.selectedBackgroundView = lSelectedView_;*/
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if (indexPath.section == 2) {
        if (indexPath.row == self.mCurrentSelectedRow_) {
            UIView *lExpandView_ = [[UIView alloc] init];
            lExpandView_.backgroundColor =[UIColor whiteColor];
            lExpandView_.tag = tagCount + 3;
            [cell.contentView addSubview:lExpandView_];
            RELEASE_NIL(lExpandView_);
        }
    }
    [self resetTableViews:cell indexPath:indexPath];
    [self populateFormsSectionWithIndexPath:indexPath cell:cell tableView:tableView];
    
    return cell;
}

/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 NSString *lSectionTitle = @"";
 return lSectionTitle;
 }*/


#pragma mark --
#pragma mark Table Sections Populate methods

- (void)resetTableViews:(UITableViewCell*)tableViewCell indexPath:(NSIndexPath*)indexPath {
    int tagCount = 1;
    
	// reset UILabels;
    UILabel *lStaticTextUILabel = (UILabel *)[tableViewCell viewWithTag:tagCount];
    lStaticTextUILabel.text = @"";
    
    UILabel *lUILabel = (UILabel *)[tableViewCell viewWithTag:tagCount + 1];
    lUILabel.text = @"";
    
    UIImageView *lUIImageView = (UIImageView *)[tableViewCell viewWithTag:tagCount + 2];
    [lUIImageView setImage:nil];
    if (indexPath.section == 2) {
        if (self.mCurrentSelectedRow_ != NSNotFound ) {
            UIView *lExpandView_ =(UIView *)[tableViewCell viewWithTag:tagCount + 3];
            [lExpandView_ setFrame:CGRectMake(0,0,0,0)];
        }
    }
}

- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView  {
    
    //----- local coordinates for setting frames of the internal UI Elements -----
    NSString *lSectionName = @"";
    switch (indexPath.section) {
        case 0:
            lSectionName = kROInformation;
            break;
        case 1:
            lSectionName = kCustomerInformation;
            break;
        case 2:
            lSectionName = kVehicleHistory;
            break;
        default:
            break;
    }
    
    CGFloat xCoord = 15, yCoord = 0,  height = kCustomerROInfoTableViewRowHeight;
    
    int tagCount = 1;
    
    // ----------------------------;
    // To Static text for UILabel based on section;
    // ----------------------------;
    
    
    
    UILabel *lStaticTextUILabel = (UILabel*)[tableViewCell.contentView viewWithTag:tagCount];
    
    if (indexPath.section == 2) {
        NSString *RONumber = [[[[[mAppDelegate_ mModelForVehicleHistory_].mCustomerRoInformationLeftSideStaticNamesArray_ objectAtIndex:indexPath.section]objectForKey:lSectionName] objectAtIndex:indexPath.row] valueForKey:@"RONumber"];
        
        CGSize lExpectedLabelSize = [RONumber sizeWithFont:[UIFont regularFontOfSize:14.0f fontKey:kFontNameHelveticaNeueKey]];
        
        [lStaticTextUILabel setFrame:CGRectMake(xCoord, yCoord, lExpectedLabelSize.width, height)];
        [lStaticTextUILabel setText:RONumber];
        
    }else {
        CGSize expectedLabelSize = [[[[[mAppDelegate_ mModelForVehicleHistory_].mCustomerRoInformationLeftSideStaticNamesArray_ objectAtIndex:indexPath.section] objectForKey:lSectionName] objectAtIndex:indexPath.row] sizeWithFont:[UIFont regularFontOfSize:14.0f fontKey:kFontNameHelveticaNeueKey]];
        [lStaticTextUILabel setFrame:CGRectMake(xCoord, yCoord, 150, height)];
        lStaticTextUILabel = (UILabel*)[tableViewCell.contentView viewWithTag:tagCount];
        [lStaticTextUILabel setFrame:CGRectMake(xCoord, yCoord, expectedLabelSize.width, height)];
        [lStaticTextUILabel setText:[NSString stringWithFormat:@"%@",[[[[mAppDelegate_ mModelForVehicleHistory_].mCustomerRoInformationLeftSideStaticNamesArray_ objectAtIndex:indexPath.section] objectForKey:lSectionName] objectAtIndex:indexPath.row]]];
    }
    
    // ----------------------------;
    // To data for UILabel based on section(Section 2 for VehicleHistory);
    // ----------------------------;
    
    UILabel *lUILabel = (UILabel*)[tableViewCell.contentView viewWithTag:tagCount+1];
    [lUILabel setFrame:CGRectMake(150, yCoord, 150, height)];
    
    if (indexPath.section == 2) {
        NSDate *CreateDate = [[SharedUtilities sharedUtilities] dateFromDotNetJSONString:[[[[[mAppDelegate_ mModelForVehicleHistory_].mCustomerRoInformationLeftSideStaticNamesArray_ objectAtIndex:indexPath.section]objectForKey:lSectionName] objectAtIndex:indexPath.row] valueForKey:@"CreateDate"]];
        
        NSDateFormatter *lDateFormatter = [[NSDateFormatter alloc] init];
        [lDateFormatter setDateFormat:@"MM-dd-yyyy"];
        NSString *CreateDateString = [lDateFormatter stringFromDate:CreateDate];
        
        [lUILabel setFrame:CGRectMake(140, yCoord, 140, height)];
        NSString *lTempCreatedDate = (CreateDateString != nil) ? CreateDateString :@"";
        [lUILabel setText:[NSString stringWithFormat:@"%@",lTempCreatedDate]];
        [lUILabel setTextAlignment:NSTextAlignmentRight];
        if ([[[[[[mAppDelegate_ mModelForVehicleHistory_].mCustomerRoInformationLeftSideStaticNamesArray_ objectAtIndex:indexPath.section]objectForKey:lSectionName] objectAtIndex:indexPath.row] valueForKey:@"CurrentMode"] integerValue] != 100) {
            
            NSString *lCurrentDateStr = ([lTempCreatedDate isEqualToString:@""])?@"":NSLocalizedString(@"lCurrentlyOpenRO", @"lCurrentlyOpenRO");
            
            [lUILabel setText:lCurrentDateStr];
            [lUILabel setTextColor:[UIColor ASRProCustomAlertSelectedStateColor]];
        }
    }else {//Display Customer and RO Info.
        [lUILabel setText:[NSString stringWithFormat:@"%@",[[[[[mAppDelegate_ mModelForVehicleHistory_].mCustomerRoInformationArray_ objectAtIndex:indexPath.section] objectForKey:lSectionName] objectAtIndex:0] objectForKey:[[[[mAppDelegate_ mModelForVehicleHistory_].mCustomerRoInformationLeftSideStaticNamesArray_ objectAtIndex:indexPath.section] objectForKey:lSectionName] objectAtIndex:indexPath.row]]]];
        [lUILabel setTextColor:[UIColor whiteColor]];
        [lUILabel setTextAlignment:NSTextAlignmentLeft];
    }
    
    // ----------------------------;
    // To Display discloser for UIImageView based on section;
    // ----------------------------;
    UIImage *lArrowRightImage = [UIImage imageNamed:@"arrowright"];
    UIImage *lArrowDownimage = [UIImage imageNamed:@"arrowdown"];
    
    UIImageView *lDiscloserImageview = (UIImageView *) [tableViewCell.contentView viewWithTag:tagCount+2];
    
    if (indexPath.section == 0) {
        [lDiscloserImageview setHidden:TRUE];
    }else if (indexPath.section == 1){
        [lDiscloserImageview setHidden:TRUE];
    }else if (indexPath.section == 2){
        NSMutableArray* lTempArray=[[[[[mAppDelegate_ mModelForVehicleHistory_].mCustomerRoInformationLeftSideStaticNamesArray_ objectAtIndex:indexPath.section] objectForKey:kVehicleHistory] objectAtIndex:indexPath.row] valueForKey:@"RepairOrderLines"];

        if ([lTempArray count]>0) {
            if (indexPath.row == self.mCurrentSelectedRow_) {
                [lDiscloserImageview setFrame:CGRectMake(lUILabel.frame.origin.x + lUILabel.frame.size.width + 20, (kCustomerROInfoTableViewRowHeight - lArrowDownimage.size.height)/2, lArrowDownimage.size.width, lArrowDownimage.size.height)];
                [lDiscloserImageview setImage:lArrowDownimage];
            }else {
                [lDiscloserImageview setFrame:CGRectMake(lUILabel.frame.origin.x + lUILabel.frame.size.width + 20 , (kCustomerROInfoTableViewRowHeight - lArrowRightImage.size.height)/2,  lArrowRightImage.size.width, lArrowRightImage.size.height)];
                [lDiscloserImageview setImage:lArrowRightImage];
            }
            [lDiscloserImageview setHidden:FALSE];
        } else
            [lDiscloserImageview setHidden:TRUE];
    }
    
    // ----------------------------;
    // Expand View(Vehicle History);
    // ----------------------------;
    if (indexPath.section == 2) {
        if (indexPath.row == self.mCurrentSelectedRow_) {
            UIView *lExpandView = (UIView *)[tableViewCell.contentView viewWithTag:tagCount + 3];
            [lExpandView setHidden:NO];
            lExpandView = [self methodForReturnExpandedViewServicesArray:[[[[[mAppDelegate_ mModelForVehicleHistory_].mCustomerRoInformationLeftSideStaticNamesArray_ objectAtIndex:indexPath.section] objectForKey:kVehicleHistory] objectAtIndex:indexPath.row] valueForKey:@"RepairOrderLines"] :lExpandView];
            DLog(@"%@",lExpandView);
        }else {
            UIView *lExpandView = (UIView *)[tableViewCell.contentView viewWithTag:tagCount + 3];
            [lExpandView setHidden:YES];
        }
    }
}

#pragma mark --
#pragma mark  Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
    }
    else if (indexPath.section == 1) {
        
    }else {
        [self.mCustomerROInformationTableView_ scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        if (self.mCurrentSelectedRow_ == indexPath.row) {
            self.mCurrentSelectedRow_ = NSNotFound;
        }else {
            self.mCurrentSelectedRow_ = indexPath.row;
        }
        [self.mCustomerROInformationTableView_ reloadData];
        NSIndexPath *lIndexPath = [NSIndexPath indexPathForRow:0 inSection:2];
        
        [tableView scrollToRowAtIndexPath:lIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (UIView *)methodForReturnExpandedViewServicesArray:(NSArray *)aServicesArray :(UIView *)aExpandView {
    [aExpandView.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        [object removeFromSuperview];
    }];
    
    __block UIView *lView = [[UIView alloc] init];
    
    if (aServicesArray != nil) {
        CGFloat xCoord = 0, yCoord = kCustomerROInfoTableViewRowHeight, width = self.mCustomerROInformationTableView_.frame.size.width, height = 0;
        [lView setFrame:CGRectMake(xCoord, yCoord, width, height)];
        [lView setBackgroundColor:[UIColor whiteColor]];
        
        // ----------------------------;
        // To display RO# and CurrentDate for labels;
        // ----------------------------;
        __block CGFloat yPosition = 0;
        [aServicesArray enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            //Services Label
            UILabel *lServiceNameLabel = [[UILabel alloc] init];
            [lServiceNameLabel setBackgroundColor:[UIColor clearColor]];
            [lServiceNameLabel setFrame:CGRectMake(15, yPosition, 200, 45)];
            [lServiceNameLabel setFont:[UIFont regularFontOfSize:12.0f fontKey:kFontNameHelveticaNeueKey]];
            [lServiceNameLabel setNumberOfLines:2];
            [lServiceNameLabel setLineBreakMode:NSLineBreakByCharWrapping];
            
            if ([[object objectForKey:@"Declined"] boolValue] == TRUE) {
                [lServiceNameLabel setText:[NSString stringWithFormat:@"Declined Line %d: %@ - %@",approvedLinesCount_,[[object objectForKey:@"PayTypeCode"] objectForKey:@"Code"],[object objectForKey:@"ServiceName"]]];
                [lServiceNameLabel setTextColor:[UIColor redColor]];
                [lServiceNameLabel setHighlightedTextColor:[UIColor redColor]];
                declinedLinesCount_++;
            }else {
                [lServiceNameLabel setText:[NSString stringWithFormat:@"Line %d: %@ - %@",declinedLinesCount_,[[object objectForKey:@"PayTypeCode"] objectForKey:@"Code"],[object objectForKey:@"ServiceName"]]];
                [lServiceNameLabel setTextColor:[UIColor blackColor]];
                [lServiceNameLabel setHighlightedTextColor:[UIColor blackColor]];
                approvedLinesCount_++;
            }
            
            
            
            //Price Label
            CGFloat lPriceLaborPartsTotal = [[object objectForKey:@"Price"] integerValue];//[[object  objectForKey:@"PriceLabor"] integerValue] + [[object objectForKey:@"PriceParts"] integerValue];
            
            NSString *lTotal = [NSString stringWithFormat:@"%2f",lPriceLaborPartsTotal];
            
            CGSize lTextWidth = [lTotal sizeWithFont:[UIFont regularFontOfSize:12.0f fontKey:kFontNameHelveticaNeueKey]];
            
            UILabel *lPriceLaborPartsTotalLabel = [[UILabel alloc] init];
            [lPriceLaborPartsTotalLabel setBackgroundColor:[UIColor clearColor]];
            [lPriceLaborPartsTotalLabel setFrame:CGRectMake(200 + 25, yPosition, lTextWidth.width, 45)];
            [lPriceLaborPartsTotalLabel setTextColor:[UIColor blackColor]];
            [lPriceLaborPartsTotalLabel setFont:[UIFont regularFontOfSize:10.0f fontKey:kFontNameHelveticaNeueKey]];
            [lPriceLaborPartsTotalLabel setText:[NSString stringWithFormat:@"$ %.2f",lPriceLaborPartsTotal]];
            
            if ([[object objectForKey:@"Declined"] boolValue] == TRUE) {
                CustomButtonForAddServicesWalkAround *button = [[CustomButtonForAddServicesWalkAround alloc] init];
                UIImage *image = [UIImage imageNamed:@"AddServices"];
                [button setBackgroundImage:image forState:UIControlStateNormal];
                [button setBackgroundImage:image forState:UIControlStateNormal];
                button.tag = index;
                button.mRepairOrderLinesDictionary_ = (NSMutableDictionary *)object;
                [button setFrame:CGRectMake(270, yPosition + (self.mCustomerROInformationTableView_.rowHeight - image.size.height)/2, image.size.width - 40, image.size.height)];
                [button addTarget:self action:@selector(addDeclinedServicesButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                [button setHidden:FALSE];
                [lView addSubview:button];
                [aExpandView addSubview:button];
            }
            
            yPosition  += 35;
            
            [lView addSubview:lServiceNameLabel];
            [lView addSubview:lPriceLaborPartsTotalLabel];
            [aExpandView addSubview:lServiceNameLabel];
            [aExpandView addSubview:lPriceLaborPartsTotalLabel];
        }];
        if ([aServicesArray count] >0) {
            //ExpandViewHeight
            CGRect lExpandViewFrame = lView.frame;
            lExpandViewFrame.size.height = yPosition+10;
            lView.frame = lExpandViewFrame;
            aExpandView.frame = lExpandViewFrame;
        }
    }
    if (aExpandView != nil) {
        return aExpandView;
    }
    return lView;
}

- (IBAction)addDeclinedServicesButtonAction:(CustomButtonForAddServicesWalkAround *)sender {
  
    NSMutableDictionary* lTempDict = sender.mRepairOrderLinesDictionary_;
    [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForServiceRequestWebEngine_ setMGetServiceReference_:VEHICLEHISTORYSERVICES];
    [[[SharedUtilities sharedUtilities]appDelegateInstance].mServiceDataGetter_.mModelForSelectedService_ saveAddDictToModel:lTempDict];
    [mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_ convertModelToDict];

    [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForServiceRequestWebEngine_ RequestToAddService:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ ServiceDict:[[NSDictionary dictionaryWithObjectsAndKeys:[lTempDict objectForKey:KSGCID],KSGCID, nil] mutableCopy]];
    
}

#pragma mark --
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation CustomButtonForAddServicesWalkAround
@synthesize mRepairOrderLinesDictionary_;
@end



