//
//  CustomerAndVehicleInfoView.m
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "CustomerAndVehicleInfoView.h"
#import "CheckInSupportWebEngine.h"

@implementation CustomerAndVehicleInfoView

@synthesize mPopoverController;
@synthesize mCustomerPlanButton_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)setBorderForCustomerAndVehicleInfoView {
    [self.layer setBorderColor:[[UIColor ASRProBlueColor] CGColor]];
    [self.layer setBorderWidth:2];
    [self setHeaderLabelForCustomerAndVehicleInfoView];
    [self setLabelsForCustomerAndVehicleInfoView];
}

- (void)setFrameForCustomerAndVehicleInfoView {
    
}

- (void)setHeaderLabelForCustomerAndVehicleInfoView {
    if (self.customerAndVehicleLabel == nil) {
        UILabel *headerLabel = [[UILabel alloc] init];
        CGFloat x = 0, y = 0, width = self.frame.size.width, height = 35;
        [headerLabel setFrame:CGRectMake(x, y, width, height)];
        [headerLabel setText:@"   Customer & Vehicle Info"];
        [headerLabel setTag:1];
        [headerLabel setTextColor:[UIColor whiteColor]];
        [headerLabel setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
        [headerLabel setBackgroundColor:[UIColor ASRProBlueColor]];
        [self addSubview:headerLabel];
        [self setCustomerAndVehicleLabel:headerLabel];
    }
}

- (void)setLabelsForCustomerAndVehicleInfoView {
    CGFloat x ,y ,width ,height;
    
    if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] isCustomHeaderViewFullOrLight] isEqualToString:@"FULL"]) {
        x = 15, y = 40, width = 100, height = 25;
    }else {
        x = 78, y = 40 + 22, width = 100, height = 25;
    }
    
    __block CGFloat yPosition,VehicleYPosition;
    [self.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)object;
            if (label.tag != 1) {
                [label removeFromSuperview];
            }
        }else if ([object isKindOfClass:[UITextField class]]) {
            UITextField *textFiled = object;
            [textFiled removeFromSuperview];
        }else if ([object isKindOfClass:[UIButton class]]) {
            UIButton *button = object;
            [button removeFromSuperview];
        }
    }];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_].mStaticCustomerAndVehicleInfoArray_ enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        UILabel *labelLeft = [[UILabel alloc] init];
        UILabel *labelRight = [[UILabel alloc] init];
        UITextField *textFiledRight = [[UITextField alloc] init];
        UIButton *waiterButton = [[UIButton alloc] init];
        if (index == 0) {
            [labelLeft setFrame:CGRectMake(x, y, 250, height)];
            [labelLeft setText:[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_] mCustomerAndVehicleInfoArray_] valueForKey:object]];
            [labelLeft setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
            [labelLeft setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
            [self addSubview:labelLeft];
            if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] isCustomHeaderViewFullOrLight] isEqualToString:@"FULL"]) {
                yPosition = y + height;
            }else {
                yPosition = y + height + 10;
            }
            VehicleYPosition = y + height + 10;
        }else if(index == [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_].mStaticCustomerAndVehicleInfoArray_ count] - 1) {
            [labelLeft setFrame:CGRectMake(x, yPosition, width, height)];
            [labelLeft setText:object];
            [labelLeft setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
            [labelLeft setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
            [self addSubview:labelLeft];
            
            [labelRight setFrame:CGRectMake(x + width + 10, yPosition, width + 20, height)];
            [labelRight setText:[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_] mCustomerAndVehicleInfoArray_] valueForKey:object]];
            [labelRight setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
            [labelRight setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
            [self addSubview:labelRight];
            CGRect buttonFrame;
            if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] isCustomHeaderViewFullOrLight] isEqualToString:@"FULL"]) {
                buttonFrame = CGRectMake((self.frame.size.width - 130)/2, self.frame.size.height - 35 - 11, 130, 40);
            }else {
                buttonFrame = CGRectMake((self.frame.size.width - 130)/2, self.frame.size.height - 35 - 17, 130, 40);
            }
            [self setCustomerPlanButtonFrame:buttonFrame];
            UIImage *image = [UIImage imageNamed:@"profile"];
            CGRect buttonFrame1 = CGRectMake((self.frame.size.width - 28 - 10), (height + 10 - 28)/2, 28, 28);
            CGRect buttonFrame2 = CGRectMake((self.frame.size.width - 28 - 50), (height + 10 - 28)/2, 28, 28);

            [self setEditCustomerButtonFrame:buttonFrame2];
            [self setEditVehicleButtonFrame:buttonFrame1];

        }else if(index == [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_].mStaticCustomerAndVehicleInfoArray_ count] - 2) {
            [labelLeft setFrame:CGRectMake(x, yPosition, width, height)];
            [labelLeft setText:object];
            [labelLeft setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
            [labelLeft setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
            [self addSubview:labelLeft];
            
            [textFiledRight setFrame:CGRectMake(x + width + 10, yPosition, width + 45, height)];
            [textFiledRight setDelegate:self];
            [textFiledRight setText:[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_] mCustomerAndVehicleInfoArray_] valueForKey:object]];
            if ([[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_] mCustomerAndVehicleInfoArray_] valueForKey:object] length] == 0) {
                [textFiledRight setPlaceholder:@"Select Promised Time"];
            }
            [textFiledRight setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
            [textFiledRight setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
            [self addSubview:textFiledRight];
            [self setPromiseTimeTextField:textFiledRight];
            yPosition += height;
            if (self.waiterButton != nil) {
                [self enableOrDisablePromiseDateAndTimeFileds:self.waiterButton.selected];
            }
        }else if(index == [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_].mStaticCustomerAndVehicleInfoArray_ count] - 3) {
            [labelLeft setFrame:CGRectMake(x, yPosition, width, height)];
            [labelLeft setText:object];
            [labelLeft setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
            [labelLeft setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
            [self addSubview:labelLeft];
            
            [textFiledRight setFrame:CGRectMake(x + width + 10, yPosition, width + 45, height)];
            [textFiledRight setDelegate:self];
            [textFiledRight setTag:13];
            [textFiledRight setText:[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_] mCustomerAndVehicleInfoArray_] valueForKey:object]];
            if ([[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_] mCustomerAndVehicleInfoArray_] valueForKey:object] length] == 0) {
                [textFiledRight setPlaceholder:@"Select Promised Date"];
            }
            [textFiledRight setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
            [textFiledRight setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
            [self addSubview:textFiledRight];
            [self setPromiseDateTextField:textFiledRight];
            if (self.waiterButton.selected == NO && [[self.promiseDateTextField placeholder] isEqualToString:@"Select Promised Date"]) {
                [self setPromiseDateAndPromiseTimeForWaiter:self.promiseDateTextField promiseTimeTextFiled:nil];
                [self sendputRequestForChangingPromiseDateAndTime];
            }
            yPosition += height;
        }else if(index == [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_].mStaticCustomerAndVehicleInfoArray_ count] - 4) {
            [labelLeft setFrame:CGRectMake(x, yPosition, width, height)];
            [labelLeft setText:object];
            [labelLeft setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
            [labelLeft setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
            [self addSubview:labelLeft];
            
            UIImage *image = [UIImage imageNamed:@"IMG_uncheck-icon"];
            [waiterButton setFrame:CGRectMake(x + width + 10, yPosition, image.size.width, image.size.height)];
            [waiterButton addTarget:self action:@selector(waiterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [waiterButton setSelected:([[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_] mCustomerAndVehicleInfoArray_] valueForKey:object] boolValue])?TRUE:FALSE];
            [waiterButton setImage:[UIImage imageNamed:@"IMG_uncheck-icon"] forState:UIControlStateNormal];
            [waiterButton setImage:[UIImage imageNamed:@"IMG_check-icon"] forState:UIControlStateHighlighted];
            [waiterButton setImage:[UIImage imageNamed:@"IMG_check-icon"] forState:UIControlStateSelected];
            [self addSubview:waiterButton];
            [self setWaiterButton:waiterButton];
            yPosition += height;
        }else {
            if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] isCustomHeaderViewFullOrLight] isEqualToString:@"FULL"]) {
                [labelLeft setFrame:CGRectMake(x, yPosition, width, height)];
                [labelLeft setText:object];
                [labelLeft setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
                [labelLeft setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
                [self addSubview:labelLeft];
                
                [labelRight setFrame:CGRectMake(x + width + 10, yPosition, width + 50, height)];
                [labelRight setText:[NSString stringWithFormat:@"%@",[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_] mCustomerAndVehicleInfoArray_] valueForKey:object]]];
                [labelRight setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
                [labelRight setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
                [self addSubview:labelRight];
                yPosition += height;
            }else {
                if ([object isEqualToString:@"Year"] || [object isEqualToString:@"Make"] || [object isEqualToString:@"Model"] || [object isEqualToString:@"Mileage"] || [object isEqualToString:@"VIN"] || [object isEqualToString:@"License"]) {
                    [labelLeft setFrame:CGRectMake(361, VehicleYPosition, width, height)];
                    [labelLeft setText:object];
                    [labelLeft setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
                    [labelLeft setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
                    [self addSubview:labelLeft];
                    
                    [labelRight setFrame:CGRectMake(465, VehicleYPosition, width + 50, height)];
                    [labelRight setText:[NSString stringWithFormat:@"%@",[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_] mCustomerAndVehicleInfoArray_] valueForKey:object]]];
                    [labelRight setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
                    [labelRight setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
                    [self addSubview:labelRight];
                    VehicleYPosition += height;
                }else {
                    [labelLeft setFrame:CGRectMake(x, yPosition, width, height)];
                    [labelLeft setText:object];
                    [labelLeft setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
                    [labelLeft setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
                    [self addSubview:labelLeft];
                    
                    [labelRight setFrame:CGRectMake(x + width + 10, yPosition, width + 50, height)];
                    [labelRight setText:[NSString stringWithFormat:@"%@",[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_] mCustomerAndVehicleInfoArray_] valueForKey:object]]];
                    [labelRight setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
                    [labelRight setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
                    [self addSubview:labelRight];
                    yPosition += height;
                    
                }
            }
        }
    }];
    
}

- (void)setCustomerPlanButtonFrame :(CGRect)aButtonFrame {
    UIButton *customerPlanButton = [[UIButton alloc] init];
    [customerPlanButton setFrame:aButtonFrame];
    [customerPlanButton addTarget:self action:@selector(CustomerPlanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [customerPlanButton setBackgroundColor:[UIColor ASRProBlueColor]];
    [customerPlanButton setTitle:@"Customer Plan" forState:UIControlStateNormal];
    [customerPlanButton setTitle:@"Customer Plan" forState:UIControlStateSelected];
    [[customerPlanButton titleLabel] setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
    [self setMCustomerPlanButton_:customerPlanButton];
    [self addSubview:self.mCustomerPlanButton_];
}

- (void)setEditCustomerButtonFrame :(CGRect)aButtonFrame {
    UIImage *image = [UIImage imageNamed:@"profile"];
    UIButton *editCustomerButton = [[UIButton alloc] init];
    [editCustomerButton setFrame:aButtonFrame];
    [editCustomerButton addTarget:self action:@selector(customerEditButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [editCustomerButton setTitle:@"" forState:UIControlStateNormal];
    [editCustomerButton setTitle:@"" forState:UIControlStateSelected];
    [editCustomerButton setImage:image forState:UIControlStateNormal];
    [editCustomerButton setImage:image forState:UIControlStateSelected];
    [self addSubview:editCustomerButton];
}

- (void)setEditVehicleButtonFrame :(CGRect)aButtonFrame {
    UIImage *image = [UIImage imageNamed:@"vehicle"];
    UIButton *editCustomerButton = [[UIButton alloc] init];
    [editCustomerButton setFrame:aButtonFrame];
    [editCustomerButton addTarget:self action:@selector(vehicleEditButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [editCustomerButton setTitle:@"" forState:UIControlStateNormal];
    [editCustomerButton setTitle:@"" forState:UIControlStateSelected];
    [editCustomerButton setImage:image forState:UIControlStateNormal];
    [editCustomerButton setImage:image forState:UIControlStateSelected];
    [self addSubview:editCustomerButton];
}

- (IBAction)customerEditButtonAction:(id)sender {
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mCheckInViewController_] displayEditCustomerPopup];
}

- (IBAction)vehicleEditButtonAction:(id)sender {
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mCheckInViewController_] displayEditVehiclePopup];
}

- (IBAction)CustomerPlanButtonAction:(id)sender {
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelforOpenROSupportEngine_ setMGetServiceReference_:MAINVIEWCONTROLLER];
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelforOpenROSupportEngine_ RequestForCustomerPlanPDF:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mRONumber_];
    
    //    [[CheckInSupportWebEngine checkInSharedInstance] putRequestForROToBeMovedToDispatchMode];
}

- (IBAction)waiterButtonAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    [self enableOrDisablePromiseDateAndTimeFileds:button.selected];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForCheckIn_.waiter = button.selected;
    [[CheckInSupportWebEngine checkInSharedInstance] putRequestForChangingPromiseDateAndTime];
}

#define kDateFormat @"MM/dd/yyyy"
#define kTimeFormat @"hh:mm a"
- (void)setPromiseDateAndPromiseTimeForWaiter :(UITextField *)aPromiseDateTextFiled promiseTimeTextFiled:(UITextField *)aPromiseTimeTextFiled {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc]init];
    
    NSTimeZone *gmtZone = [NSTimeZone systemTimeZone];
    [dateFormat setTimeZone:gmtZone];
    [timeFormat setTimeZone:gmtZone];
    NSLocale *enLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
    dateFormat.locale = enLocale;
    timeFormat.locale = enLocale;
    
    [dateFormat setDateFormat:kDateFormat];
    [timeFormat setDateFormat:kTimeFormat];
    
    aPromiseDateTextFiled.text = [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:date]];
    //    aPromiseTimeTextFiled.text = [NSString stringWithFormat:@"%@", [timeFormat stringFromDate:date]];
    
    [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForCheckIn_.mPromisedDate_ = aPromiseDateTextFiled.text;
    //    [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForCheckIn_.mPromisedTime_ = aPromiseTimeTextFiled.text;
}

