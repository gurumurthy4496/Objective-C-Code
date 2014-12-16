//
//  ServicesPdfView.h
//  ASRPro
//
//  Created by Ramesh on 4/9/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServicesPdfView : UIViewController{
    /**
     * Appdelegate parameter
     */
    AppDelegate *mAppDelegate_;
}

@property (retain, nonatomic) IBOutlet UILabel *mHeaderLabel_;
@property (retain, nonatomic) IBOutlet UIWebView *mShowPdfView_;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *mActivityIdicator_;

@property (retain, nonatomic) IBOutlet UIButton *mCancelBtn_;
@property(retain,nonatomic) NSString *mWebURl;
@property(retain,nonatomic) NSString *mTitle;
/**
 * This action is used to close the modal window
 */
- (IBAction)cancelBtnAction:(id)sender;

- (void)loadURL;

@end
