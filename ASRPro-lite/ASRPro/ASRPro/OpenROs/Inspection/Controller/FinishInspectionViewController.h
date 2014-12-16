//
//  FinishInspectionViewController.h
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InspectionFormPopupViewController.h"

@interface FinishInspectionViewController : UIViewController{
@public
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
    BOOL isRequireAttention;
    BOOL isMandatory;
}
@property (strong, nonatomic) IBOutlet UIView *mFormView_;
@property (strong, nonatomic) IBOutlet UIView *mRODetailsView_;
@property (strong, nonatomic) IBOutlet UIScrollView *mSliderItemsScrollView_;
@property (strong, nonatomic) IBOutlet UIScrollView *mButonItemsScrollView_;
@property (strong, nonatomic) IBOutlet UIButton *mFinishInspectionButton_;
@property (strong, nonatomic) IBOutlet UIButton *mSaveFormButton_;
@property (strong, nonatomic) InspectionFormPopupViewController* mInspectionFormPopupViewController_;
- (IBAction)FinishInspectionButtonAction_:(id)sender;

- (IBAction)SaveFormButtonAction:(id)sender;
-(void)reloadInspectionItems;
-(void)addServicePopupView:(int)xPos :(int)yPos :(NSMutableArray*)aArray :(int)tag :(int)type;
-(void)removeAddServicePopupView;
-(void)loadServices;
-(void)pushToServicesList;
-(void)setCompleteInspectionButton;

@end
