//
//  VehicleHistoryCategory.h
//  ASRPro
//
//  Created by GuruMurthy on 26/10/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VehicleHistoryCategory : NSObject

@property (nonatomic, retain) NSString *mRONumber;
@property (nonatomic, retain) NSString *mCreateDate;
@property (nonatomic, readwrite) int mCurrentMode;
@property (nonatomic, retain) NSMutableArray *mROServiceLinesListArray;

@end
