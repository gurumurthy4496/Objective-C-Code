//
//  WalkAroundLeftViewController.h
//  ASRPro
//
//  Created by GuruMurthy on 31/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    ShowVehicleHistoryForOpenROSection = 1,//This is for OpenRO
    
} ShowVehicleHistoryForOpenRO;


@interface CustomButtonForAddServicesWalkAround: UIButton
@property (nonatomic, retain) NSMutableDictionary *mRepairOrderLinesDictionary_;
@end

@interface WalkAroundLeftViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *mCustomerROInformationTableView_;
@property (nonatomic, assign) ShowVehicleHistoryForOpenRO mShowVehicleHistoryForOpenRO_;
- (void)initDataForCustomerROInformationTableView;
@end
