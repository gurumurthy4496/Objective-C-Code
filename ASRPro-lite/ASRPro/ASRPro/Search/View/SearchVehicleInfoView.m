//
//  SearchVehicleInfoView.m
//  ASRPro
//
//  Created by Santosh Kvss on 2/13/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "SearchVehicleInfoView.h"

@interface SearchVehicleInfoView ()

@end

@implementation SearchVehicleInfoView
@synthesize mVehicleDetailsArray_;

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
    [self setBorderColor];
    [self setHeaderViewAndVehiclesTableView];
}

- (void)setBorderColor {

    [self.view.layer setBorderColor:[[UIColor ASRProBlueColor] CGColor]];
    [self.view.layer setBorderWidth:2.0];
}

- (void)setHeaderViewAndVehiclesTableView {
    
    UIView *lHeaderView = [UIView new];
    lHeaderView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, 29);
    [lHeaderView setBackgroundColor:[UIColor ASRProBlueColor]];
    UILabel *lTitleLbl_ = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, 200, 21)];
    lTitleLbl_.textColor = [UIColor whiteColor];
    [lTitleLbl_ setText:NSLocalizedString(@"Vehicle_Information", nil)];
    [lHeaderView addSubview:lTitleLbl_];
    UIButton *lAddBtn_ = [UIButton buttonWithType:UIButtonTypeCustom];
    lAddBtn_.frame = CGRectMake(self.view.frame.size.width-30, 2, 20, 20);
    [self setMAddVehicleButton_:lAddBtn_];
    [_mAddVehicleButton_ setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [_mAddVehicleButton_ addTarget:self action:@selector(AddVehicleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [lHeaderView addSubview:_mAddVehicleButton_];
    [self.view addSubview:lHeaderView];

    UITableView *lTableView = [UITableView new];
    [lTableView setFrame:CGRectMake(0, lHeaderView.frame.size.height, lHeaderView.frame.size.width, self.view.frame.size.height - lHeaderView.frame.size.height)];
    [self setMVehiclesTableView_:lTableView];
    self.mVehiclesTableView_.delegate = self;
    self.mVehiclesTableView_.dataSource = self;
    self.mVehiclesTableView_.rowHeight = 82;
    if ([self.mVehiclesTableView_ respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.mVehiclesTableView_ setSeparatorInset:UIEdgeInsetsZero];
    }
    [self.view addSubview:self.mVehiclesTableView_];
    [[SharedUtilities sharedUtilities] hideEmptySeparators:self.mVehiclesTableView_];
}

- (void)pushDataintoModalVehicleForApp:(int)index {
    
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditVehicleScreen_ setValues:(NSMutableDictionary*)[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mSearchCustomerVehiclesData_] objectAtIndex:index]];
}

- (void)resetAllData {
    
    [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSearchScreen_.mMileage = @"";
    [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSearchScreen_.mTag_ = @"";
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditVehicleScreen_ resetallData];
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchViewController_ setVehicleInfomationLabelsTextFromModel];
    [self.mVehiclesTableView_ reloadData];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchViewController_] mContinueBtn_] setHidden:TRUE];
}

- (IBAction)AddVehicleBtnAction:(id)sender {
    
    [self resetAllData];
    [self.mAddVehicleButton_ setSelected:YES];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mViewReference_ = self;
    EditVehicleViewController *lEditVehicleViewController = [[EditVehicleViewController alloc] initWithNibName:@"EditVehicleViewController" bundle:nil];
    [[[SharedUtilities sharedUtilities] appDelegateInstance] setMEditVehicleViewController_:lEditVehicleViewController];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mEditVehicleViewController_.modalPresentationStyle=UIModalPresentationPageSheet;
    [[SharedUtilities sharedUtilities] appDelegateInstance].mEditVehicleViewController_.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    [self presentViewController:[[SharedUtilities sharedUtilities] appDelegateInstance].mEditVehicleViewController_ animated:YES completion:nil];
}

