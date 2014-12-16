//
//  ServicesBeingPerformedTodayView.m
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ServicesBeingPerformedTodayView.h"

@implementation ServicesBeingPerformedTodayView
@synthesize mServicesBeingPerformedTodayUITableView_;
@synthesize mShopChargesAndTaxesLabel_;
@synthesize mSubTotalOfServicesListedLabel_;
@synthesize mTotalLabel_;

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

- (void)setBorderForServicesBeingPerformedTodayView {
    [self.layer setBorderColor:[[UIColor ASRProBlueColor] CGColor]];
    [self.layer setBorderWidth:2];
    [self setHeaderLabelForServicesBeingPerformedTodayView];
    [self setInitializingMemoryForServicesBeingPerformedTodayTableView];
    [self setLabelsForSubTotalShopChargesAndTotal];
}

- (void)setInitializingMemoryForServicesBeingPerformedTodayTableView {
    ServicesBeingPerformedTodayUITableView *tableView = [[ServicesBeingPerformedTodayUITableView alloc] init];
    [tableView setFrame:CGRectMake(0, 35, self.frame.size.width, 255)];
    self.mServicesBeingPerformedTodayUITableView_ = tableView;
    [self addSubview:self.mServicesBeingPerformedTodayUITableView_];
}

- (void)setLabelsForSubTotalShopChargesAndTotal {
    NSArray *array = [[NSArray alloc] initWithObjects:@"Sub Total of Services listed",@"Shop Charges & Taxes",@"Total",@"",@"",@"", nil];
    CGFloat x = 0, y = 290, width = 392, height = 38;
    __block CGFloat yPosition = y;
    [array enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if (index <= 2) {
            UILabel *leftLabel = [[UILabel alloc] init];
            [leftLabel setFrame:CGRectMake(x, yPosition, width, height)];
            [leftLabel setText:[NSString stringWithFormat:@"   %@",object]];
            [leftLabel setTextColor:[UIColor whiteColor]];
            [leftLabel setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
            if (index == 0 || index == 1) {
                [leftLabel setBackgroundColor:[UIColor ASRProRGBColor:88 Green:164 Blue:255]];
            }else {
                [leftLabel setBackgroundColor:[UIColor ASRProBlueColor]];
            }
            [self addSubview:leftLabel];
            yPosition += height;
            if (index == 2) {
                yPosition = y;
            }
        }else {
            UILabel *rightLabel = [[UILabel alloc] init];
            [rightLabel setFrame:CGRectMake(310, yPosition, 70, height)];
            [rightLabel setText:object];
            [rightLabel setTextColor:[UIColor whiteColor]];
            [rightLabel setTextAlignment:NSTextAlignmentRight];
            [rightLabel setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
            [rightLabel setBackgroundColor:[UIColor clearColor]];
            if (index == 3) {
                mSubTotalOfServicesListedLabel_ = rightLabel;
            }else if (index == 4) {
                mShopChargesAndTaxesLabel_ = rightLabel;
            }else {
                mTotalLabel_ = rightLabel;
            }
            [self addSubview:rightLabel];
            yPosition += height;
        }
    }];
    
}

- (void)setTextForSubTotalOfServicesListedCost :(float)aSubTotalOfServicesListedCost ShopChargesAndTaxesCost :(float)aShopChargesAndTaxesCost TotalCost :(float)aTotalCost {
    self.mSubTotalOfServicesListedLabel_.text = [NSString stringWithFormat:@"$ %@",[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mApprovedServicesTotal]];
    self.mShopChargesAndTaxesLabel_.text = [NSString stringWithFormat:@"$ %@",[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mTaxandShopChargesApproved]];
    self.mTotalLabel_.text = [NSString stringWithFormat:@"$ %@",[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mCheckinFinalTotal]];
}

- (void)setFrameForServicesBeingPerformedTodayView {
    
}

- (void)setHeaderLabelForServicesBeingPerformedTodayView {
    UILabel *headerLabel = [[UILabel alloc] init];
    CGFloat x = 0, y = 0, width = self.frame.size.width, height = 35;
    [headerLabel setFrame:CGRectMake(x, y, width, height)];
    [headerLabel setText:@"   Services Being Performed Today"];
    [headerLabel setTag:1];
    [headerLabel setTextColor:[UIColor whiteColor]];
    [headerLabel setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
    [headerLabel setBackgroundColor:[UIColor ASRProBlueColor]];
    [self addSubview:headerLabel];
}


-(void)reloadData{
    float SubTotalOfServicesListedCost = [[[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mServicesScheduledTotal floatValue] + [[[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mRecommendedServicesTotal floatValue];
    float ShopChargesAndTaxesCost = [[[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mShopCharges floatValue] + [[[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mTax floatValue];
    float TotalCost = [[[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mFinalServicesTotall floatValue];
    [self setTextForSubTotalOfServicesListedCost:SubTotalOfServicesListedCost
                                                           ShopChargesAndTaxesCost:ShopChargesAndTaxesCost
                                                                         TotalCost:TotalCost];
    [self.mServicesBeingPerformedTodayUITableView_ reloadData];
    
}
@end
