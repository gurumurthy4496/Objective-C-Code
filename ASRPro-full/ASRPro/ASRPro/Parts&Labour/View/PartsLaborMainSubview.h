//
//  PartsLaborMainSubview.h
//  ASRPro
//
//  Created by Kalyani on 06/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartsLaborMainSubview : UIView<UITableViewDelegate,UITableViewDataSource>{
    @public
    int index;
}
@property(nonatomic,retain) UIButton* mAddButton_;
@property(nonatomic,retain) UIImageView* mTitleImage_;
@property(nonatomic,retain) UILabel* mTitleLabel_;
@property(nonatomic,retain) UITableView* mPartsTableView_;
@property(nonatomic)  gettbuttonstate mType_;
@property(nonatomic,retain)  NSMutableDictionary* mPartsDictionary_;

-(void)reloadTableData:(NSMutableDictionary*)mDict;
-(void)initTheVews;
-(void)deleteIndex;

@end