- (IBAction)EditBtnAction:(id)sender {
    [self pushDataintoModalVehicleForApp:((UIButton*)sender).superview.tag];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mViewReference_ = self;
    [self.mAddVehicleButton_ setSelected:NO];
    EditVehicleViewController *lEditVehicleViewController = [[EditVehicleViewController alloc] initWithNibName:@"EditVehicleViewController" bundle:nil];
    [[[SharedUtilities sharedUtilities] appDelegateInstance] setMEditVehicleViewController_:lEditVehicleViewController];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mEditVehicleViewController_.modalPresentationStyle=UIModalPresentationPageSheet;
    [[SharedUtilities sharedUtilities] appDelegateInstance].mEditVehicleViewController_.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    [self presentViewController:[[SharedUtilities sharedUtilities] appDelegateInstance].mEditVehicleViewController_ animated:YES completion:nil];
}

#pragma mark -  ***************** TableView Delegate methods ****************
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mSearchCustomerVehiclesData_] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.tag = indexPath.row;
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        int tagCount = 1;
        for (; tagCount <= 5; tagCount++) {
            UILabel *lUILabel=[[UILabel alloc]init];
            [lUILabel setBackgroundColor:[UIColor clearColor]];
            [lUILabel setHighlightedTextColor:[UIColor whiteColor]];
            [lUILabel setTextColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0]];
            [lUILabel setFont:[UIFont systemFontOfSize:14.0]];
            [lUILabel setTag:tagCount];
            [cell.contentView addSubview:lUILabel];
        }
        UIButton *lBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        lBtn.backgroundColor = [UIColor clearColor];
        lBtn.tag = tagCount;
        [lBtn addTarget:self action:@selector(EditBtnAction:) forControlEvents:UIControlEventTouchUpInside];
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
    
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchViewController_.mContinueBtn_ setHidden:NO];
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditVehicleScreen_ setMVehicleID_:[[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mSearchCustomerVehiclesData_ objectAtIndex:indexPath.row] objectForKey:@"ID"]];
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditVehicleScreen_ setMVIN_:[[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mSearchCustomerVehiclesData_ objectAtIndex:indexPath.row] objectForKey:@"VIN"]];
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSearchScreen_ setMMileage:[[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mSearchCustomerVehiclesData_ objectAtIndex:indexPath.row] objectForKey:@"Mileage"]];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mViewReference_ = self;
    if(!self.mLastIndexPath_) {
        [self setMLastIndexPath_:indexPath];
    }
    if (self.mLastIndexPath_.row != indexPath.row) {
        //If User touches on new cell.
        UITableViewCell *lNewCell = [tableView cellForRowAtIndexPath:indexPath];
        for(UIView *lView in lNewCell.contentView.subviews) {
            if ([lView isKindOfClass:[UIButton class]]) {
                UIButton *lBtn = (UIButton*)lView;
                [lBtn setImage:[UIImage imageNamed:@"Edit.png"] forState:UIControlStateNormal];
            }
        }
        //If Old Cell.
        UITableViewCell *lOldCell = [tableView cellForRowAtIndexPath:self.mLastIndexPath_];
        self.mLastIndexPath_ = indexPath;
        for(UIView *lView in lOldCell.contentView.subviews) {
            if ([lView isKindOfClass:[UIButton class]]) {
                UIButton *lBtn = (UIButton*)lView;
                [lBtn setImage:[UIImage imageNamed:@"edit_blue.png"] forState:UIControlStateNormal];
            }
        }
    }else {
        UITableViewCell *lNewCell = [tableView cellForRowAtIndexPath:indexPath];
        for(UIView *lView in lNewCell.contentView.subviews) {
            if ([lView isKindOfClass:[UIButton class]]) {
                UIButton *lBtn = (UIButton*)lView;
                [lBtn setImage:[UIImage imageNamed:@"Edit.png"] forState:UIControlStateNormal];
            }
        }
    }
}

#pragma mark --
#pragma mark Table Sections Populate methods

