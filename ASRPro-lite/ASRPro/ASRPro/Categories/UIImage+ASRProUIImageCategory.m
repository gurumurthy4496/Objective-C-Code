//
//  UIImage+ASRProUIImageCategory.m
//  ASRPro
//
//  Created by GuruMurthy on 22/10/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "UIImage+ASRProUIImageCategory.h"

@implementation UIImage (ASRProUIImageCategory)

+ (UIImage *)imageWithColor:(UIColor *)color {
    UIColor* lColor=color;
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [lColor CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
