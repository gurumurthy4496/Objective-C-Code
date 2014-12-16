//
//  ServicePackageCell.h
//  ASRPro
//
//  Created by Kalyani on 19/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServicePackageCell : UITableViewCell{
    @public
    int section;
}
@property (nonatomic,retain)NSString* mLabel;
@property (nonatomic,retain)NSString* mPrice;


-(void)addViewToCell :(BOOL)aSection withText:(NSString*)aText withPrice:(NSString*)aPrice ;

@end