- (void)sendputRequestForChangingPromiseDateAndTime {
    [[CheckInSupportWebEngine checkInSharedInstance] putRequestForChangingPromiseDateAndTime];
    
}

- (void)enableOrDisablePromiseDateAndTimeFileds:(BOOL)aSelected {
    __block UITextField *promiseDate;
    __block UITextField *promiseTime;
    [[self subviews] enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[UITextField class]]) {
            if (((UITextField *)object).tag == 13) {
                promiseDate = object;
            }else {
                promiseTime = object;
            }
        }
    }];
    if (aSelected) {
        [promiseDate setBackgroundColor:[UIColor lightGrayColor]];
        [promiseDate setEnabled:FALSE];
        [promiseDate setText:@""];
        [promiseDate setPlaceholder:@"Select Promised Date"];
        [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForCheckIn_.mPromisedDate_ = @"";
        [promiseTime setBackgroundColor:[UIColor lightGrayColor]];
        [promiseTime setEnabled:FALSE];
        [promiseTime setText:@""];
        [promiseTime setPlaceholder:@"Select Promised Time"];
        [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForCheckIn_.mPromisedTime_ = @"";
        
    }else {
        [promiseDate setBackgroundColor:[UIColor whiteColor]];
        [promiseDate setEnabled:TRUE];
        if ([[promiseDate placeholder] isEqualToString:@"Select Promised Date"]) {
            [self setPromiseDateAndPromiseTimeForWaiter:self.promiseDateTextField promiseTimeTextFiled:nil];
        }
        [promiseTime setBackgroundColor:[UIColor whiteColor]];
        [promiseTime setEnabled:TRUE];
    }
}

#pragma mark --
#pragma mark TextField Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 13) {
        PopOverViewControllerForDatePickerView  *myViewControllerForPopover = [[PopOverViewControllerForDatePickerView alloc] initWithNibName:@"PopOverViewControllerForDatePickerView" bundle:nil ];
        myViewControllerForPopover.mPopOverDatePIckerDelegate_ = self;
        myViewControllerForPopover.modalPresentationStyle = UIModalPresentationPageSheet;
        myViewControllerForPopover.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        myViewControllerForPopover.view.superview.bounds = CGRectMake(0, 0,320, 260);
        
        [myViewControllerForPopover setMDateFormatType_:DATE_FORMAT];
        [myViewControllerForPopover setMDummyTextField_:textField];
        self.mPopoverController = [[UIPopoverController alloc] initWithContentViewController:myViewControllerForPopover];
        self.mPopoverController.popoverContentSize = CGSizeMake(320, 260);
        [self.mPopoverController presentPopoverFromRect:textField.frame inView:textField.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [self.mPopoverController setDelegate:self];
        [myViewControllerForPopover displayDatePicker];
        return NO;
    }else {
        PopOverViewControllerForDatePickerView  *myViewControllerForPopover = [[PopOverViewControllerForDatePickerView alloc] initWithNibName:@"PopOverViewControllerForDatePickerView" bundle:nil ];
        myViewControllerForPopover.mPopOverDatePIckerDelegate_=self;
        [myViewControllerForPopover setMDateFormatType_:TIME_FORMAT];
        [myViewControllerForPopover setMDummyTextField_:textField];
        myViewControllerForPopover.modalPresentationStyle = UIModalPresentationPageSheet;
        myViewControllerForPopover.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        myViewControllerForPopover.view.superview.bounds = CGRectMake(0, 0,320, 260);
        self.mPopoverController = [[UIPopoverController alloc] initWithContentViewController:myViewControllerForPopover];
        self.mPopoverController.popoverContentSize = CGSizeMake(320, 260);
        [self.mPopoverController presentPopoverFromRect:textField.frame inView:textField.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [self.mPopoverController setDelegate:self];
        [myViewControllerForPopover displayDatePicker];
        return NO;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

#pragma mark --
#pragma mark  MyPopover delegate

-(void)didClickDoneButton {
    if ([self.mPopoverController isPopoverVisible]) {
        [self.mPopoverController dismissPopoverAnimated:YES];
    }
}

#pragma mark --
#pragma mark UIPopoverController delegate

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    if (popoverController == self.mPopoverController) {
    }
}

@end
