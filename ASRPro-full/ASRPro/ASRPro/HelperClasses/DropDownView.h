//
//  DropDownView.h
//  ASRPro
//
//  Created by Kalyani on 14/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface  CustomButtonForDropDownView : UIButton
@property(nonatomic,retain)NSMutableDictionary*mFormDict_;
-(void)setTitle:(NSString *)title;
@end

@protocol DropDownViewClassDelegate<NSObject>
@optional
-(void)changeHeight:(int)height Tag:(int)aTag View:(id)aDropDownView;
@end


@interface DropDownView : UIView<UITableViewDelegate,UITableViewDataSource>{
    int maxheight;
}
@property(nonatomic,retain) CustomButtonForDropDownView*mDropDownButton_;
@property(nonatomic,retain) UITableView*mDropDownTable_;
@property(nonatomic,retain)NSMutableArray* mTempArray_;
@property(nonatomic,retain)NSMutableArray* mkeysArray_;
@property (nonatomic,assign)id<DropDownViewClassDelegate> delegate;
-(void)hideDropDown;
-(void)initTheVIews :(int)height;
@end
