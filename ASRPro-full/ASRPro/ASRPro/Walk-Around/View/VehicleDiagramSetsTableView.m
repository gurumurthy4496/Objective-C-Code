//
//  VehicleDiagramSetsTableView.m
//  ASRPro
//
//  Created by GuruMurthy on 05/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "VehicleDiagramSetsTableView.h"

#define kEXPAND_ROW_HEIGHT 70
#define kSECTION_HEADER_HEIGHT 37
#define kACTUAL_ROW_HEIGHT 35

@interface VehicleDiagramSetsTableView () {
    
}

@property (nonatomic, assign) NSInteger openSectionIndex;
@property (nonatomic, strong) NSMutableArray *sectionInfoArray;
/**
 * NSMutableArray for category list(Vehicle list[SUV,SEDAN,HATCHBACK,MUV] and corresponding angles [Front,Rear,Top,Left,Right]).
 */
@property (nonatomic, strong) NSMutableArray *categoryList;

/**
 * Method to set category array.
 */
- (void) setCategoryArray;
/**
 * Method to set Data Into Section InfoArray.
 */
- (void)setDataIntoSectionInfoArray;
/**
 * Method used to Populate Data in table.
 * @param indexPath for  IndexPath.
 * @param tableViewCell for TableViewCell.
 * @param tabelView for user TabelView.
 */
- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView;
/**
 * Method used to ResetTableViews.
 * @param tableViewCell for TableViewCell.
 */
- (void)resetTableViews:(UITableViewCell*)tableViewCell;

- (NSString *)getTextFromVehicleDiagramViewAngleID :(NSMutableDictionary *)aMutableDictionary;
- (NSString *)getImageUrlFromVehicleDiagramViewAngleID :(NSMutableDictionary *)aMutableDictionary;
-(void)tableViewSelectedAtIndexPath:(NSIndexPath *)indexPath;

@end

@implementation VehicleDiagramSetsTableView
@synthesize sectionInfoArray;
@synthesize openSectionIndex;
@synthesize categoryList;

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

-(void)setDelegatesAndDataSourcesForVehicleTypeTableView {
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    self.delegate=self;
    self.dataSource=self;
    self.sectionHeaderHeight = kSECTION_HEADER_HEIGHT;
    self.sectionFooterHeight = 0;
    self.openSectionIndex = NSNotFound;
    [self setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self setSeparatorColor:[UIColor ASRProBlueColor]];
    [self setCategoryArray];
    [self setDataIntoSectionInfoArray];
    [self openDefaultOneSectionForVehicleTypesTableView];
    [[SharedUtilities sharedUtilities] hideEmptySeparators:self];
    [self selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:mAppDelegate_.mModelForWalkAround_.mVehicleDiagramSetID_ - 1] animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self tableViewSelectedAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:mAppDelegate_.mModelForWalkAround_.mVehicleDiagramSetID_ - 1]];
}

- (void) setCategoryArray
{
    //This block is used to set only one vehicle
    /* NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    CategoryWalkAround *category = [[CategoryWalkAround alloc] init];
    [mAppDelegate_.mModelForWalkAround_.mSelectedVehicleDiagramDictionary_ enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
        
        if ([key isEqualToString:@"Name"]) {
            category.mVehicleName = object;
        }else if ([key isEqualToString:@"VehicleDiagrams"]) {
            category.mVehicleDiagramsList = object;
        }
    }];
    [categoryArray addObject:category];
    self.categoryList = categoryArray;*/
    
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    [mAppDelegate_.mModelForWalkAround_.mVehicleDiagramSetsArray_ enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop){
        CategoryWalkAround *category = [[CategoryWalkAround alloc] init];
//        if ([[object valueForKey:@"ID"] integerValue] <= 10) {
            category.mVehicleName = [object valueForKey:@"Name"];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int i = 0; i < 5; i++) {
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                NSString *VehicleDiagramSetID = [NSString stringWithFormat:@"%d",[[object valueForKey:@"ID"] integerValue]];
                NSString *VehicleDiagramViewAngleID = [NSString stringWithFormat:@"%d",i + 1];
                NSString *str = [NSString stringWithFormat:@"http://static.asrpro.com/Images/VehicleDiagrams/%@/%@.png",VehicleDiagramSetID,VehicleDiagramViewAngleID];
                [dict setValue:VehicleDiagramSetID forKey:@"VehicleDiagramSetID"];
                [dict setValue:VehicleDiagramViewAngleID forKey:@"VehicleDiagramViewAngleID"];
                [dict setValue:str forKey:@"ImageURL"];
                [array addObject:dict];
                DLog(@"%@",array);
            }
            category.mVehicleDiagramsList = array;
            [categoryArray addObject:category];
//        }
    }];
    self.categoryList = categoryArray;
}

