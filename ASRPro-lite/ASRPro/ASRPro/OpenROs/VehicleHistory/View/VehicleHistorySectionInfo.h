//
//  VehicleHistorySectionInfo.h
//  ASRPro
//
//  Created by GuruMurthy on 26/10/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VehicleHistoryCategory.h"
#import "VehicleHistorySectionView.h"

@interface VehicleHistorySectionInfo : NSObject

@property (assign) BOOL open;
@property (strong) VehicleHistoryCategory *category;
@property (strong) VehicleHistorySectionView *sectionView;
@property (nonatomic,strong,readonly) NSMutableArray *rowHeights;

- (NSUInteger)countOfRowHeights;
- (id)objectInRowHeightsAtIndex:(NSUInteger)idx;
- (void)insertObject:(id)anObject inRowHeightsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRowHeightsAtIndex:(NSUInteger)idx;
- (void)replaceObjectInRowHeightsAtIndex:(NSUInteger)idx withObject:(id)anObject;
- (void)insertRowHeights:(NSArray *)rowHeightArray atIndexes:(NSIndexSet *)indexes;
- (void)removeRowHeightsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceRowHeightsAtIndexes:(NSIndexSet *)indexes withRowHeights:(NSArray *)rowHeightArray;

@end
