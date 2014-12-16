//
//  VehicleTypesDropDownView.m
//  ASRPro
//
//  Created by GuruMurthy on 05/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "VehicleTypesDropDownView.h"
#import "CheckInSupportWebEngine.h"
@interface VehicleTypesDropDownView ()
@property(nonatomic, strong) UITableView *mTableView_;
@property(nonatomic, strong) UIButton *mButtonSender_;
@property(nonatomic, retain) NSArray *mArrayList_;
@property(nonatomic, retain) NSArray *mImageList_;
@end

@implementation VehicleTypesDropDownView
@synthesize mTableView_;
@synthesize mButtonSender_;
@synthesize mArrayList_;
@synthesize mImageList_;
@synthesize delegate;
@synthesize animationDirection;

- (id)showVehicleTypesDropDown:(UIButton *)aButton Height:(CGFloat *)aHeight Array:(NSArray *)aArray ImageArray:(NSArray *)aImageArray Direction:(NSString *)aDirection {
    mButtonSender_ = aButton;
    animationDirection = aDirection;
    self.mTableView_ = (UITableView *)[super init];
    if (self) {
        // Initialization code
        CGRect btn = aButton.frame;
        self.mArrayList_ = [NSArray arrayWithArray:aArray];
        if ([aDirection isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, -5);
        }else if ([aDirection isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, 5);
        }
        self.layer.masksToBounds = NO;
        self.mTableView_ = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
        self.mTableView_.delegate = self;
        self.mTableView_.dataSource = self;
        self.mTableView_.backgroundColor = [UIColor whiteColor];
        [self.mTableView_.layer setBorderColor:[UIColor ASRProBlueColor].CGColor];
        [self.mTableView_.layer setBorderWidth:2.0];
        self.mTableView_.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.mTableView_.separatorColor = [UIColor ASRProBlueColor];
        if (IOS_NEWER_OR_EQUAL_TO_7) {
            if ([self.mTableView_ respondsToSelector:@selector(setSeparatorInset:)]) {
                [self.mTableView_ setSeparatorInset:UIEdgeInsetsZero];
            }
        }
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        if ([aDirection isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y-*aHeight, btn.size.width, *aHeight);
        } else if([aDirection isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, *aHeight);
        }
        self.mTableView_.frame = CGRectMake(0, 0, btn.size.width, *aHeight);
        [UIView commitAnimations];
        [aButton.superview addSubview:self];
        [self addSubview:self.mTableView_];
    }
    return self;
}

-(void)hideVehicleTypesDropDown:(UIButton *)button {
    CGRect btn = button.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if ([animationDirection isEqualToString:@"up"]) {
        self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
    }else if ([animationDirection isEqualToString:@"down"]) {
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
    }
    self.mTableView_.frame = CGRectMake(0, 0, btn.size.width, 0);
    [UIView commitAnimations];
}

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.mArrayList_ count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (nil==cell) {
		cell = [[UITableViewCell alloc]  initWithFrame:CGRectMake(0,0,0,0)];
        //Configure cell format for the tableView,
 	    //Same format for all the three sections.
        int tagCount = 1;
        UILabel *lUILabel = [[UILabel alloc]init];
        [lUILabel setBackgroundColor:[UIColor clearColor]];
        [lUILabel setTag:tagCount];
        [lUILabel setTextColor:[UIColor ASRProBlueColor]];
        [lUILabel setFont:[UIFont systemFontOfSize:14]];
        [lUILabel setTextAlignment:NSTextAlignmentLeft];
        [lUILabel setHighlightedTextColor:[UIColor whiteColor]];
        [cell.contentView addSubview:lUILabel];
        
        UIImageView *lUIImageView =[[UIImageView alloc]init];
        [lUIImageView setTag:tagCount + 1];
        [cell.contentView addSubview:lUIImageView];
    }
    
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor ASRProBlueColor];
    cell.selectedBackgroundView = v;
    
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
    lUILabel.text = @"";
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
    
    CGFloat lXCoord = 15,lYCoord = 0,lWidth = 280,lHeight = 40;
    
    CategoryWalkAround *lCategoryWalkAround = (CategoryWalkAround *)[self.mArrayList_ objectAtIndex:indexPath.row];
    UIImage *imagename = [UIImage imageNamed:[lCategoryWalkAround.mVehicleName stringByReplacingOccurrencesOfString:@" " withString:@""]];
    //UIImageView
    UIImageView *rightImageView = (UIImageView*)[tableViewCell viewWithTag:2];
    [rightImageView setFrame:CGRectMake(lXCoord,(lHeight - imagename.size.height)/2, imagename.size.width, imagename.size.height)];
    
    NSString *image = [lCategoryWalkAround.mVehicleName stringByReplacingOccurrencesOfString:@" " withString:@""];
    rightImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_blue",image]];
    rightImageView.highlightedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",image]];
    
    //UILabel
    UILabel *lDetailLbl = (UILabel*)[tableViewCell.contentView viewWithTag:1];
    [lDetailLbl setFrame:CGRectMake(lXCoord + 100 + 20, lYCoord, lWidth, lHeight) ];
    NSString *lText = [NSString stringWithFormat:@"%@",lCategoryWalkAround.mVehicleName];
    [lDetailLbl setText:lText];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideVehicleTypesDropDown:mButtonSender_];
    
    UITableViewCell *tableViewCell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIImageView *rightImageView = (UIImageView*)[tableViewCell viewWithTag:2];
    UILabel *lDetailLbl = (UILabel*)[tableViewCell.contentView viewWithTag:1];

