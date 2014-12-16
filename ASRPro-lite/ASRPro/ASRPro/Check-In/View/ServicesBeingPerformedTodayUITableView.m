//
//  ServicesBeingPerformedTodayUITableView.m
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ServicesBeingPerformedTodayUITableView.h"
#import "ServicesApproveButton.h"

#define kServicesBeingPerformedTodayRowHeight 38


@implementation ServicesBeingPerformedTodayUITableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark --
#pragma mark Class Method
-(void)setDelegatesAndDataSourcesForServicesBeingPerformedTableView {
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    self.delegate = self;
    self.dataSource = self;
    self.rowHeight = kServicesBeingPerformedTodayRowHeight;
    [self reloadData];
    [[SharedUtilities sharedUtilities] hideEmptySeparators:self];
    [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

#pragma mark --
#pragma mark TableView DataSources.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mAppDelegate_.mServiceDataGetter_.mSelectedServicesArray_ count];//ServiceName
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        /*
         * Service Scheduled label
         */
        UILabel *ServiceLinesLabel = [[UILabel alloc]init];
        ServiceLinesLabel.tag = 1;
        ServiceLinesLabel.backgroundColor = [UIColor clearColor];
        ServiceLinesLabel.textColor = [UIColor ASRProRGBColor:35 Green:30 Blue:32];
        ServiceLinesLabel.highlightedTextColor = [UIColor ASRProRGBColor:35 Green:30 Blue:32];
        ServiceLinesLabel.font = [UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey];
        [cell.contentView addSubview:ServiceLinesLabel];
        /*
         * Thumb image
         */
        ServicesApproveButton *thumbButton = [[ServicesApproveButton alloc] init];
        thumbButton.tag = 2;
        thumbButton.userInteractionEnabled = YES;
        [thumbButton addTarget:self action:@selector(changeThumbState:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:thumbButton];
        
        if(indexPath.row%2 == 0) {
            cell.backgroundColor = [UIColor ASRProRGBColor:236 Green:240 Blue:241];
        } else {
            cell.backgroundColor = [UIColor whiteColor];
        }
    }
    [self resetTableViews:cell];
    [self populateFormsSectionWithIndexPath:indexPath cell:cell tableView:tableView];
    
    return cell;
}

#pragma mark --
#pragma mark Table Sections Populate methods
/**
 * Method used to ResetTableViews
 * @param tableViewCell for TableViewCell
 */
- (void)resetTableViews:(UITableViewCell*)tableViewCell  { // made minor chagnes by Ram
    int tagCount = 1;
	//reset uilabels
    UILabel *ServiceLinesLabel = (UILabel*)[tableViewCell viewWithTag:tagCount];
    ServiceLinesLabel.text = nil;
    ServicesApproveButton *thumbButton =(ServicesApproveButton*)[tableViewCell viewWithTag:tagCount++];
    thumbButton = nil;
    
}

/**
 * Method used to Populate Data in table
 * @param indexPath for  IndexPath
 * @param tableViewCell for TableViewCell
 * @param tabelView for user TabelView
 */
- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView  {
    
	//----- local coordinates for setting frames of the internal UI Elements -----
	CGFloat lXCoord = 10, lYCoord = 5, lWidth = 300, lHeight = 21;
    
    //getting instances and assign the text
    UILabel *serviceLineLabel = (UILabel*)[tableViewCell.contentView viewWithTag:1];
    [serviceLineLabel setFrame:CGRectMake(lXCoord, lYCoord, lWidth, lHeight)];
    [serviceLineLabel setText: [[mAppDelegate_.mServiceDataGetter_.mSelectedServicesArray_ objectAtIndex:indexPath.row] objectForKey:@"ServiceName"]];
    
    ServicesApproveButton *thumbimageView = (ServicesApproveButton *)[tableViewCell.contentView viewWithTag:2];
    [thumbimageView setFrame:CGRectMake(lWidth + 43, lYCoord, 25,26)];
   // UIImage *image;
    if([[[mAppDelegate_.mServiceDataGetter_.mSelectedServicesArray_ objectAtIndex:indexPath.row] objectForKey:@"Approved"] integerValue] == 1) {
        [thumbimageView setApprovestate:APPROVESTATE];
    }else if ([[[mAppDelegate_.mServiceDataGetter_.mSelectedServicesArray_ objectAtIndex:indexPath.row] objectForKey:@"Declined"] integerValue] == 1) {
        [thumbimageView setApprovestate:DECLINESTATE];
    }else {
        [thumbimageView setApprovestate:UNDECIDEDSTATE];
    }
    thumbimageView->cellRow=indexPath.row;
}

#pragma mark --
#pragma mark TableView DelegateMethods.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
}

-(void)changeThumbState:(ServicesApproveButton*)sender{
    if([sender approvestate]==APPROVESTATE){
        [sender setApprovestate:DECLINESTATE];
        [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForApproveServiceLine:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ LineID:[[mAppDelegate_.mServiceDataGetter_.mSelectedServicesArray_ objectAtIndex:sender->cellRow]objectForKey:KID] ApproveDict:[[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID",@"false",@"Data", nil] mutableCopy]];
    }
    else if([sender approvestate]==DECLINESTATE){
        [sender setApprovestate:UNDECIDEDSTATE];
        [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForApproveServiceLine:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ LineID:[[mAppDelegate_.mServiceDataGetter_.mSelectedServicesArray_ objectAtIndex:sender->cellRow] objectForKey:KID] ApproveDict:[[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID", nil] mutableCopy]];
    }
    else if([sender approvestate]==UNDECIDEDSTATE){
        [sender setApprovestate:APPROVESTATE];
        [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForApproveServiceLine:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ LineID:[[mAppDelegate_.mServiceDataGetter_.mSelectedServicesArray_ objectAtIndex:sender->cellRow] objectForKey:KID] ApproveDict:[[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID",@"true",@"Data", nil] mutableCopy]];
    }

}

@end
