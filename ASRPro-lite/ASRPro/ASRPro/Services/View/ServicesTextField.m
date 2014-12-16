//
//  ServicesTextField.m
//  ASRPro
//
//  Created by Kalyani on 10/29/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "ServicesTextField.h"

@implementation ServicesTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setTextColor:[UIColor blackColor]];
        //[self setUserInteractionEnabled:YES];
        //[self setBorderStyle:UITextBorderStyleLine];
        [self.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
        [self.layer setBorderWidth:1.0];
        [self setFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey]];
        [self setReturnKeyType:UIReturnKeyDone];
        self.enablesReturnKeyAutomatically=NO;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self setDelegate:self];
        UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10,40)];
        self.leftView =leftView;
        self.leftViewMode= UITextFieldViewModeAlways;
        
        leftView.userInteractionEnabled=NO;
        
        self.clearButtonMode=UITextFieldViewModeWhileEditing;
        // self.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);

    }
    return self;
}

/*- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mServicesDetailsViewController_.mModelForServiceDetailsView_ setMTechnicianNotes_:self.text];
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirstResponder];
    
    [[SharedUtilities sharedUtilities] appDelegateInstance].mServicesDetailsViewController_.mServicesDetailTableViewController_->selectedSection=0;
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mServicesDetailsViewController_.mServicesDetailTableViewController_.tableView reloadData];

    return YES;
}*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self resignFirstResponder];
    [self saveData];
    return YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSString *substring = [NSString stringWithString:textField.text];
//    substring = [substring stringByReplacingCharactersInRange:range withString:string];
//    [self saveData:substring];
//    NSLog(@"ok") ;
//    return YES;
//}

- (void)saveData {
}

@end
