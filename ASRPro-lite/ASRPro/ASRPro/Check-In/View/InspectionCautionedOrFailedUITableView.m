//
//  InspectionCautionedOrFailedUITableView.m
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "InspectionCautionedOrFailedUITableView.h"

#define kInspectionCautionedOrFailedTableRowHeight 55

@implementation InspectionCautionedOrFailedUITableView

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
-(void)setDelegatesAndDataSourcesForInspectionCautionedOrFailedUITableView {
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    self.delegate = self;
    self.dataSource = self;
    self.rowHeight = kInspectionCautionedOrFailedTableRowHeight;
    [self reloadData];
    [[SharedUtilities sharedUtilities] hideEmptySeparators:self];
}

#pragma mark --
#pragma mark TableView DataSources.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mAppDelegate_.mModelForCheckIn_.mInspectionCautionedOrFailedItemsArray_ count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    height  =  (CGFloat)[[SharedUtilities sharedUtilities] dynamiclabelHeightForTextCharacterWrap:[NSString stringWithFormat:@"%@",[[mAppDelegate_.mModelForCheckIn_.mInspectionCautionedOrFailedItemsArray_  objectAtIndex:indexPath.row] objectForKey:@"ItemName"]] :215 :[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] :NSLineBreakByTruncatingTail];
    height = (height>tableView.rowHeight)?(height+10):tableView.rowHeight;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
		cell = [[UITableViewCell alloc]  initWithFrame:CGRectMake(0,0,0,0)];
        //Configure cell format for the tableView,
 	    //Same format for all the three sections.
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        UILabel *lDetailLbl=[[UILabel alloc]init];
        [cell.contentView addSubview:lDetailLbl];
        lDetailLbl.numberOfLines=0;
        lDetailLbl.lineBreakMode= NSLineBreakByTruncatingTail;
        [lDetailLbl setTag:1];
        [lDetailLbl setBackgroundColor:[UIColor clearColor]];
        [lDetailLbl setTextColor:[UIColor ASRProRGBColor:35 Green:30 Blue:32]];
        [lDetailLbl setHighlightedTextColor:[UIColor ASRProRGBColor:35 Green:30 Blue:32]];
        [lDetailLbl setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];

        UIImageView *lUIImageView =[[UIImageView alloc]init];
        [lUIImageView setTag:2];
        [cell.contentView addSubview:lUIImageView];
	}
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
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
- (void)resetTableViews:(UITableViewCell*)tableViewCell
{
	//reset uilabels
    UILabel *lUILabel = (UILabel*)[tableViewCell viewWithTag:1];
    lUILabel.text = nil;
    UIImageView *lUIImageView = (UIImageView*)[tableViewCell viewWithTag:2];
    lUIImageView.image = nil;
}

/**
 * Method used to Populate Data in table
 * @param indexPath for  IndexPath
 * @param tableViewCell for TableViewCell
 * @param tabelView for user TabelView
 */
- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView {
    
    CGFloat lXCoord=5,lYCoord=0,lWidth=280,lHeight=24;

    // label
    UILabel *lDetailLbl = (UILabel*)[tableViewCell.contentView viewWithTag:1];
    [lDetailLbl setFrame:CGRectMake(lXCoord, lYCoord, lWidth-70, lHeight) ];
    
    NSString *lText = [NSString stringWithFormat:@"%@",[[mAppDelegate_.mModelForCheckIn_.mInspectionCautionedOrFailedItemsArray_  objectAtIndex:indexPath.row] objectForKey:@"ItemName"]];
    CGFloat height  =  (CGFloat)[[SharedUtilities sharedUtilities] dynamiclabelHeightForTextCharacterWrap:[NSString stringWithFormat:@"%@",[[mAppDelegate_.mModelForCheckIn_.mInspectionCautionedOrFailedItemsArray_  objectAtIndex:indexPath.row] objectForKey:@"ItemName"]] :215 :[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] :NSLineBreakByTruncatingTail];
    height = (height>tabelView.rowHeight)?(height+10):tabelView.rowHeight;
    [lDetailLbl setFrame:CGRectMake(15, lDetailLbl.frame.origin.y, lDetailLbl.frame.size.width, height) ];
    [lDetailLbl setText:lText];
    
    
    // image
    UIImageView *rightImageView = (UIImageView*)[tableViewCell viewWithTag:2];
    
    UIImage *rightImage;
//    NSRange titleResultsRange = [[[mAppDelegate_.mModelForCheckIn_.mInspectionCautionedOrFailedItemsArray_  objectAtIndex:indexPath.row] objectForKey:@"Color"] rangeOfString:@"Yellow" options:NSCaseInsensitiveSearch];
    
    if ([[[mAppDelegate_.mModelForCheckIn_.mInspectionCautionedOrFailedItemsArray_ objectAtIndex:indexPath.row] valueForKey:@"Color"] isEqualToString:@"Red"]) {
        rightImage = [UIImage imageNamed:@"SevereSelected"];
    }else if ([[[mAppDelegate_.mModelForCheckIn_.mInspectionCautionedOrFailedItemsArray_ objectAtIndex:indexPath.row] valueForKey:@"Color"] isEqualToString:@"Yellow"]) {
        rightImage = [UIImage imageNamed:@"MildSelected"];
    }
    
    [rightImageView setFrame:CGRectMake(250,(self.rowHeight - rightImage.size.height)/2, rightImage.size.width, rightImage.size.height) ];

    
    [rightImageView setImage:rightImage];
    
}

#pragma mark ===========================
#pragma mark - TableView DelegateMethods.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
}

@end
