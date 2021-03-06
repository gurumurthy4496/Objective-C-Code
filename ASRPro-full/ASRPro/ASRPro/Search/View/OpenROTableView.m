//
//  OpenROTableView.m
//  ASRPro
//
//  Created by Santosh Kvss on 1/31/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "NetworkMonitor.h"
#import "OpenROTableView.h"
#define KRowHeight 106

#define REFRESH_HEADER_HEIGHT 52.0f

@implementation OpenROTableView

@synthesize textPull, textRelease, textLoading, refreshHeaderView, refreshLabel, refreshArrow, refreshSpinner;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//--------------------------------------------------- ************** ------------------------------------------------------
//  ** This method is used for making the delegates of 'mSearchListFromseverTableview_' to be called in the custom table **..
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)setDelegatesForSearchListTableview_ {
    self.dataSource=self;
    self.delegate=self;
    self->mAppDelegate_= [[SharedUtilities sharedUtilities] appDelegateInstance];

    self.rowHeight=KRowHeight;
    
    [self reloadData];
    [[SharedUtilities sharedUtilities] hideEmptySeparators:self];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + 27, self.frame.size.width, self.frame.size.height - 27)];
    
    
     [self setupStrings];
    [self addPullToRefreshHeader];

}

- (void)pushDataintoModalCustomerAndVehicleForApp:(int)index {
    
    mAppDelegate_.mModelForSearchScreen_.mAppointmentID_ = [[mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:index] objectForKey:@"ID"];
    mAppDelegate_.mModelForSearchScreen_.mAdvisorID_ = [[mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:index] objectForKey:@"AdvisorID"];
        [mAppDelegate_.mModelForEditCustomerScreen_ setValues:(NSMutableDictionary*)[[mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:index] objectForKey:@"Customer"]];
        [mAppDelegate_.mModelForEditVehicleScreen_ setValues:(NSMutableDictionary*)[[mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:index] objectForKey:@"Vehicle"]];
}

- (void)onSelectionOfOpenRO:(int)index {
    mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ = [[mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:index] objectForKey:@"RONumber"];
    //Setting the RONumber in the header.
    [[mAppDelegate_.mSearchViewController_.view subviews] enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        UIView *view = (UIView *)object;
        if (view.tag == 1) {
            __block UILabel *RONumberLabel;
            [view.subviews enumerateObjectsUsingBlock:^(id object1, NSUInteger index1, BOOL *stop1) {
                DLog(@"%@",object1);
                RONumberLabel = (UILabel *)object1;
                if ([object1 isKindOfClass:[UILabel class]]) {
                    if (RONumberLabel.tag == 102) {
                        [RONumberLabel setHidden:FALSE];
                        [RONumberLabel setText:[NSString stringWithFormat:@"RO# %@",mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_]];
                    }
                }
                
            }];
        }
    }];
    
    [self pushDataintoModalCustomerAndVehicleForApp:index];
    [mAppDelegate_.mSearchViewController_  enableOrdisableEditCustomerOrVehiclebtn];
    [mAppDelegate_.mSearchViewController_ setCustomerInfomationLabelsTextFromModel];
    if ([mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Technician"]) {
        if (!([[[mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:index] objectForKey:@"CurrentMode"] intValue] == 2)) {
            [mAppDelegate_.mSearchViewController_ setVehicleInfomationLabelsTextFromModel];
        }
    }else
        [mAppDelegate_.mSearchViewController_ setVehicleInfomationLabelsTextFromModel];
}

#pragma mark -  ***************** TableView Delegate methods ****************
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        int tagCount = 1;
        
        UIImageView *lImageView = [[UIImageView alloc] init];
        lImageView.tag = 7;
        [cell.contentView addSubview:lImageView];
        
        for (; tagCount <= 6; tagCount++) {
            UILabel *lUILabel=[[UILabel alloc]init];
            [lUILabel setBackgroundColor:[UIColor clearColor]];
            [lUILabel setHighlightedTextColor:[UIColor whiteColor]];
            [lUILabel setTextColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0]];
            if(tagCount ==1)
                [lUILabel setFont:[UIFont systemFontOfSize:15.0]];
            else
                [lUILabel setFont:[UIFont systemFontOfSize:13.0]];
            
            [lUILabel setTag:tagCount];
            [cell.contentView addSubview:lUILabel];
        }
        
        
        UIButton *lBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        lBtn.backgroundColor = [UIColor clearColor];
        [lBtn.titleLabel setHighlightedTextColor:[UIColor whiteColor]];
        lBtn.tag = tagCount+1;
        [cell.contentView addSubview:lBtn];
        UIView *lSelectedView_ = [[UIView alloc] init];
        lSelectedView_.backgroundColor =[UIColor colorWithRed:229/255.0 green:125/255.0 blue:37/255.0 alpha:1.0f];
        cell.selectedBackgroundView = lSelectedView_;
        
    }
    [self resetTableViews:cell];
    [self populateFormsSectionWithIndexPath:indexPath cell:cell tableView:tableView];
    cell.accessoryType=UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [mAppDelegate_.mMasterViewController_.mSearhBar_ endEditing:YES];
    self.mselectedCustomerindex_ = indexPath.row;
    [self onSelectionOfOpenRO:indexPath.row];
    [mAppDelegate_.mModelForVehicleHistoryTableView_ methodToShowAlertOrVehicleHistory:indexPath.row];
}

