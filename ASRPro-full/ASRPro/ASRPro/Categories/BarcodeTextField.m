//
//  BarcodeTextField.m
//  ASRPro
//
//  Created by Guru Murthy Pulipati on 15/12/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "BarcodeTextField.h"

@implementation BarcodeTextField
- (void)initializeTextField {
    [self setFont:[UIFont regularFontOfSize:45 fontKey:kFontRegularKey]];
    [self setDelegate:self];
}

#pragma mark -
#pragma mark TextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self viewMoveUp];
    // register for keyboard notifications
    /*[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];*/
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    // unregister for keyboard notifications while not visible.
    /*[[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];*/
    [self viewNormalposition];
//    [self showOrHideTextField:YES];
}

// When Keyboard appears
- (void)keyboardWillShow:(NSNotification *)notification {
    
    [self viewMoveUp];
}

// When keyboard disappears
- (void) keyboardWillHide : (NSNotification *) notification {
    
    [self viewNormalposition];
}

- (void)viewMoveUp {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self checkOrientations];
    [UIView commitAnimations];
}

- (void)viewNormalposition {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // Frame update
    CGRect frame = self.superview.frame;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
    frame.origin.x = self.superview.frame.size.height - self.superview.frame.size.height;
    }else {
        frame.origin.y = self.superview.frame.size.height - self.superview.frame.size.height;
    }
    self.superview.frame = frame;
    
    [UIView commitAnimations];
}

- (void)showOrHideTextField:(BOOL)aBool {
    [self setHidden:aBool];
}

- (void)checkOrientations {
    
    //DETERMINE ORIENTATION
    if( [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait ) {
    }
    if( [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown ) {
    }
    if( [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft ) {
        // Frame Update
        CGRect frame = self.superview.frame;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
            frame.origin.x = -(self.superview.frame.size.height -kKeyboardHeight) + 450;
        }else {
            frame.origin.y = -(self.superview.frame.size.height - kKeyboardHeightForiOS8)+200;
        }
        self.superview.frame = frame;
        NSLog(@"UIInterfaceOrientationLandscapeLeft");
    }
    if( [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight ) {
        // Frame Update
        CGRect frame = self.superview.frame;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
            frame.origin.x = (self.superview.frame.size.height -kKeyboardHeight) - 450;
        }else {
            frame.origin.y = (self.superview.frame.size.height -kKeyboardHeightForiOS8)-500;
        }
        self.superview.frame = frame;
        NSLog(@"UIInterfaceOrientationLandscapeRight");
    }
    //DETERMINE ORIENTATION
    
}
@end
