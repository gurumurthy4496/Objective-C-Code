//
//  VehicleHistory.m
//  ASRPro
//
//  Created by Santosh Kvss on 1/31/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "VehicleHistory.h"
#define kCustomerROInfoTableViewRowHeight 44
#define DateFormatApp @"dd/MM/yyyy"

@implementation VehicleHistory

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)initData {
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    [[SharedUtilities sharedUtilities] hideEmptySeparators:self];
}

//--------------------------------------------------- ************** ------------------------------------------------------
//  ** This method is used for making the delegates of 'mSearchListFromseverTableview_' to be called in the custom table **..
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)setDelegatesVehicleHistoryTableview_ {
    self.dataSource=self;
    self.delegate=self;
    self.rowHeight=kCustomerROInfoTableViewRowHeight;
    [self reloadData];
}

- (NSString*)returnStringFromJSONDate:(NSString*)apppoinmenttime {

    // *** convert json date to actual date
    apppoinmenttime = [apppoinmenttime stringByReplacingOccurrencesOfString:@"0530" withString:@"0000"];
    
    if(![apppoinmenttime isEqualToString:@""]&&apppoinmenttime!=nil) {
        NSDate* date=[mAppDelegate_.mMasterViewController_ mfDateFromDotNetJSONString:apppoinmenttime];
        NSDateFormatter *mFormatter_ = [NSDateFormatter new];
        [mFormatter_ setDateFormat:DateFormatApp];
        apppoinmenttime= [mFormatter_ stringFromDate:date];
    }
    apppoinmenttime = apppoinmenttime!=nil?apppoinmenttime:@"";
    return apppoinmenttime;
}

