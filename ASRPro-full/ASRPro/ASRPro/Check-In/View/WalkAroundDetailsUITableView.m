//
//  WalkAroundDetailsUITableView.m
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "WalkAroundDetailsUITableView.h"

#define KSERVICESCHEDULEDHEIGHT 56
#define DateFormatApp @"dd/MM/yyyy  hh:mm a"


@implementation WalkAroundDetailsUITableView
@synthesize mFormatter_;
@synthesize mvehicleAngleName_;
@synthesize mvehicleDamageName_;
@synthesize mvehicleName_;
@synthesize mvehicleSeverityName_;

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
#pragma mark Public Method
- (void)setDelegatesAndDataSourcesForWalkAroundTableView {
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    //----- SET DATE-FORMATTER -----
    mFormatter_=[[NSDateFormatter alloc]init];
    NSTimeZone *gmtZone = [NSTimeZone defaultTimeZone];
    [mFormatter_ setTimeZone:gmtZone];
    NSLocale *enLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
    mFormatter_.locale = enLocale;
    //----- END -----
    //----- SET UI-TABLE-VIEW DELEGATES -----
    self.delegate = self;
    self.dataSource = self;
    self.rowHeight = KSERVICESCHEDULEDHEIGHT;
    [self reloadData];
    //----- END -----
    //---- HIDE EMPTY ROWS IN UI-TABLE-VIEW -----
    [[SharedUtilities sharedUtilities] hideEmptySeparators:self];
    //----- END -----
}

#pragma mark --
#pragma mark TableView DataSources.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mAppDelegate_.mModelForWalkAround_.mDamageDetailsArray_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc]  initWithFrame:CGRectMake(0,0,0,0)];
        //Configure cell format for the tableView,
 	    //Same format for all the three sections.
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.alpha = 0.30;
        int tagCount = 1;
        for (tagCount = 1; tagCount <= 3; tagCount ++) {
            UILabel *lUILabel=[[UILabel alloc]init];
            [lUILabel setBackgroundColor:[UIColor clearColor]];
            [lUILabel setTextColor:[UIColor ASRProRGBColor:35 Green:30 Blue:32]];
            [lUILabel setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
            [cell.contentView addSubview:lUILabel];
            [lUILabel setTag:tagCount];
        }
        UIImageView *carImageView =[[UIImageView alloc]init];
        [cell.contentView addSubview:carImageView];
        [carImageView setTag:4];
        
        UIImageView *severityImgView =[[UIImageView alloc]init];
        [cell.contentView addSubview:severityImgView];
        [severityImgView setTag:5];
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
    int tagCount=1;
	//reset uilabels
	for (; tagCount <= 5; tagCount ++) {
        if (tagCount == 4 || tagCount == 5) {
            UIImageView *lUIImageView =(UIImageView*)[tableViewCell viewWithTag:tagCount];
            lUIImageView.image = nil;
        }else if(tagCount == 1 || tagCount == 2 || tagCount == 3 ){
            UILabel *lUILabel=(UILabel*)[tableViewCell viewWithTag:tagCount];
            lUILabel.text = nil;
        }
	}
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
    
    [self getTextFromVehicleDiagramView:[mAppDelegate_.mModelForWalkAround_.mDamageDetailsArray_ objectAtIndex:indexPath.row]];
    
	//----- local coordinates for setting frames of the internal UI Elements -----
	CGFloat lXCoord = 5, lYCoord = 10, lWidth = 285, lHeight = 24;
    UIImage *damageImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@",self.mvehicleDamageName_,mvehicleSeverityName_]];
    //To display Damage Image.
    UIImageView *lLeftImageView = (UIImageView*)[tableViewCell.contentView viewWithTag:4];
    [lLeftImageView setImage:damageImage];
    [lLeftImageView setFrame:CGRectMake(lXCoord + 10, lYCoord, damageImage.size.width, damageImage.size.height)];
    
    //To display UILabel below Vehicle Image.
    UILabel *lDamageTextLabel = (UILabel*)[tableViewCell.contentView viewWithTag:3];
    [lDamageTextLabel setFrame:CGRectMake(lXCoord-2,37,60, 18)];
    NSString *lText_ = [NSString stringWithFormat:@"%@",self.mvehicleDamageName_];
    [lDamageTextLabel setTextColor:[UIColor ASRProGreenColor]];
    [lDamageTextLabel setTextAlignment:NSTextAlignmentCenter];
    [lDamageTextLabel setFont:[UIFont boldFontOfSize:12 fontKey:kFontNameHelveticaNeueKey]];
    [lDamageTextLabel setText:lText_];
    
    //To display Damage Type.
    UILabel *lDetailLbl = (UILabel*)[tableViewCell.contentView viewWithTag:1];
    [lDetailLbl setFrame:CGRectMake(60, lYCoord, lWidth, lHeight) ];
    NSString *lText = [NSString stringWithFormat:@"%@/%@ View",self.mvehicleName_,self.mvehicleAngleName_];
    [lDetailLbl setText:lText];
    
    //To display severity Type.
    /*UIImage *rightImage;
    rightImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@Selected",self.mvehicleSeverityName_]];
    UIImageView *lRightImageView = (UIImageView*)[tableViewCell.contentView viewWithTag:5];
    [lRightImageView setFrame:CGRectMake(255, (self.rowHeight - rightImage.size.height)/2, rightImage.size.width, rightImage.size.height)];
    [lRightImageView setImage:rightImage];*/
}

