//
//  SectionInfoWalkAround.m
//  ASRPro
//
//  Created by Krishna kuchimanchi on 16/05/13.
//  Copyright (c) 2013 Value Labs. All rights reserved.
//

#import "SectionInfoWalkAround.h"

@implementation SectionInfoWalkAround

@synthesize  open;
@synthesize category;
@synthesize sectionView;
@synthesize rowHeights;

- init {
	
	self = [super init];
	if (self) {
		rowHeights = [[NSMutableArray alloc] init];
	}
	return self;
}


- (NSUInteger)countOfRowHeights {
	return [rowHeights count];
}

- (id)objectInRowHeightsAtIndex:(NSUInteger)idx {
	return [rowHeights objectAtIndex:idx];
}

- (void)insertObject:(id)anObject inRowHeightsAtIndex:(NSUInteger)idx {
	[rowHeights insertObject:anObject atIndex:idx];
}

- (void)insertRowHeights:(NSArray *)rowHeightArray atIndexes:(NSIndexSet *)indexes {
	[rowHeights insertObjects:rowHeightArray atIndexes:indexes];
}

- (void)removeObjectFromRowHeightsAtIndex:(NSUInteger)idx {
	[rowHeights removeObjectAtIndex:idx];
}

- (void)removeRowHeightsAtIndexes:(NSIndexSet *)indexes {
	[rowHeights removeObjectsAtIndexes:indexes];
}

- (void)replaceObjectInRowHeightsAtIndex:(NSUInteger)idx withObject:(id)anObject {
	[rowHeights replaceObjectAtIndex:idx withObject:anObject];
}

- (void)replaceRowHeightsAtIndexes:(NSIndexSet *)indexes withRowHeights:(NSArray *)rowHeightArray {
	[rowHeights replaceObjectsAtIndexes:indexes withObjects:rowHeightArray];
}

@end
