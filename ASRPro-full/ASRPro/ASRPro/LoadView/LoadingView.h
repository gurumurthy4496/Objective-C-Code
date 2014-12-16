//
//  LoadingView.h
//  LoadingView
//
//  Created by Matt Gallagher on 12/04/09.
//  Copyright Matt Gallagher 2009. All rights reserved.
// 
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView
{

}

/**
 * Method used to create loadview in a view
 @param aSuperview refers to the view for which loadview is to be added
 */
- (void)loadingViewInView:(UIView *)aSuperview;

/**
 * Method used to remove loadview
 */
- (void)removeView;
CGPathRef NewPathWithRoundRect(CGRect rect, CGFloat cornerRadius);
@end