#pragma mark --
#pragma mark Table Sections Populate methods

- (void)resetTableViews:(UITableViewCell*)tableViewCell  {
    int tagCount = 1;
	// reset UILabels;
	for (; tagCount <= 5; tagCount ++) {
        UILabel *lUILabel = (UILabel*)[tableViewCell viewWithTag:tagCount];
        lUILabel.text = @"";
	}
}

- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView  {
    
    //----- local coordinates for setting frames of the internal UI Elements -----
    
    CGFloat xCoord = 20, yCoord = 10;
    
    // ----------------------------;
    // To display RONumber and customer name for labels;
    // ----------------------------;
    
    UILabel *lRONumberLabel = (UILabel*)[tableViewCell.contentView viewWithTag:1];
    [lRONumberLabel setFrame:CGRectMake(xCoord, yCoord, 200, 18)];
    [lRONumberLabel setText:[NSString stringWithFormat:@"RO#%@",[[mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:indexPath.row] objectForKey:@"RONumber"]]];
    yCoord += lRONumberLabel.frame.size.height;
    UILabel *lCustomerNameLabel = (UILabel*)[tableViewCell.contentView viewWithTag:2];
    [lCustomerNameLabel setFrame:CGRectMake(xCoord, yCoord, 250, 18)];
    [lCustomerNameLabel setText:[NSString stringWithFormat:@"%@",[mAppDelegate_.mMasterViewController_ returnString1:nil salutaion:[[[mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:indexPath.row] objectForKey:@"Customer"] objectForKey:@"Salutation"] firstName:[[[mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:indexPath.row] objectForKey:@"Customer"] objectForKey:@"FirstName"] middleName:[[[mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:indexPath.row] objectForKey:@"Customer"] objectForKey:@"MiddleName"] lastName:[[[mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:indexPath.row] objectForKey:@"Customer"] objectForKey:@"LastName"]]]];
    yCoord += lCustomerNameLabel.frame.size.height;
    // ----------------------------;
    // To display year,make and model for labels;
    // ----------------------------;
    
    UILabel *lYearMakeModelLabel = (UILabel*)[tableViewCell.contentView viewWithTag:3];
    [lYearMakeModelLabel setFrame:CGRectMake(xCoord, yCoord, 300, 18)];
    [lYearMakeModelLabel setText:[NSString stringWithFormat:@"%@",[mAppDelegate_.mMasterViewController_ returnString2:[[[mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:indexPath.row] objectForKey:@"Vehicle"] objectForKey:@"Year"] make:[[[mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:indexPath.row] objectForKey:@"Vehicle"] objectForKey:@"Make"] model:[[[mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:indexPath.row] objectForKey:@"Vehicle"] objectForKey:@"Model"]]]];
    yCoord += lYearMakeModelLabel.frame.size.height;
    UILabel *lAdvisorNamelLabel = (UILabel*)[tableViewCell.contentView viewWithTag:4];
    [lAdvisorNamelLabel setFrame:CGRectMake(xCoord, yCoord, 300, 18)];
    [lAdvisorNamelLabel setText:[NSString stringWithFormat:@"Advisor : %@",[mAppDelegate_.mModelForSearchScreen_ getAdvisorForOpenRO:[[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mOpenROListDisplayData_] objectAtIndex:indexPath.row] objectForKey:@"AdvisorID"] intValue]]]];
    yCoord += lAdvisorNamelLabel.frame.size.height;
    UILabel *lTechnicianNamelLabel = (UILabel*)[tableViewCell.contentView viewWithTag:5];
    [lTechnicianNamelLabel setFrame:CGRectMake(xCoord, yCoord, 300, 18)];
    [lTechnicianNamelLabel setText:[NSString stringWithFormat:@"Technician : %@",[mAppDelegate_.mModelForSearchScreen_ getTechnicianForOpenRO:[[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mOpenROListDisplayData_] objectAtIndex:indexPath.row] objectForKey:@"TechnicianID"] intValue]]]];
    
    UILabel *lROModeNamelLabel = (UILabel*)[tableViewCell.contentView viewWithTag:6];
    [lROModeNamelLabel setFrame:CGRectMake(lRONumberLabel.frame.size.width+20,lRONumberLabel.frame.origin.y, 74, 19)];
    [lROModeNamelLabel setBackgroundColor:[UIColor clearColor]];
    [lROModeNamelLabel setTextAlignment:NSTextAlignmentCenter];
    [lROModeNamelLabel setTextColor:[UIColor ASRProBlueColor]];
    [lROModeNamelLabel setHighlightedTextColor:[UIColor whiteColor]];
    
    
    UIImageView *lImageView = (UIImageView*)[tableViewCell.contentView viewWithTag:7];
    [lImageView setFrame:CGRectMake(lRONumberLabel.frame.size.width+20,lRONumberLabel.frame.origin.y, 74, 19)];
    UIImage *imageNormal = [UIImage imageNamed:@"ROMode"];
    UIImage *highlightedImage = [UIImage imageNamed:@"ROMode_Selected"];
    [lImageView setImage:imageNormal];
    [lImageView setHighlightedImage:highlightedImage];
    
    
    
    
    
    UIButton *lROModeBtn = (UIButton*)[tableViewCell.contentView viewWithTag:8];
    //    lROModeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    lROModeBtn.frame = CGRectMake(lRONumberLabel.frame.size.width+20,lRONumberLabel.frame.origin.y, 74, 19);
    lROModeBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [lROModeBtn.layer setBorderColor:[[UIColor ASRProBlueColor]CGColor]];
    [lROModeBtn.layer setBorderWidth:1.0];
    [lROModeBtn setUserInteractionEnabled:NO];
    NSString *modeString = @"";
    switch ([[[mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:indexPath.row] objectForKey:@"CurrentMode"] intValue]) {
        case 2:
            modeString = @"Dispatch";
            break;
        case 3:
            modeString = @"Inspection";
            break;
        case 4:
            modeString = @"Approval";
            break;
        case 6:
            modeString = @"Repair";
            break;
        case 7:
            modeString = @"Review";
            break;
        default:
            break;
    }
    lROModeBtn.titleLabel.textColor = [UIColor ASRProBlueColor];
    [lROModeBtn.titleLabel setHighlightedTextColor:[UIColor whiteColor]];
    [lROModeBtn setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
    [lROModeBtn setHidden:YES];
    
    [lROModeNamelLabel setText:modeString];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)setupStrings {
    textPull = @"Pull down to update...";
    textRelease = @"Release to update...";
    textLoading = @"Updating...";
}

