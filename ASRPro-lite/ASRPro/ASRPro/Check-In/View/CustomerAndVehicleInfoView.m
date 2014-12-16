//
//  CustomerAndVehicleInfoView.m
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "CustomerAndVehicleInfoView.h"

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
    UILabel *headerLabel = [[UILabel alloc] init];
     CGFloat x = 0, y = 0, width = self.frame.size.width, height = 30;
    [headerLabel setFrame:CGRectMake(x, y, width, height)];
    [headerLabel setText:@"   Customer & Vehicle Info"];
    [headerLabel setTag:1];
    [headerLabel setTextColor:[UIColor whiteColor]];
    [headerLabel setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
    [headerLabel setBackgroundColor:[UIColor ASRProBlueColor]];
    [self addSubview:headerLabel];
}

- (void)setLabelsForCustomerAndVehicleInfoView {
    CGFloat x = 15, y = 35, width = 150, height = 25;
    __block CGFloat yPosition, VehicleYPosition;
    [self.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)object;
            if (label.tag != 1) {
                [label removeFromSuperview];
            }
        }else if ([object isKindOfClass:[UITextField class]]) {
            UITextField *textFiled = object;
            [textFiled removeFromSuperview];
        }
    }];
    DLog(@"%@",[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_].mStaticCustomerAndVehicleInfoArray_);
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_].mStaticCustomerAndVehicleInfoArray_ enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        UILabel *labelLeft = [[UILabel alloc] init];
        UILabel *labelRight = [[UILabel alloc] init];
        UITextField *textFiledRight = [[UITextField alloc] init];
        if (index == 0) {
            [labelLeft setFrame:CGRectMake(x, y, 250, height)];
            [labelLeft setText:[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_] mCustomerAndVehicleInfoArray_] valueForKey:object]];
            [labelLeft setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
            [labelLeft setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
            [self addSubview:labelLeft];
            yPosition = y + height;
            VehicleYPosition = y + height;
            
        }else if(index == [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_].mStaticCustomerAndVehicleInfoArray_ count] - 1) {
            [labelLeft setFrame:CGRectMake(x, yPosition, width, height)];
            [labelLeft setText:object];
            [labelLeft setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
            [labelLeft setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
            [self addSubview:labelLeft];
            
            [labelRight setFrame:CGRectMake(x + width + 10, yPosition, width + 20, height)];
            [labelRight setText:[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_] mCustomerAndVehicleInfoArray_] valueForKey:object]];
            [labelRight setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
            [labelRight setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
            [self addSubview:labelRight];
            CGRect buttonFrame = CGRectMake((self.frame.size.width - 130)/2, self.frame.size.height - 35 - 17, 130, 40);
            [self setCustomerPlanButtonFrame:buttonFrame];
        }else if(index == [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_].mStaticCustomerAndVehicleInfoArray_ count] - 2) {
            [labelLeft setFrame:CGRectMake(x, yPosition, width, height)];
            [labelLeft setText:object];
            [labelLeft setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
            [labelLeft setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
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
            yPosition += height;
        }else if(index == [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_].mStaticCustomerAndVehicleInfoArray_ count] - 3) {
            [labelLeft setFrame:CGRectMake(x, yPosition, width, height)];
            [labelLeft setText:object];
            [labelLeft setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
            [labelLeft setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
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
            yPosition += height;
        }else {
            if ([object isEqualToString:@"Year"] || [object isEqualToString:@"Make"] || [object isEqualToString:@"Model"] || [object isEqualToString:@"Mileage"] || [object isEqualToString:@"VIN"]) {
                [labelLeft setFrame:CGRectMake(361, VehicleYPosition, width, height)];
                [labelLeft setText:object];
                [labelLeft setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
                [labelLeft setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
                [self addSubview:labelLeft];
                
                [labelRight setFrame:CGRectMake(465, VehicleYPosition, width + 50, height)];
                [labelRight setText:[NSString stringWithFormat:@"%@",[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_] mCustomerAndVehicleInfoArray_] valueForKey:object]]];
                [labelRight setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
                [labelRight setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
                [self addSubview:labelRight];
                VehicleYPosition += height;
            }else {
                [labelLeft setFrame:CGRectMake(x, yPosition, width, height)];
                [labelLeft setText:object];
                [labelLeft setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
                [labelLeft setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
                [self addSubview:labelLeft];
                
                [labelRight setFrame:CGRectMake(x + width + 10, yPosition, width + 50, height)];
                [labelRight setText:[NSString stringWithFormat:@"%@",[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_] mCustomerAndVehicleInfoArray_] valueForKey:object]]];
                [labelRight setTextColor:[UIColor ASRProRGBColor:90 Green:88 Blue:89]];
                [labelRight setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
                [self addSubview:labelRight];
                yPosition += height;

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
    [[customerPlanButton titleLabel] setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
    [self setMCustomerPlanButton_:customerPlanButton];
    [self addSubview:self.mCustomerPlanButton_];
}

- (IBAction)CustomerPlanButtonAction:(id)sender {
//    [[CheckInSupportWebEngine checkInSharedInstance] putRequestForROToBeMovedToDispatchMode];
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
        [myViewControllerForPopover displayDatePicker];
        self.mPopoverController = [[UIPopoverController alloc] initWithContentViewController:myViewControllerForPopover];
        self.mPopoverController.popoverContentSize = CGSizeMake(320, 260);
        [self.mPopoverController presentPopoverFromRect:textField.frame inView:textField.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [self.mPopoverController setDelegate:self];
        return NO;
    }else {
        PopOverViewControllerForDatePickerView  *myViewControllerForPopover = [[PopOverViewControllerForDatePickerView alloc] initWithNibName:@"PopOverViewControllerForDatePickerView" bundle:nil ];
        myViewControllerForPopover.mPopOverDatePIckerDelegate_=self;
        [myViewControllerForPopover setMDateFormatType_:TIME_FORMAT];
        [myViewControllerForPopover setMDummyTextField_:textField];
        [myViewControllerForPopover displayDatePicker];
        myViewControllerForPopover.modalPresentationStyle = UIModalPresentationPageSheet;
        myViewControllerForPopover.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        myViewControllerForPopover.view.superview.bounds = CGRectMake(0, 0,320, 260);
        self.mPopoverController = [[UIPopoverController alloc] initWithContentViewController:myViewControllerForPopover];
        self.mPopoverController.popoverContentSize = CGSizeMake(320, 260);
        [self.mPopoverController presentPopoverFromRect:textField.frame inView:textField.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [self.mPopoverController setDelegate:self];
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