- (UIView*)rowHeightForVehicleHistory:(NSArray *)aServicesArray view :(UIView *)aView{
    
    [aView.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        [object removeFromSuperview];
    }];
    UIView *lView = [[UIView alloc] init];
    if (aView == nil) {
        aView = lView;
    }
    if (aServicesArray != nil) {

    __block CGFloat xCoord = 6, yCoord = 20, width = 308, height = 0;
    [aView setFrame:CGRectMake(xCoord, yCoord, width, height)];
    [aView setBackgroundColor:[UIColor clearColor]];
    // ----------------------------;
    // To display RO# and CurrentDate for labels;
    // ----------------------------;
    __block CGFloat yPosition = 20;
    [aServicesArray enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        //Services Label
        UILabel *lServiceNameLabel = [[UILabel alloc] init];
        [lServiceNameLabel setBackgroundColor:[UIColor clearColor]];
        [lServiceNameLabel setFrame:CGRectMake(xCoord, yCoord, 350, 18)];
        [lServiceNameLabel setFont:[UIFont systemFontOfSize:12.0]];
        [lServiceNameLabel setNumberOfLines:0];
        if ([[[aServicesArray objectAtIndex:index] objectForKey:@"Declined"] boolValue]) {
            [lServiceNameLabel setText:[NSString stringWithFormat:@"Declined line %i: %@",index+1,[[aServicesArray objectAtIndex:index] objectForKey:@"ServiceName"]!=nil?[[aServicesArray objectAtIndex:index] objectForKey:@"ServiceName"]:@""]];
            [lServiceNameLabel setTextColor:[UIColor redColor]];
        }else {
            [lServiceNameLabel setText:[NSString stringWithFormat:@"Line %i:  Op Code: \"%@\"  Description: \"%@\"",index+1,[[aServicesArray objectAtIndex:index] objectForKey:@"OpCode"]?[[aServicesArray objectAtIndex:index] objectForKey:@"OpCode"]:@"",[[aServicesArray objectAtIndex:index] objectForKey:@"ServiceName"]!=nil?[[aServicesArray objectAtIndex:index] objectForKey:@"ServiceName"]:@""]];
            [lServiceNameLabel setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
        }
        
        CGSize lSize = [[lServiceNameLabel text] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:12.0f]
                                            constrainedToSize:(CGSize){width, CGFLOAT_MAX}];
        CGRect frame = lServiceNameLabel.frame;
        frame.size.height += lSize.height;
        lServiceNameLabel.frame = frame;
        
        UILabel *lPriceLaborPartsTotalLabel = [[UILabel alloc] init];
        [lPriceLaborPartsTotalLabel setBackgroundColor:[UIColor clearColor]];
        [lPriceLaborPartsTotalLabel setFrame:CGRectMake(375, yCoord, 80, lServiceNameLabel.frame.size.height)];
        [lPriceLaborPartsTotalLabel setFont:[UIFont systemFontOfSize:12.0]];
        //            [lPriceLaborPartsTotalLabel setText:[NSString stringWithFormat:@"$ %.2f",lPriceLaborPartsTotal]];
        if ([[[aServicesArray objectAtIndex:index] objectForKey:@"Declined"] boolValue]) {
            [lPriceLaborPartsTotalLabel setText:[NSString stringWithFormat:@"$%@",[[aServicesArray objectAtIndex:index] objectForKey:@"Price"]!=nil?[[aServicesArray objectAtIndex:index] objectForKey:@"Price"]:@""]];
            [lPriceLaborPartsTotalLabel setTextColor:[UIColor redColor]];
        }else {
            [lPriceLaborPartsTotalLabel setText:[NSString stringWithFormat:@"$%@",[[aServicesArray objectAtIndex:index] objectForKey:@"Price"]!=nil?[[aServicesArray objectAtIndex:index] objectForKey:@"Price"]:@""]];
            [lPriceLaborPartsTotalLabel setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
        }
        yCoord += lServiceNameLabel.frame.size.height - 5;
        [aView addSubview:lServiceNameLabel];
        [aView addSubview:lPriceLaborPartsTotalLabel];
        if ([[[aServicesArray objectAtIndex:index] objectForKey:@"Declined"] boolValue]) {
            UIImage *lAddServiceImg = [UIImage imageNamed:@"AddServices.png"];
            CustomButtonForAddServicesSearch *lAddDeclinedLineBtn = [CustomButtonForAddServicesSearch buttonWithType:UIButtonTypeCustom];
            lAddDeclinedLineBtn.frame = CGRectMake(475, lPriceLaborPartsTotalLabel.frame.origin.y+7, lAddServiceImg.size.width, lAddServiceImg.size.height);
            lAddDeclinedLineBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
            [lAddDeclinedLineBtn setImage:lAddServiceImg forState:UIControlStateNormal];
//            [lAddDeclinedLineBtn setTitle:@"Add Service" forState:UIControlStateNormal];
            [lAddDeclinedLineBtn addTarget:self action:@selector(DeclinedService:) forControlEvents:UIControlEventTouchUpInside];
            [lAddDeclinedLineBtn setMServicesDict:[aServicesArray objectAtIndex:index]];
            lAddDeclinedLineBtn.titleLabel.textColor = [UIColor ASRProBlueColor];
            [aView addSubview:lAddDeclinedLineBtn];
        }
        yPosition  += 5;
        
    }];
    CGRect frame = aView.frame;
    frame.size.height += yCoord+10;
    aView.frame = frame;
    }
    return aView;
}

#pragma mark -  ***************** TableView Delegate methods ****************
#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height=  kCustomerROInfoTableViewRowHeight;
    height = tableView.rowHeight+[self rowHeightForVehicleHistory:[[mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_ objectAtIndex:indexPath.row] objectForKey:@"RepairOrderLines"] view:nil].frame.size.height;
    return height-10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_ count];
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
            [lUILabel setTextColor:[UIColor ASRProBlueColor]];
            [lUILabel setHighlightedTextColor:[UIColor blackColor]];
            [lUILabel setFont:[UIFont systemFontOfSize:13.0]];
            [lUILabel setTag:tagCount];
            [cell.contentView addSubview:lUILabel];
        }
        UIView *lServicesLineView = [UIView new];
        [lServicesLineView setBackgroundColor:[UIColor whiteColor]];
        [lServicesLineView setTag:3];
        [cell.contentView addSubview:lServicesLineView];
    }
    [self resetTableViews:cell];
    [self populateFormsSectionWithIndexPath:indexPath cell:cell tableView:tableView];
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
    UIView *lUIView = (UIView*)[tableViewCell viewWithTag:3];
    lUIView = nil;
}

- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView  {
    
    NSDate *lTodayDate = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:DateFormatApp];
    NSString *lTodayDateStr = [formatter stringFromDate:lTodayDate];
    NSLog(@"Today Date : %@", lTodayDateStr);
    UILabel *lRONumberLbl = (UILabel*)[tableViewCell.contentView viewWithTag:1];
    lRONumberLbl.frame = CGRectMake(12, 18, 150, 18);
    lRONumberLbl.font = [UIFont regularFontOfSize:15.0f fontKey:kFontNameHelveticaNeueKey];
    UILabel *lDateLbl = (UILabel*)[tableViewCell.contentView viewWithTag:2];
    lDateLbl.frame = CGRectMake(lRONumberLbl.frame.size.width+40, 18, 200, 18);
    lDateLbl.font = [UIFont regularFontOfSize:15.0f fontKey:kFontNameHelveticaNeueKey];
    NSString *lDateStr = [self returnStringFromJSONDate:[[mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_ objectAtIndex:indexPath.row] objectForKey:@"CreateDate"]];
    if ([[[mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_ objectAtIndex:indexPath.row] objectForKey:@"CurrentMode"] intValue] != 100) {
        CGRect frame = lRONumberLbl.frame;
        frame.size.width += 30;
        lRONumberLbl.frame = frame;
        [lRONumberLbl setText:[NSString stringWithFormat:@"RO #%@",[[mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_ objectAtIndex:indexPath.row] objectForKey:@"RONumber"]!=nil?[[mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_ objectAtIndex:indexPath.row] objectForKey:@"RONumber"]:@""]];
        lDateLbl.text = NSLocalizedString(@"Currently_OpenRO", nil);
    }else {
        lRONumberLbl.text = [NSString stringWithFormat:@"RO #%@",[[mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_ objectAtIndex:indexPath.row] objectForKey:@"RONumber"]!=nil?[[mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_ objectAtIndex:indexPath.row] objectForKey:@"RONumber"]:@""];
        lDateLbl.text = lDateStr;
    }
    UIView *lView = (UIView*)[tableViewCell.contentView viewWithTag:3];
    lView = [self methodForReturnExpandedViewServicesArray:[[mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_ objectAtIndex:indexPath.row] objectForKey:@"RepairOrderLines"] :lView];
    
//    lView = [self rowHeightForVehicleHistory:[[mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_ objectAtIndex:indexPath.row] objectForKey:@"RepairOrderLines"] view:lView];
}

