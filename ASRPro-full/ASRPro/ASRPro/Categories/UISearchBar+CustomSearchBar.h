//
//  UISearchBar+CustomSearchBar.h
//  ASRPro
//
//  Created by Santosh Kvss on 2/13/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (CustomSearchBar)<UISearchBarDelegate,UIGestureRecognizerDelegate>
/**
 * Methods for displaying UISearchBar for UITableView (This is UISearchBar Category).
 */
- (void)CustomSearchBar:(CGRect)frame;
@end
