//
//  UITableView+UITableView_ASRProSeparatorInsetsForiOS8.m
//  ASRPro
//
//  Created by Santosh Kvss on 29/09/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "UITableView+UITableView_ASRProSeparatorInsetsForiOS8.h"

@implementation UITableView (UITableView_ASRProSeparatorInsetsForiOS8)

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