#pragma mark --
#pragma mark TableView DelegateMethods.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
}

#pragma mark --
#pragma mark Class Private Methods
- (void)getTextFromVehicleDiagramView :(NSMutableArray *)aMutableArray {
     int vehicleDiagramViewAngleID;
     int VehicleDiagramSetID;
     int VehicleDamageSeverityID;
     int VehicleDamageDetailTypeID;
    NSString * vehicleAngleName = @"";
    NSString * vehicleSeverityName = @"";
    NSString * vehicleDamageName = @"";
    __block NSString * vehicleName = @"";
    
    VehicleDamageSeverityID = [[aMutableArray valueForKey:@"VehicleDamageSeverityID"] integerValue];
    VehicleDamageDetailTypeID = [[aMutableArray valueForKey:@"VehicleDamageDetailTypeID"] integerValue];
    VehicleDiagramSetID = [[[aMutableArray valueForKey:@"VehicleDiagram"] valueForKey:@"VehicleDiagramSetID"] integerValue];
    vehicleDiagramViewAngleID = [[[aMutableArray valueForKey:@"VehicleDiagram"] valueForKey:@"VehicleDiagramViewAngleID"] integerValue];

    switch (vehicleDiagramViewAngleID) {
        case 1:
            vehicleAngleName = @"Left";
            break;
        case 2:
            vehicleAngleName = @"Front";
            break;
        case 3:
            vehicleAngleName = @"Right";
            break;
        case 4:
            vehicleAngleName = @"Rear";
            break;
        case 5:
            vehicleAngleName = @"Top";
            break;
        default:
            break;
    }
    
    switch (VehicleDamageDetailTypeID) {
        case 1:
            vehicleDamageName = @"Ding";
            break;
        case 2:
            vehicleDamageName = @"Dent";
            break;
        case 3:
            vehicleDamageName = @"Scratch";
            break;
        case 4:
            vehicleDamageName = @"Chip";
            break;
        case 5:
            vehicleDamageName = @"Crack";
            break;
        default:
            break;
    }
    switch (VehicleDamageSeverityID) {
        case 1:
            vehicleSeverityName = @"Severe";
            break;
        case 2:
            vehicleSeverityName = @"Moderate";
            break;
        case 3:
            vehicleSeverityName = @"Mild";
            break;
        default:
            break;
    }
    [mAppDelegate_.mModelForWalkAround_.mVehicleDiagramSetsArray_ enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([[object valueForKey:@"ID"] integerValue] == VehicleDiagramSetID) {
            vehicleName = [object valueForKey:@"Name"];
        }
    }];
    
    self.mvehicleAngleName_ = vehicleAngleName;
    self.mvehicleDamageName_ = vehicleDamageName;
    self.mvehicleSeverityName_ = vehicleSeverityName;
    self.mvehicleName_ = vehicleName;
    
}

@end
