//
//  VehicleAngleDropDownView.m
//  ASRPro
//
//  Created by GuruMurthy on 05/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "VehicleAngleDropDownView.h"

@interface VehicleAngleDropDownView ()
@property(nonatomic, strong) UITableView *mTableView_;
@property(nonatomic, strong) UIButton *mButtonSender_;
@property(nonatomic, retain) NSArray *mArrayList_;
@end

@implementation VehicleAngleDropDownView
@synthesize mTableView_;
@synthesize mButtonSender_;
@synthesize mArrayList_;
@synthesize delegate;
@synthesize animationDirection;

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

- (id)showVehicleAngleDropDown:(UIButton *)aButton Height:(CGFloat *)aHeight Array:(NSArray *)aArray Direction:(NSString *)aDirection {
    self.mButtonSender_ = aButton;
    animationDirection = aDirection;
    self.mTableView_ = (UITableView *)[super init];
    if (self) {
        // Initialization code
        CGRect buttonFrame = aButton.frame;
        self.mArrayList_ = [NSArray arrayWithArray:aArray];
        if ([aDirection isEqualToString:@"up"]) {
            self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y, buttonFrame.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, -5);
        }else if ([aDirection isEqualToString:@"down"]) {
            self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y+buttonFrame.size.height, buttonFrame.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, 5);
        }
        self.layer.masksToBounds = NO;
        self.mTableView_ = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, buttonFrame.size.width, 0)];
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
            self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y -* aHeight, buttonFrame.size.width, *aHeight);
        } else if([aDirection isEqualToString:@"down"]) {
            self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y + buttonFrame.size.height, buttonFrame.size.width, *aHeight);
        }
        self.mTableView_.frame = CGRectMake(0, 0, buttonFrame.size.width, *aHeight);
        [UIView commitAnimations];
        [aButton.superview addSubview:self];
        [self addSubview:self.mTableView_];
        [[SharedUtilities sharedUtilities] hideEmptySeparators:self.mTableView_];
    }
    return self;
}

-(void)hideVehicleAngleDropDown:(UIButton *)button {
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
    
    __block CategoryWalkAround *category;
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_].mVehicleDiagramSetsArray_ enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([[SharedUtilities sharedUtilities]appDelegateInstance].mModelForWalkAround_.mVehicleDiagramSetID_ == [[object valueForKey:@"ID"] integerValue]) {
            category = (CategoryWalkAround *)[[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForWalkAround_.mCategoryListArray_ objectAtIndex:index];
            *stop = YES;
        }
    }];
    return [category.mVehicleDiagramsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor ASRProBlueColor];
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    
    if ([self.mArrayList_ count]) {
        
        CategoryWalkAround *category = (CategoryWalkAround *)[[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForWalkAround_.mCategoryListArray_ objectAtIndex:indexPath.row];
        NSString *angleString = [NSString stringWithFormat:@"  %@",[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] getTextFromVehicleDiagramViewAngleID:[category.mVehicleDiagramsList objectAtIndex:indexPath.row]]];
        cell.textLabel.text = (angleString != nil || ![angleString isEqualToString:@""])?angleString :@"";
    }
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor ASRProBlueColor];
    cell.selectedBackgroundView = v;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleAngleButton_.selected =! [[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleAngleButton_.selected;

    [self hideVehicleAngleDropDown:self.mButtonSender_];
    
    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
    [self.mButtonSender_ setTitle:c.textLabel.text forState:UIControlStateNormal];
    [self.mButtonSender_ setTitle:c.textLabel.text forState:UIControlStateSelected];
    [[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].nextCount = indexPath.row;

    [[[SharedUtilities sharedUtilities]appDelegateInstance] mModelForWalkAround_].mTempmVehicleAngleForDamagesSetID_ = indexPath.row;
    [[[SharedUtilities sharedUtilities]appDelegateInstance] mModelForWalkAround_].mVehicleDiagramViewAngleID_ = indexPath.row + 1;
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] scrollViewDidEndDecelerating:nil];
//    [[[[SharedUtilities sharedUtilities]appDelegateInstance] mModelForWalkAround_] tableViewSelectedAtIndexPath:indexPath];
    [self myDelegate];
}

- (void) myDelegate {
    [self.delegate vehicleAngleDropDownViewDelegateMethod:self];
}


@end
