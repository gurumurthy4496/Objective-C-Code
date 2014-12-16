//
//  VehicleHistorySectionView.h
//  ASRPro
//
//  Created by GuruMurthy on 26/10/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VehicleHistorySectionView;

@interface VehicleHistorySectionView : UIView

@property (nonatomic, retain) UILabel *mRONumber;
@property (nonatomic, retain) UILabel *mCreateDate;

@property (nonatomic, retain) UIButton *discButton;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) id<VehicleHistorySectionView> delegate;


- (id)initWithFrame:(CGRect)frame WithRONumber: (NSString *)aRONumber CreateDate:(NSString *)aCreateDate Section:(NSInteger) aSectionNumber currentMode:(int)aCurrentMode delegate: (id <VehicleHistorySectionView>)aDelegate;
- (void) discButtonPressed : (id) sender;
- (void) toggleButtonPressed : (BOOL) flag;

@end

@protocol VehicleHistorySectionView <NSObject>

@optional
- (void) sectionClosed : (NSInteger) section;
- (void) sectionOpened : (NSInteger) section;

@end