- (void)addPullToRefreshHeader {
    refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, 320, REFRESH_HEADER_HEIGHT)];
    refreshHeaderView.backgroundColor = [UIColor clearColor];
    
    refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, REFRESH_HEADER_HEIGHT)];
    refreshLabel.backgroundColor = [UIColor clearColor];
    refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
    refreshLabel.textAlignment = NSTextAlignmentCenter;
    //refreshLabel.textColor=ASR_ORANGE_COLOR;
    refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_pullarrow.png"]];
    refreshArrow.frame = CGRectMake(floorf((REFRESH_HEADER_HEIGHT - 27) / 2),
                                    (floorf(REFRESH_HEADER_HEIGHT - 44) / 2),
                                    27, 44);
    
    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2), floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    refreshSpinner.hidesWhenStopped = YES;
    
    [refreshHeaderView addSubview:refreshLabel];
    [refreshHeaderView addSubview:refreshArrow];
    [refreshHeaderView addSubview:refreshSpinner];
    [self addSubview:refreshHeaderView];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isLoading) {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
                self.contentInset = UIEdgeInsetsZero;
        
            else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT){
                    self.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            }
    } else if (isDragging && scrollView.contentOffset.y < 0) {
        // Update the arrow direction and label
        [UIView animateWithDuration:0.25 animations:^{
            if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
                // User is scrolling above the header
                refreshLabel.text = self.textRelease;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            } else {
                // User is scrolling somewhere within the header
                refreshLabel.text = self.textPull;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
            }
        }];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isLoading) return;
    isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
        // Released above the header
        [self startLoading];
    }
}

- (void)startLoading {
    isLoading = YES;
    
    // Show the header
    [UIView animateWithDuration:0.3 animations:^{
        self.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
        refreshLabel.text = self.textLoading;
        refreshArrow.hidden = YES;
        [refreshSpinner startAnimating];
    }];
    
    // Refresh action!
    [self refresh];
}

- (void)stopLoading {
    isLoading = NO;
    
    // Hide the header
    [UIView animateWithDuration:0.3 animations:^{
        self.contentInset = UIEdgeInsetsZero;
        [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    }
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(stopLoadingComplete)];
                     }];
}

- (void)stopLoadingComplete {
    // Reset the header
    refreshLabel.text = self.textPull;
    refreshArrow.hidden = NO;
    [refreshSpinner stopAnimating];
}

- (void)refresh {
    // This is just a demo. Override this method with your custom reload action.
    // Don't forget to call stopLoading at the end.
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SearchSupportWebEngine sharedInstance] threadRequestToGetRepairOrdersForPullToRefresh];
    }else {
        [self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.0];
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
    
}

@end