- (void)resetTableViews:(UITableViewCell*)tableViewCell  {
    int tagCount = 1;
	// reset UILabels;
	for (; tagCount <= 5; tagCount ++) {
        UILabel *lUILabel = (UILabel*)[tableViewCell viewWithTag:tagCount];
        lUILabel.text = nil;
	}
}

- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView  {
    
    //----- local coordinates for setting frames of the internal UI Elements -----
    
    CGFloat xCoord = 15, yCoord = 20;
    
    // ----------------------------;
    // To display year,make and model for label;
    // ----------------------------;
    UILabel *lYearMakeModelLabel = (UILabel*)[tableViewCell.contentView viewWithTag:1];
    [lYearMakeModelLabel setFrame:CGRectMake(xCoord, yCoord, 200, 18)];
    [lYearMakeModelLabel setText:[NSString stringWithFormat:@"%@",[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] returnString2:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mSearchCustomerVehiclesData_] objectAtIndex:indexPath.row] objectForKey:@"Year"] make:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mSearchCustomerVehiclesData_] objectAtIndex:indexPath.row] objectForKey:@"Make"] model:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mSearchCustomerVehiclesData_] objectAtIndex:indexPath.row] objectForKey:@"Model"]]]];
    yCoord += lYearMakeModelLabel.frame.size.height+3;
    // ----------------------------;
    // To display VIN for label;
    // ----------------------------;
    UILabel *lVINLabel = (UILabel*)[tableViewCell.contentView viewWithTag:2];
    [lVINLabel setFrame:CGRectMake(xCoord, yCoord, 160, 18)];
    [lVINLabel setText:[NSString stringWithFormat:@"%@",[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mSearchCustomerVehiclesData_] objectAtIndex:indexPath.row] objectForKey:@"VIN"]!=nil?[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mSearchCustomerVehiclesData_] objectAtIndex:indexPath.row] objectForKey:@"VIN"]:@""]];
    xCoord += lVINLabel.frame.size.width+30;
    // ----------------------------;
    // To display Tag for label;
    // ----------------------------;
    UILabel *lTagLabel = (UILabel*)[tableViewCell.contentView viewWithTag:3];
    [lTagLabel setFrame:CGRectMake(xCoord, yCoord, 40, 18)];
    [lTagLabel setText:[NSString stringWithFormat:@"%@",[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mSearchCustomerVehiclesData_] objectAtIndex:indexPath.row] objectForKey:@"MakeID"]!=nil?[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mSearchCustomerVehiclesData_] objectAtIndex:indexPath.row] objectForKey:@"MakeID"]:@""]];
    xCoord += lTagLabel.frame.size.width+30;
    // ----------------------------;
    // To display Automatic for label;
    // ----------------------------;
    UILabel *lAutomaticlLabel = (UILabel*)[tableViewCell.contentView viewWithTag:4];
    [lAutomaticlLabel setFrame:CGRectMake(xCoord, yCoord, 100, 18)];
    [lAutomaticlLabel setText:@"Automatic"];
    xCoord += lAutomaticlLabel.frame.size.width+20;
    // ----------------------------;
    // To display Mileage for label;
    // ----------------------------;
    UILabel *lMileagelLabel = (UILabel*)[tableViewCell.contentView viewWithTag:5];
    [lMileagelLabel setFrame:CGRectMake(xCoord, yCoord, 100, 18)];
    [lMileagelLabel setText:[NSString stringWithFormat:@"%@ miles",[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mSearchCustomerVehiclesData_] objectAtIndex:indexPath.row] objectForKey:@"Mileage"]!=nil?[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mSearchCustomerVehiclesData_] objectAtIndex:indexPath.row] objectForKey:@"Mileage"]:@""]];
    
    UIButton *lROModeBtn = (UIButton*)[tableViewCell.contentView viewWithTag:6];
    lROModeBtn.frame = CGRectMake(tabelView.frame.size.width-30,((tabelView.rowHeight)/2)-10, 20, 20);
    [lROModeBtn setImage:[UIImage imageNamed:@"edit_blue.png"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
