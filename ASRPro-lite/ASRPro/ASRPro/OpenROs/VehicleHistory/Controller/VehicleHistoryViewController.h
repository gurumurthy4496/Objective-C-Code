//
//  VehicleHistoryViewController.h
//  ASRPro
//
//  Created by GuruMurthy on 24/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VehicleHistorySectionView.h"

@interface  CustomButtonForAddServices: UIButton{
    @public
    int section;
    int row;
}


@end

@interface VehicleHistoryViewController : UIViewController <VehicleHistorySectionView>
@property (strong, nonatomic) IBOutlet UITableView *mTableView_;
@property (strong, nonatomic) IBOutlet UIButton *mCancelButton_;
@property (strong, nonatomic) IBOutlet UIButton *mAcceptButton_;
@property (strong, nonatomic) IBOutlet UILabel *mLabel_;


#pragma mark --
#pragma mark Public Methods
- (void)initDataInTableView;
- (void)setAcceptButtonHiddenForVehicleCheckIn;

- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)acceptButtonAction:(id)sender;
@end
