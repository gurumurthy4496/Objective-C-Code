//
//  OpenRODropDownView.m
//  ASRPro
//
//  Created by GuruMurthy on 22/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "OpenRODropDownView.h"

@interface OpenRODropDownView ()
@property(nonatomic, strong) UITableView *mTableView_;
@property(nonatomic, strong) UIButton *mButtonSender_;
@property(nonatomic, retain) NSArray *mArrayList_;
@end

@implementation OpenRODropDownView
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

- (id)showOpenRODropDown:(UIButton *)aButton Height:(CGFloat *)aHeight Array:(NSArray *)aArray Direction:(NSString *)aDirection {
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
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        self.mTableView_ = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, buttonFrame.size.width, 0)];
        self.mTableView_.delegate = self;
        self.mTableView_.dataSource = self;
        self.mTableView_.layer.cornerRadius = 5;
        [self.mTableView_ setRowHeight:26.0];
        self.mTableView_.backgroundColor = [UIColor whiteColor];
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

-(void)hideOpenRODropDown:(UIButton *)button {
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 26;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.mArrayList_ count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor ASRProBlueColor];
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    if ([self.mArrayList_ count]) {
        cell.textLabel.text =[mArrayList_ objectAtIndex:indexPath.row];
    }
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor ASRProBlueColor];
    cell.selectedBackgroundView = v;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_ setAnchorRightRevealAmount:0.0f];

    [self hideOpenRODropDown:self.mButtonSender_];
   [[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchViewController_] hideallview:TRUE];    
    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
    [self.mButtonSender_ setTitle:c.textLabel.text forState:UIControlStateNormal];
    [self.mButtonSender_ setTitle:c.textLabel.text forState:UIControlStateSelected];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSearchScreen_] getSelectedModeName:c.textLabel.text];
    [self myDelegate];
}

- (void) myDelegate {
    [self.delegate OpenRODropDownDelegateMethod:self];
    [[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_].mOpenROFilterButton_.selected =! [[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_].mOpenROFilterButton_.selected;
}

@end