- (void)setDataIntoSectionInfoArray {
    if ((self.sectionInfoArray == nil)|| ([self.sectionInfoArray count] != [self numberOfSectionsInTableView:self])) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        for (CategoryWalkAround *cat in self.categoryList) {
            SectionInfoWalkAround *section = [[SectionInfoWalkAround alloc] init];
            section.category = cat;
            section.open = NO;
            
            NSNumber *defaultHeight = [NSNumber numberWithInt:44];
            NSInteger count = [[section.category mVehicleDiagramsList] count];
            for (NSInteger i= 0; i<count; i++) {
                [section insertObject:defaultHeight inRowHeightsAtIndex:i];
            }
            
            [array addObject:section];
        }
        self.sectionInfoArray = array;
    }
}

- (void)setBorderForTableView {
    [self.layer setBorderColor:[[UIColor ASRProBlueColor] CGColor]];
    [self.layer setBorderWidth:2];
}


// ----------------------------;
// Method to open Default One Section For VehicleHistory TableView;
// ----------------------------;

- (void)openDefaultOneSectionForVehicleTypesTableView {
    
    SectionInfoWalkAround *lTempVehicleHistorySectionInfo = [self.sectionInfoArray objectAtIndex:mAppDelegate_.mModelForWalkAround_.mVehicleDiagramSetID_ - 1];
    if (!lTempVehicleHistorySectionInfo.sectionView)
    {
        NSString *vehicleName = @"";
        vehicleName = [NSString stringWithFormat:@"%@",lTempVehicleHistorySectionInfo.category.mVehicleName];
        lTempVehicleHistorySectionInfo.sectionView = [[SectionViewWalkAround alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kSECTION_HEADER_HEIGHT) WithTitle:vehicleName Section:mAppDelegate_.mModelForWalkAround_.mVehicleDiagramSetID_ - 1 delegate:self];
        [lTempVehicleHistorySectionInfo.sectionView.discButton setSelected:YES];
        [self sectionOpened:mAppDelegate_.mModelForWalkAround_.mVehicleDiagramSetID_ - 1];
    }
    
}

#pragma mark --
#pragma mark TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.categoryList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SectionInfoWalkAround *array = [self.sectionInfoArray objectAtIndex:section];
    NSInteger rows = [[array.category mVehicleDiagramsList] count];
    return (array.open) ? rows : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil==cell) {
		cell = [[UITableViewCell alloc]  initWithFrame:CGRectMake(0,0,0,0)];
        //Configure cell format for the tableView,
 	    //Same format for all the three sections.
        int tagCount=1;
            UILabel *lUILabel=[[UILabel alloc]init];
            [lUILabel setBackgroundColor:[UIColor clearColor]];
            [lUILabel setTag:tagCount];
            [lUILabel setTextColor:[UIColor ASRProBlueColor]];
            [lUILabel setFont:[UIFont systemFontOfSize:14]];
            [lUILabel setTextAlignment:NSTextAlignmentCenter];
            [lUILabel setHighlightedTextColor:[UIColor whiteColor]];
            [cell.contentView addSubview:lUILabel];
            RELEASE_NIL(lUILabel);
        }
        UIView *lSelectedView_ = [[UIView alloc] init] ;
        lSelectedView_.backgroundColor =[UIColor ASRProLoginButtonBackGroundColor];
        cell.selectedBackgroundView = lSelectedView_;
        [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    [self resetTableViews:cell];
    [self populateFormsSectionWithIndexPath:indexPath cell:cell tableView:tableView];
    return cell;
}

#pragma -
#pragma mark TableView Populate Methods

- (void)resetTableViews:(UITableViewCell*)tableViewCell
{
    int tagCount=1;
	//reset UILabel and UIImageView
    UILabel *lUILabel=(UILabel*)[tableViewCell viewWithTag:tagCount];
    [lUILabel setFrame:CGRectMake(0,0,0,0)];
}

- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView
{
	//local coordinates for setting frames of the internal UI Elements
    //	CGFloat lXCoord=5,lYCoord=10,lWidth=285,lHeight=24;
    [self resetTableViews:tableViewCell];
    tableViewCell.alpha=0.30;
    tableViewCell.contentView.backgroundColor=[UIColor clearColor];
    
    UILabel *lDetailLbl = (UILabel*)[tableViewCell.contentView viewWithTag:1];
    [lDetailLbl setFrame:CGRectMake(3, 0, tabelView.frame.size.width-6, kACTUAL_ROW_HEIGHT) ];
    CategoryWalkAround *category = (CategoryWalkAround *)[self.categoryList objectAtIndex:indexPath.section];
    [lDetailLbl setText:[self getTextFromVehicleDiagramViewAngleID:[category.mVehicleDiagramsList objectAtIndex:indexPath.row]]];
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return kACTUAL_ROW_HEIGHT;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SectionInfoWalkAround *array  = [self.sectionInfoArray objectAtIndex:section];
    
    if (!array.sectionView)
    {
        NSString *title = array.category.mVehicleName;
        array.sectionView = [[SectionViewWalkAround alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kSECTION_HEADER_HEIGHT) WithTitle:title Section:section delegate:self];
    }
    return array.sectionView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    view.backgroundColor = [UIColor blackColor];
    return view;
}

