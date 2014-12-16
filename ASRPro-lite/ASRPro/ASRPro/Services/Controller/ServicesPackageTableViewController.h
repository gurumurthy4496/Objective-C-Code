//
//  ServicesPackageTableViewController.h
//  ASRPro
//
//  Created by Kalyani on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServicePackageCell.h"
#import "ServicesViewController.h"

@interface ServicesPackageTableViewController : UITableViewController<UIGestureRecognizerDelegate>{
@public
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;

    
    UITableView*        srcTableView;
    
    ServicePackageCell*    draggedCell;
    
    NSMutableArray*     srcData;
    
    BOOL            dragFromSource;
    BOOL isSearching;// used for reodering
    NSString * mSearchText;
}

@property (nonatomic, retain) NSMutableArray* srcData;

@property (nonatomic, retain) UITouch* tempTouch;


- (void)handlePanning:(UIPanGestureRecognizer *)gestureRecognizer;
-(void)searchServicesWithText:(NSString*)aText;

@end