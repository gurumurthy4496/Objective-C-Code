//
//  SearchedListTableView.m
//  ASRPro
//
//  Created by Santosh Kvss on 1/31/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "SearchedListTableView.h"
#define KRowHeight 46

@implementation SearchedListTableView

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
}

- (void)onSelectionOfCustomer {
    [self pushDataintoModalCustomerAndVehicleForApp];
    [mAppDelegate_.mSearchCustomerInfoView_ setCustomerInfomationLabelsTextFromModel];
}

- (void)pushDataintoModalCustomerAndVehicleForApp {
    
        [mAppDelegate_.mModelForEditCustomerScreen_ setValues:(NSMutableDictionary*)[_mSearchListArray objectAtIndex:_mselectedCustomerindex_]];
    if ([[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Customers"] count]>0) {
        mAppDelegate_.mSearchDataGetter_.mSearchCustomerVehiclesData_ = [[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Customers"] objectAtIndex:_mselectedCustomerindex_] objectForKey:@"Vehicles"];
    }else {
        mAppDelegate_.mSearchDataGetter_.mSearchCustomerVehiclesData_ = [mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"];
    }
    [mAppDelegate_.mSearchVehicleInfoView_.mVehiclesTableView_ reloadData];
}

- (void)resetData {
    
    [self reloadData];
    [mAppDelegate_.mMasterViewController_ resetAllData];
    [mAppDelegate_.mSearchCustomerInfoView_ setCustomerInfomationLabelsTextFromModel];
    mAppDelegate_.mSearchDataGetter_.mSearchCustomerVehiclesData_ = nil;
    [mAppDelegate_.mSearchVehicleInfoView_.mVehiclesTableView_ reloadData];
}

#pragma mark -  ***************** Button Actions ****************

- (IBAction)AddNewCustomerBtnAction:(id)sender {

    [self resetData];
    [mAppDelegate_.mSearchCustomerInfoView_.mEditButton_ setSelected:YES];
    mAppDelegate_.mViewReference_ = self;
    [mAppDelegate_.mSearchViewController_ displayEditCustomerPopup];
}

#pragma mark -  ***************** TableView Delegate methods ****************
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    _mSearchListArray = [mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Customers"];
    if ([_mSearchListArray count]>0) {
        return [_mSearchListArray count]+1;
    }else {
        if ([[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] count]>0) {
            _mSearchListArray = [[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:section] objectForKey:@"Customers"];
        }
        return [_mSearchListArray count]+1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [self resetTableViews:cell];

    if(indexPath.row<[_mSearchListArray count]) {
        int tagCount = 1;
        for (; tagCount <= 2; tagCount++) {
            UILabel *lUILabel=[[UILabel alloc]init];
            [lUILabel setBackgroundColor:[UIColor clearColor]];
            [lUILabel setHighlightedTextColor:[UIColor whiteColor]];
            [lUILabel setTextColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0]];
            [lUILabel setLineBreakMode:NSLineBreakByTruncatingTail];
            if(tagCount ==1)
                [lUILabel setFont:[UIFont systemFontOfSize:14.0]];
            else
                [lUILabel setFont:[UIFont systemFontOfSize:12.0]];
            
            [lUILabel setTag:tagCount];
            [cell.contentView addSubview:lUILabel];
        }
    }
    if(indexPath.row == [_mSearchListArray count]) {
        UIButton *lBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        lBtn.tag = 3;
        [lBtn setBackgroundColor:[UIColor clearColor]];
        [lBtn addTarget:self action:@selector(AddNewCustomerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:lBtn];
    }
    
    UIView *lSelectedView_ = [[UIView alloc] init];
    lSelectedView_.backgroundColor =[UIColor colorWithRed:229/255.0 green:125/255.0 blue:37/255.0 alpha:1.0f];
    cell.selectedBackgroundView = lSelectedView_;
    [self populateFormsSectionWithIndexPath:indexPath cell:cell tableView:tableView];
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.mselectedCustomerindex_ = indexPath.row;
    [self onSelectionOfCustomer];
}

#pragma mark --
#pragma mark Table Sections Populate methods

- (void)resetTableViews:(UITableViewCell*)tableViewCell  {
    for(UIView *lCellView in tableViewCell.contentView.subviews) {
        [lCellView removeFromSuperview];
    }
}

- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView  {
    
    //----- local coordinates for setting frames of the internal UI Elements -----
    
    CGFloat xCoord = 20, yCoord = 7;

    if(indexPath.row<[_mSearchListArray count]) {

    // ----------------------------;
    // To display customer name for label;
    // ----------------------------;
    
    UILabel *lCustomerNameLabel = (UILabel*)[tableViewCell.contentView viewWithTag:1];
    [lCustomerNameLabel setFrame:CGRectMake(xCoord, yCoord, 250, 18)];
    [lCustomerNameLabel setText:[NSString stringWithFormat:@"%@",[mAppDelegate_.mMasterViewController_ returnString1:nil salutaion:[[_mSearchListArray objectAtIndex:indexPath.row] valueForKey:@"Salutation"] firstName:[[_mSearchListArray objectAtIndex:indexPath.row] valueForKey:@"FirstName"] middleName:[[_mSearchListArray objectAtIndex:indexPath.row] valueForKey:@"MiddleName"] lastName:[[_mSearchListArray objectAtIndex:indexPath.row] valueForKey:@"LastName"]]]];
    yCoord += lCustomerNameLabel.frame.size.height-3;
    
    // ----------------------------;
    // To display customer email ID;
    // ----------------------------;
    UILabel *lEmailIDLabel = (UILabel*)[tableViewCell.contentView viewWithTag:2];
    [lEmailIDLabel setFrame:CGRectMake(xCoord, yCoord, 200, 18)];
    [lEmailIDLabel setText:[NSString stringWithFormat:@"%@",[[_mSearchListArray objectAtIndex:indexPath.row] valueForKey:@"Email"]]];
    yCoord += lEmailIDLabel.frame.size.height;
    
    }
    // ----------------------------;
    // To display Add Customer Button;
    // ----------------------------;
    if(indexPath.row == [_mSearchListArray count]) {

        UIButton *lROModeBtn = (UIButton*)[tableViewCell.contentView viewWithTag:3];
        lROModeBtn.frame = CGRectMake(0,0, tableViewCell.frame.size.width, tableViewCell.frame.size.height);
        lROModeBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [lROModeBtn.titleLabel setTextColor:[UIColor ASRProBlueColor]];
        lROModeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [lROModeBtn setTitle:@"Add New Customer" forState:UIControlStateNormal];
    }
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