- (UIView *)methodForReturnExpandedViewServicesArray:(NSArray *)aServicesArray :(UIView *)aExpandView {
    [aExpandView.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        [object removeFromSuperview];
    }];
    
    __block UIView *lView = [[UIView alloc] init];
    
    if (aServicesArray != nil) {
        CGFloat xCoord = 0, yCoord = kCustomerROInfoTableViewRowHeight, width = self.frame.size.width, height = 0;
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
            [lServiceNameLabel setFrame:CGRectMake(15, yPosition, 350, 45)];
            [lServiceNameLabel setFont:[UIFont regularFontOfSize:14.0f fontKey:kFontNameHelveticaNeueKey]];
            [lServiceNameLabel setNumberOfLines:2];
            [lServiceNameLabel setLineBreakMode:NSLineBreakByCharWrapping];
            
            if ([[object objectForKey:@"Declined"] boolValue] == TRUE) {
                [lServiceNameLabel setText:[NSString stringWithFormat:@"Declined Line : %@ - %@",[[object objectForKey:@"PayTypeCode"] objectForKey:@"Code"],[object objectForKey:@"ServiceName"]]];
                [lServiceNameLabel setTextColor:[UIColor redColor]];
                [lServiceNameLabel setHighlightedTextColor:[UIColor redColor]];
            }else {
                [lServiceNameLabel setText:[NSString stringWithFormat:@"Line : %@ - %@",[[object objectForKey:@"PayTypeCode"] objectForKey:@"Code"],[object objectForKey:@"ServiceName"]]];
                [lServiceNameLabel setTextColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0]];
                [lServiceNameLabel setHighlightedTextColor:[UIColor blackColor]];
            }
            
            //Price Label
            CGFloat lPriceLaborPartsTotal = [[object objectForKey:@"Price"] integerValue];//[[object  objectForKey:@"PriceLabor"] integerValue] + [[object objectForKey:@"PriceParts"] integerValue];
            
            NSString *lTotal = [NSString stringWithFormat:@"%2f",lPriceLaborPartsTotal];
            
            CGSize lTextWidth = [lTotal sizeWithFont:[UIFont regularFontOfSize:12.0f fontKey:kFontNameHelveticaNeueKey]];
            
            UILabel *lPriceLaborPartsTotalLabel = [[UILabel alloc] init];
            [lPriceLaborPartsTotalLabel setBackgroundColor:[UIColor clearColor]];
            [lPriceLaborPartsTotalLabel setFrame:CGRectMake(350 + 25, yPosition, lTextWidth.width, 45)];
            [lPriceLaborPartsTotalLabel setTextColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0]];
            [lPriceLaborPartsTotalLabel setFont:[UIFont regularFontOfSize:12.0f fontKey:kFontNameHelveticaNeueKey]];
            [lPriceLaborPartsTotalLabel setText:[NSString stringWithFormat:@"$ %.2f",lPriceLaborPartsTotal]];
            
            if ([[object objectForKey:@"Declined"] boolValue] == TRUE) {
                CustomButtonForAddServicesSearch *button = [[CustomButtonForAddServicesSearch alloc] init];
                UIImage *image = [UIImage imageNamed:@"AddServices"];
                [button setBackgroundImage:image forState:UIControlStateNormal];
                [button setBackgroundImage:image forState:UIControlStateNormal];
                button.tag = index;
                button.mServicesDict = (NSMutableDictionary *)object;
                [button setFrame:CGRectMake(475, yPosition + (self.rowHeight - image.size.height)/2, image.size.width, image.size.height)];
                [button addTarget:self action:@selector(DeclinedService:) forControlEvents:UIControlEventTouchUpInside];
                [button setHidden:FALSE];
                [lView addSubview:button];
                [aExpandView addSubview:button];
            }
            
            yPosition  += 40;
            
            [lView addSubview:lServiceNameLabel];
            [lView addSubview:lPriceLaborPartsTotalLabel];
            [aExpandView addSubview:lServiceNameLabel];
            [aExpandView addSubview:lPriceLaborPartsTotalLabel];
        }];
        if ([aServicesArray count] >0) {
            //ExpandViewHeight
            CGRect lExpandViewFrame = lView.frame;
            lExpandViewFrame.size.height = yPosition+5;
            lView.frame = lExpandViewFrame;
            aExpandView.frame = lExpandViewFrame;
        }
    }
    if (aExpandView != nil) {
        return aExpandView;
    }
    return lView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(IBAction)DeclinedService:(CustomButtonForAddServicesSearch*)sender{
    NSMutableDictionary* lTempDict = sender.mServicesDict;
    [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForServiceRequestWebEngine_ setMGetServiceReference_:VEHICLEHISTORYSERVICES];
    [[[SharedUtilities sharedUtilities]appDelegateInstance].mServiceDataGetter_.mModelForSelectedService_ saveDictToModel:lTempDict];
    [mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_ convertModelToDict];
  mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_->isAdd_=TRUE;

    [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForServiceRequestWebEngine_ RequestToAddService:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ ServiceDict:[[NSDictionary dictionaryWithObjectsAndKeys:[lTempDict objectForKey:KSGCID],KSGCID, nil] mutableCopy]];

}
@end
@implementation CustomButtonForAddServicesSearch

@synthesize mServicesDict;

@end

