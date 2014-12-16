//
//  OpenROInspectionDataGetter.m
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "OpenROInspectionDataGetter.h"

@implementation OpenROInspectionDataGetter
@synthesize mInspectionFormsArray_;
@synthesize mInspectionItemsArray_;
@synthesize mInspectionFormDict_;
@synthesize mInspectionFormID_;
@synthesize mInspectionListArray_;
@synthesize mCompleteInspectionDetailsDict_;

- (id)init
{
    if (self = [super init])
    {
        // Initialization code here
     mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
        mInspectionFormDict_=[NSMutableDictionary new];
    }
    
    return self;
}

-(void)loadWalkaroundInspectionForm{
    mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_=[[FileUtils fileUtils] loadDictionaryFromFileFolder:kINSPECTIONFORMSFOLDERPATH Path:[NSString stringWithFormat:@"%@-%@",kINPECTIONFORMNAMEPATH,mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormID_]];
    if( mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_==nil){
        mAppDelegate_.mModelForOpenROInspectionFormWebEngine_.mFormReference=WALKAROUNDINSPECTION;
        [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestForLoadingROInspectionForm:mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormID_];
    }
    else{
        mAppDelegate_.mModelForOpenROInspectionFormWebEngine_.mFormReference=WALKAROUNDINSPECTION;
    [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestForInspectionItems:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_];
    }
    
    
}


- (void)setTopNavigationBarHiddenForOpenROScreen :(UIView *)aView Hidden:(BOOL)aHidden Button:(UIButton *)aButton {
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] setTempararyPRERONumber:@""];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] setPRERONumber:@""];
    [aView.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        UIView *view = (UIView *)object;
        if (view.tag == 1) {
            __block UIImageView *imageView;
            [view.subviews enumerateObjectsUsingBlock:^(id object1, NSUInteger index1, BOOL *stop1) {
                UIButton *button = (UIButton *)object1;
                imageView = (UIImageView *)object1;
                if (button.hidden && aHidden) {
                    *stop = YES;
                    *stop1 = YES;
                    return ;
                }
                if (button.tag == 1 || button.tag == 2 || button.tag == 3 || button.tag == 4) {
                    [button setHidden:aHidden];
                }else if(imageView.tag == 9){
                    [imageView setHidden:aHidden];
                    if (aHidden) {//Add TempButton(<Search) on the headerview
                        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        CGRect frame = imageView.frame;
                        frame.size.width = 200;
                        frame.origin.x = 10;
                        
                        [backButton setFrame:frame];
                        UIImage *backArrowImage = nil;
                        backArrowImage = [UIImage imageNamed:@"back-arrow"];
                        [backButton setTitle:[NSString stringWithFormat:@"RO %@",mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_] forState:UIControlStateNormal];
                        [backButton setTitle:[NSString stringWithFormat:@"RO %@",mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_] forState:UIControlStateSelected];
                        [backButton setImage:backArrowImage forState:UIControlStateNormal];
                        [backButton setImage:backArrowImage forState:UIControlStateSelected];
                        [backButton setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
                        [backButton setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateSelected];
                        [backButton.titleLabel setFont:[UIFont regularFontOfSize:17 fontKey:kFontNameOpenSansKey]];
                        [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 2)];
                        [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                        [backButton setTag:101];
                        [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                        [view addSubview:backButton];
                        [view.subviews enumerateObjectsUsingBlock:^(id object3, NSUInteger index3, BOOL *stop3) {
                            DLog(@"%@",object3);
                        }];
                    }else {
                        [aButton setHidden:YES];
                        [aButton removeFromSuperview];
                    }
                }
            }];
        }
    }];
}

- (IBAction)backButtonAction:(id)sender {
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_ setTopViewController:[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchViewController_];
}


@end