#pragma mark --
#pragma mark Table view delegate

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
//    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    [self tableViewSelectedAtIndexPath:indexPath];
}

#pragma mark --
#pragma mark SectionView delegate
- (void) sectionClosed : (NSInteger) section {
    /*
     Create an array of the index paths of the rows in the section that was closed, then delete those rows from the table view.
     */
	SectionInfoWalkAround *sectionInfo = [self.sectionInfoArray objectAtIndex:section];
	
    sectionInfo.open = NO;
    NSInteger countOfRowsToDelete = [self numberOfRowsInSection:section];
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:section]];
        }
        [self deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    }
    self.openSectionIndex = NSNotFound;
}

- (void) sectionOpened : (NSInteger) section {
    //mVehicleDiagramForDamagesSetID_ is used to store the open section
    mAppDelegate_.mModelForWalkAround_.mVehicleDiagramForDamagesSetID_ = section + 1;
    SectionInfoWalkAround *array = [self.sectionInfoArray objectAtIndex:section];
    array.open = YES;
    [array.sectionView.discButton setSelected:YES];
    NSInteger count = [array.category.mVehicleDiagramsList count];
    NSMutableArray *indexPathToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i<count;i++)
    {
        [indexPathToInsert addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    NSInteger previousOpenIndex = self.openSectionIndex;
    if (previousOpenIndex != NSNotFound) {
        SectionInfoWalkAround *sectionArray = [self.sectionInfoArray objectAtIndex:previousOpenIndex];
        sectionArray.open = NO;
        NSInteger counts = [sectionArray.category.mVehicleDiagramsList count];
        [sectionArray.sectionView toggleButtonPressed:FALSE];
        for (NSInteger i = 0; i<counts; i++)
        {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenIndex]];
        }
    }
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (previousOpenIndex == NSNotFound || section < previousOpenIndex) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }else {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
    [self beginUpdates];
    [self insertRowsAtIndexPaths:indexPathToInsert withRowAnimation:insertAnimation];
    [self deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self endUpdates];
    self.openSectionIndex = section;
}

#pragma mark --
#pragma mark Class Private Methods
- (NSString *)getTextFromVehicleDiagramViewAngleID :(NSMutableDictionary *)aMutableDictionary {
     NSString *vehicleAngleName;
    __block int vehicleDiagramViewAngleID;
    [aMutableDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
        if ([key isEqualToString:@"VehicleDiagramViewAngleID"]) {
            vehicleDiagramViewAngleID = [object integerValue];
            *stop = YES;
        }
    }];
    switch (vehicleDiagramViewAngleID) {
        case 1:
            vehicleAngleName = @"Top";
            break;
        case 2:
            vehicleAngleName = @"Left";
            break;
        case 3:
            vehicleAngleName = @"Right";
            break;
        case 4:
            vehicleAngleName = @"Front";
            break;
        case 5:
            vehicleAngleName = @"Rear";
            break;
        default:
            break;
    }
    return vehicleAngleName;
}

- (NSString *)getImageUrlFromVehicleDiagramViewAngleID :(NSMutableDictionary *)aMutableDictionary {
    __block NSString *imageUrl;
    [aMutableDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
        if ([key isEqualToString:@"ImageURL"]) {
            imageUrl = object;
            *stop = YES;
        }
    }];
    return imageUrl;
}

-(void)tableViewSelectedAtIndexPath:(NSIndexPath *)indexPath {
    CategoryWalkAround *category = (CategoryWalkAround *)[self.categoryList objectAtIndex:indexPath.section];
    [mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_ setImage:[UIImage imageNamed:@""]];
    [mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_ removeButtonFromImageView];
    if ([mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.activityView superview]) {
        [mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.activityView stopAnimating];
        [mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.activityView removeFromSuperview];
    }
    
    mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.mUIImageViewDispatchLoader_ = IsVehicleTypeImage;

    mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.activityView = nil;
    [mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_ setCustomImageURL:[NSURL URLWithString:[self getImageUrlFromVehicleDiagramViewAngleID:[category.mVehicleDiagramsList objectAtIndex:indexPath.row]]]];
    
    mAppDelegate_.mModelForWalkAround_.mVehicleDiagramViewAngleID_ = [[self indexPathForSelectedRow]row] + 1;
    mAppDelegate_.mGetVehicleDamagepointOnImageView_ = mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_;
}

@end
