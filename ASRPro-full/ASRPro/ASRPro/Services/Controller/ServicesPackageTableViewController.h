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
    UIView *refreshHeaderView;
    UILabel *refreshLabel;
    UIImageView *refreshArrow;
    UIActivityIndicatorView *refreshSpinner;
    BOOL isDragging;
    BOOL isLoading;
    NSString *textPull;
    NSString *textRelease;
    NSString *textLoading;
    
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
    BOOL isPulltorefresh;

}

@property (nonatomic, retain) NSMutableArray* srcData;

@property (nonatomic, retain) UITouch* tempTouch;


- (void)handlePanning:(UIPanGestureRecognizer *)gestureRecognizer;
-(void)searchServicesWithText:(NSString*)aText;


@property (nonatomic, retain) UIView *refreshHeaderView;
@property (nonatomic, retain) UILabel *refreshLabel;
@property (nonatomic, retain) UIImageView *refreshArrow;
@property (nonatomic, retain) UIActivityIndicatorView *refreshSpinner;
@property (nonatomic, copy) NSString *textPull;
@property (nonatomic, copy) NSString *textRelease;
@property (nonatomic, copy) NSString *textLoading;

- (void)setupStrings;
- (void)addPullToRefreshHeader;
- (void)startLoading;
- (void)stopLoading;
- (void)refresh;
-(void)reloadServicesData;

@end