//
//  SelectAppointmentTableView.m
//  ASRPro
//
//  Created by Santosh Kvss on 2/27/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "SelectAppointmentTableView.h"
#define KRowHeight 58
#define DateFormatApp @"MM-dd-yy,hh:mm a"

@implementation SelectAppointmentTableView

#pragma mark -  ***************** Generic methods ****************

//--------------------------------------------------- ************** ------------------------------------------------------
//  ** This method is used for making the delegates of 'mSearchListFromseverTableview_' to be called in the custom table **..
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)setDelegatesForSearchListTableview_ {
    self.dataSource=self;
    self.delegate=self;
    self.rowHeight=KRowHeight;
    [self reloadData];
    [[SharedUtilities sharedUtilities] hideEmptySeparators:self];
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)onSelectionOfCustomer {
    
    mAppDelegate_.mBeginVehicleCheckInView_.isAnyApponimentSelected = YES;
    [mAppDelegate_.mBeginVehicleCheckInView_.mSelectedApptContinueBtn_ setHidden:FALSE];
    NSIndexPath *lSelectedIndexPath = [NSIndexPath indexPathForRow:_mselectedAppointmentindex_ inSection:0];
    [self selectRowAtIndexPath:lSelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [mAppDelegate_.mModelForSearchScreen_ setMAdvisorID_:[[mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ objectAtIndex:_mselectedAppointmentindex_] objectForKey:@"AdvisorID"]];
    [mAppDelegate_.mModelForSearchScreen_ setMAppointmentNumber_:[[mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ objectAtIndex:_mselectedAppointmentindex_] objectForKey:@"Number"]];
    [mAppDelegate_.mModelForEditCustomerScreen_ setMCustomerNumber_:[[[mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ objectAtIndex:_mselectedAppointmentindex_] objectForKey:@"Customer"] objectForKey:@"Number"]];
//    [mAppDelegate_.mModelForEditCustomerScreen_ setValues:(NSMutableDictionary*)[[mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ objectAtIndex:_mselectedAppointmentindex_] objectForKey:@"Customer"]];
//    [mAppDelegate_.mModelForEditVehicleScreen_ setValues:(NSMutableDictionary*)[[mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ objectAtIndex:_mselectedAppointmentindex_] objectForKey:@"Vehicle"]];
}
#pragma mark -  ***************** TableView Delegate methods ****************
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    int tagCount = 1;
    for (; tagCount <= 4; tagCount++) {
        UILabel *lUILabel=[[UILabel alloc]init];
        [lUILabel setBackgroundColor:[UIColor clearColor]];
        [lUILabel setHighlightedTextColor:[UIColor whiteColor]];
        [lUILabel setTextColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0]];
        [lUILabel setLineBreakMode:NSLineBreakByTruncatingTail];
        if(tagCount ==4)
            [lUILabel setFont:[UIFont systemFontOfSize:12.0]];
        else
            [lUILabel setFont:[UIFont systemFontOfSize:15.0]];
        
        [lUILabel setTag:tagCount];
        [cell.contentView addSubview:lUILabel];
    }
    UIView *lSelectedView_ = [[UIView alloc] init];
    lSelectedView_.backgroundColor =[UIColor colorWithRed:229/255.0 green:125/255.0 blue:37/255.0 alpha:1.0f];
    cell.selectedBackgroundView = lSelectedView_;
    [self resetTableViews:cell];
    [self populateFormsSectionWithIndexPath:indexPath cell:cell tableView:tableView];
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.mselectedAppointmentindex_ = indexPath.row;
    [self onSelectionOfCustomer];
}

#pragma mark --
#pragma mark Table Sections Populate methods

- (void)resetTableViews:(UITableViewCell*)tableViewCell  {
    int tagCount = 1;
	// reset UILabels;
	for (; tagCount <= 4; tagCount ++) {
        UILabel *lUILabel = (UILabel*)[tableViewCell viewWithTag:tagCount];
        lUILabel = nil;
	}
}

- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView  {
    
    //----- local coordinates for setting frames of the internal UI Elements -----
    
    CGFloat xCoord = 23, yCoord = 8,xPos = 23;
    // ----------------------------;
    // To display customer name for label;
    // ----------------------------;
    NSDate *lTodayDate = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:DateFormatApp];
    NSString *lTodayDateStr = [formatter stringFromDate:lTodayDate];
    NSArray *lDateAndTimeArr = [[self returnStringFromJSONDate:[[mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ objectAtIndex:indexPath.row] objectForKey:@"Time"]] componentsSeparatedByString:@","];
    UILabel *lDateLabel = (UILabel*)[tableViewCell.contentView viewWithTag:1];
    [lDateLabel setFrame:CGRectMake(xCoord, yCoord, 70, 18)];
    if ([lTodayDateStr isEqualToString:[lDateAndTimeArr objectAtIndex:0]]) {
        [lDateLabel setText:[NSString stringWithFormat:@"Today"]];
    }else
        [lDateLabel setText:[NSString stringWithFormat:@"%@",[lDateAndTimeArr objectAtIndex:0]]];
    xCoord += lDateLabel.frame.size.width+5;

    UILabel *lTimeLabel = (UILabel*)[tableViewCell.contentView viewWithTag:2];
    [lTimeLabel setFrame:CGRectMake(xCoord, yCoord, 75, 18)];
    [lTimeLabel setText:[NSString stringWithFormat:@"%@",[lDateAndTimeArr objectAtIndex:1]]];
    xCoord += lTimeLabel.frame.size.width+25;
    
    UILabel *lCustomerNameLabel = (UILabel*)[tableViewCell.contentView viewWithTag:3];
    [lCustomerNameLabel setFrame:CGRectMake(xCoord, yCoord, 200, 18)];
    [lCustomerNameLabel setText:[NSString stringWithFormat:@"%@",[mAppDelegate_.mMasterViewController_ returnString1:nil salutaion:nil firstName:[[[mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ objectAtIndex:indexPath.row] objectForKey:@"Customer"] objectForKey:@"FirstName"] middleName:[[[mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ objectAtIndex:indexPath.row] objectForKey:@"Customer"] objectForKey:@"MiddleName"] lastName:[[[mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ objectAtIndex:indexPath.row] objectForKey:@"Customer"] objectForKey:@"LastName"]]]];
    yCoord += lCustomerNameLabel.frame.size.height+5;
    
    // ----------------------------;
    // To display make, model & year;
    // ----------------------------;
    UILabel *lMakeModelYearIDLabel = (UILabel*)[tableViewCell.contentView viewWithTag:4];
    [lMakeModelYearIDLabel setFrame:CGRectMake(xPos, yCoord, 300, 18)];
    [lMakeModelYearIDLabel setText:[NSString stringWithFormat:@"%@",[mAppDelegate_.mMasterViewController_ returnString2:[[[mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ objectAtIndex:indexPath.row] objectForKey:@"Vehicle"] objectForKey:@"Year"] make:[[[mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ objectAtIndex:indexPath.row] objectForKey:@"Vehicle"] objectForKey:@"Make"] model:[[[mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ objectAtIndex:indexPath.row] objectForKey:@"Vehicle"] objectForKey:@"Model"]]]];
    yCoord += lMakeModelYearIDLabel.frame.size.height;
}

- (NSString*)returnStringFromJSONDate:(NSString*)apppoinmenttime {
    
    // *** convert json date to actual date
    apppoinmenttime = [apppoinmenttime stringByReplacingOccurrencesOfString:@"0530" withString:@"0000"];
    
    if(![apppoinmenttime isEqualToString:@""]&&apppoinmenttime!=nil) {
        NSDate* date=[mAppDelegate_.mMasterViewController_ mfDateFromDotNetJSONString:apppoinmenttime];
        NSDateFormatter *mFormatter_ = [NSDateFormatter new];
        [mFormatter_ setDateFormat:DateFormatApp];
        apppoinmenttime= [mFormatter_ stringFromDate:date];
        
        NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        [mFormatter_ setTimeZone:gmt];
        NSString *timeStamp = [mFormatter_ stringFromDate:date];
        DLog(@" ==== DATE :%@ ==== ",timeStamp);
        apppoinmenttime = timeStamp;
        
    }
    apppoinmenttime = apppoinmenttime!=nil?apppoinmenttime:@"";
    return apppoinmenttime;
}

@end
