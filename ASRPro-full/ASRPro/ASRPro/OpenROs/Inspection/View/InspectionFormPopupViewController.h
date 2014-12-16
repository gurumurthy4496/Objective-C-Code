//
//  InspectionFormPopupViewController.h
//  ASRPro
//
//  Created by Kalyani on 01/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface  CustomButtonForDropDown : UIButton
@property(nonatomic,retain)NSMutableDictionary*mFormDict_;
@end

@interface InspectionFormPopupViewController : UIViewController<UITableViewDelegate , UITableViewDataSource>{
@public
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
    
}

@property (strong, nonatomic) IBOutlet CustomButtonForDropDown *mDropDown_;
@property (strong, nonatomic) IBOutlet UITableView *mDropDownTable_;
- (IBAction)DroDownButtonAction:(id)sender;
-(void)hideInspectionForm;
@end
