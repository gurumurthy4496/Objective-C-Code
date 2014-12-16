//
//  CheckInSearchTableView.m
//  ASRPro
//
//  Created by Santosh Kvss on 2/19/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "CheckInSearchTableView.h"
#define KRowHeight 58

@implementation CheckInSearchTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

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
    
    [mAppDelegate_.mBeginVehicleCheckInView_.mContinueBtn_ setHidden:FALSE];
    [mAppDelegate_.mBeginVehicleCheckInView_ setIsAnyCustomerSelected:YES];
    [mAppDelegate_.mModelForEditVehicleScreen_ setMVIN_:[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"VIN"]];
    [mAppDelegate_.mModelForEditVehicleScreen_ setMVehicleID_:[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"ID"]];
    [mAppDelegate_.mModelForSearchScreen_ setMMileage:[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Mileage"]];
}
#pragma mark -  ***************** TableView Delegate methods ****************
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray*lTempArray=[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"];

    if ([lTempArray count]) {
        NSMutableArray*lTempArray1=[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:section] objectForKey:@"Customers"];

        return [lTempArray1 count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
        int tagCount = 1;
        for (; tagCount <= 2; tagCount++) {
            UILabel *lUILabel=[[UILabel alloc]init];
            [lUILabel setBackgroundColor:[UIColor clearColor]];
            [lUILabel setHighlightedTextColor:[UIColor whiteColor]];
            [lUILabel setTextColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0]];
            [lUILabel setLineBreakMode:NSLineBreakByTruncatingTail];
            if(tagCount ==1)
                [lUILabel setFont:[UIFont systemFontOfSize:15.0]];
            else
                [lUILabel setFont:[UIFont systemFontOfSize:13.0]];
            
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
    
    self.mselectedCustomerindex_ = indexPath.row;
    [mAppDelegate_.mModelForEditCustomerScreen_ setValues:(NSMutableDictionary*)[[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] objectAtIndex:indexPath.row]];
    [self onSelectionOfCustomer];
}

#pragma mark --
#pragma mark Table Sections Populate methods

- (void)resetTableViews:(UITableViewCell*)tableViewCell  {
    int tagCount = 1;
	// reset UILabels;
	for (; tagCount <= 2; tagCount ++) {
        UILabel *lUILabel = (UILabel*)[tableViewCell viewWithTag:tagCount];
        lUILabel = nil;
	}
}

- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView  {
    
    //----- local coordinates for setting frames of the internal UI Elements -----
    
    CGFloat xCoord = 20, yCoord = 8;
        // ----------------------------;
        // To display customer name for label;
        // ----------------------------;
        
        UILabel *lCustomerNameLabel = (UILabel*)[tableViewCell.contentView viewWithTag:1];
        [lCustomerNameLabel setFrame:CGRectMake(xCoord, yCoord, 300, 18)];
        [lCustomerNameLabel setText:[NSString stringWithFormat:@"%@",[mAppDelegate_.mMasterViewController_ returnString1:nil salutaion:[[[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] objectAtIndex:indexPath.row] objectForKey:@"Salutation"] firstName:[[[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] objectAtIndex:indexPath.row] objectForKey:@"FirstName"] middleName:[[[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] objectAtIndex:indexPath.row] objectForKey:@"LastName"] lastName:[[[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] objectAtIndex:indexPath.row] objectForKey:@"MiddleName"]]]];
        yCoord += lCustomerNameLabel.frame.size.height+5;
        
        // ----------------------------;
        // To display make, model & year;
        // ----------------------------;
        UILabel *lMakeModelYearIDLabel = (UILabel*)[tableViewCell.contentView viewWithTag:2];
        [lMakeModelYearIDLabel setFrame:CGRectMake(xCoord, yCoord, 300, 18)];
        [lMakeModelYearIDLabel setText:[NSString stringWithFormat:@"%@",[mAppDelegate_.mMasterViewController_ returnString2:[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Year"] make:[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Make"] model:[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Model"]]]];
        yCoord += lMakeModelYearIDLabel.frame.size.height;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