//    [self.mButtonSender_ setTitle:lDetailLbl.text forState:UIControlStateNormal];
//    [self.mButtonSender_ setTitle:lDetailLbl.text forState:UIControlStateSelected];
    
    NSString *image = [lDetailLbl.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    DLog(@"%@",image);
    UIImage *imagename = rightImageView.image;
    imgView = [[CustomImageView alloc] initWithImage:imagename];
    imgView.tag = 1001;
    imgView.mImageName_ = image;
    [imgView setImage:imagename];
//    imgView.highlightedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_blue",imagename]];
    imgView.frame = CGRectMake(15, 5, imagename.size.width, imagename.size.height);
    
    mLabel = [[UILabel alloc] init];
    [mLabel setFrame:CGRectMake(15 + 100 + 20, 0, 280, 40)];
    [mLabel setTag: 1002];
    [mLabel setText:lDetailLbl.text];
    [mLabel setTextColor:[UIColor ASRProBlueColor]];
    [mLabel setHighlightedTextColor:[UIColor whiteColor]];
    
    [mButtonSender_.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        CustomImageView *imageview = (CustomImageView *)object;
        UILabel *label = (UILabel *)object;
        if ([object isKindOfClass:[UIImageView class]] || [object isKindOfClass:[UILabel class]]) {
            if (imageview.tag == 1001) {
                [imageview removeFromSuperview];
            }else if (label.tag == 1002) {
                [label removeFromSuperview];
            }
        }
    }];
    [mButtonSender_ addSubview:imgView];
    [mButtonSender_ addSubview:mLabel];

//    [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_.mVehicleDiagramForDamagesSetID_ = indexPath.row + 1;//[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_].mVehicleDiagramSetsArray_ objectAtIndex:indexPath.row] valueForKey:@"ID"] integerValue];
    
    [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_.mVehicleDiagramForDamagesSetID_ = [[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_].mVehicleDiagramSetsArray_ objectAtIndex:indexPath.row] valueForKey:@"ID"] integerValue];

    
    [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_.mTempmVehicleDiagramForDamagesSetID_ = indexPath.row;
    [self myDelegate];
    
    [mButtonSender_ setSelected:NO];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] mChangeVehicleImageAndNameColor_] methodToChangeVehicleImageAndNameColor:mButtonSender_];
    [[[[SharedUtilities sharedUtilities]appDelegateInstance] mModelForWalkAround_] tableViewSelectedAtIndexPath:[NSIndexPath indexPathForRow:[[[SharedUtilities sharedUtilities]appDelegateInstance] mModelForWalkAround_].mTempmVehicleAngleForDamagesSetID_ inSection:0]];
   
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_] setFormID:[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_]  valueForKey:@"FormID"] PartEmpID:[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_]  valueForKey:@"PartsNumber"] TagNumber:[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_]  valueForKey:@"TagNumber"] VehicleDiagramSetID:[NSString stringWithFormat:@"%d",[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_.mVehicleDiagramForDamagesSetID_] PromisedDate:[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_]  valueForKey:@"PromisedDate"] PromisedTime:[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_]  valueForKey:@"PromisedTime"]];
    
    [[CheckInSupportWebEngine checkInSharedInstance] putRequestForChangingPromiseDateAndTime];

}

- (void) myDelegate {
    [self.delegate vehicleTypesDropDownViewDelegateMethod:self];
}


@end
