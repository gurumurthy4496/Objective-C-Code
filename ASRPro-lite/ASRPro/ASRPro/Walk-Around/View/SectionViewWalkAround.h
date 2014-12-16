//
//  SectionViewWalkAround.h
//  ASRPro
//
//  Created by Krishna kuchimanchi on 16/05/13.
//  Copyright (c) 2013 Value Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SectionViewWalkAround;

@interface SectionViewWalkAround : UIView

@property (nonatomic, retain) UILabel *sectionTitle;
@property (nonatomic, retain) UIButton *discButton;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) id<SectionViewWalkAround> delegate;


- (id)initWithFrame:(CGRect)frame WithTitle: (NSString *) title Section:(NSInteger)sectionNumber delegate: (id <SectionViewWalkAround>) delegate;
- (void) discButtonPressed : (id) sender;
- (void) toggleButtonPressed : (BOOL) flag;

@end

@protocol SectionViewWalkAround <NSObject>

@optional
- (void) sectionClosed : (NSInteger) section;
- (void) sectionOpened : (NSInteger) section;


@end
