//
//  SectionInfoWalkAround.h
//  ASRPro
//
//  Created by Krishna kuchimanchi on 16/05/13.
//  Copyright (c) 2013 Value Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SectionInfoWalkAround;

@class CategoryWalkAround;

@class SectionViewWalkAround;

@interface SectionInfoWalkAround : NSObject

@property (assign) BOOL open;
@property (strong) CategoryWalkAround *category;
@property (strong) SectionViewWalkAround *sectionView;
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
