//
//  PartsLabourLookupSubview.h
//  ASRPro
//
//  Created by Kalyani on 10/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PartsLabourLookupSubviewClassDelegate<NSObject>
@optional
-(void)changeHeight:(int)height Tag:(int)aTag selected:(BOOL)isselected;
@end

@interface PartsLabourLookupSubview : UIView{
@public
    
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
    int selectedindex;
    int rowheight;
}

@property (nonatomic,assign)id<PartsLabourLookupSubviewClassDelegate> delegate;
@property(nonatomic,retain)  UIButton* mHeaderButton;
-(void)setPartsLabourView :(NSMutableDictionary*)aTempDict;

@end
