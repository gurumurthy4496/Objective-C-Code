//
//  DamageTypeView.h
//  ASRPro
//
//  Created by GuruMurthy on 11/09/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DamageTypeView : UIView<UIGestureRecognizerDelegate>{
    int previousPostition;
    NSArray *damagesImagesArray;
}

- (void)initializationForView;
- (void)setDragDropManager;
@property (nonatomic, retain) UIImageView *draggedImageView;
@property (nonatomic, retain) UIView *draggedView;

@end
