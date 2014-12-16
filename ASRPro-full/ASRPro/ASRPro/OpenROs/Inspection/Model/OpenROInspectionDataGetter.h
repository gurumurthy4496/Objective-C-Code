//
//  OpenROInspectionDataGetter.h
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenROInspectionDataGetter : NSObject{
@public
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;

}
@property(nonatomic,retain)NSMutableArray* mInspectionFormsArray_;
@property (nonatomic, retain) NSMutableArray *mInspectionListArray_;
@property(nonatomic,retain)NSMutableDictionary* mInspectionFormDict_;
@property(nonatomic,retain)NSMutableArray* mInspectionItemsArray_;
@property(nonatomic,retain)NSString* mInspectionFormID_;
@property (nonatomic,retain) NSMutableDictionary *mCompleteInspectionDetailsDict_;
@property(nonatomic,retain) NSMutableArray* mCautionedFailedItems_;
-(void)loadWalkaroundInspectionForm;
- (void)setTopNavigationBarHiddenForOpenROScreen :(UIView *)aView Hidden:(BOOL)aHidden Button:(UIButton *)aButton ;
@end
