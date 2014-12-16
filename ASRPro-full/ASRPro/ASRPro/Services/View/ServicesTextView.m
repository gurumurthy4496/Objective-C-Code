//
//  ServicesTextView.m
//  ASRPro
//
//  Created by Kalyani on 10/29/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "ServicesTextView.h"
@interface ServicesTextView()
{
        UIToolbar  *mToolBar_;
}
@end

@implementation ServicesTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setTextColor:[UIColor blackColor]];
        [self setUserInteractionEnabled:YES];
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [[UIColor grayColor] CGColor];
        self.layer.backgroundColor=[[UIColor whiteColor] CGColor];
        [self setFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey]];
        [self setReturnKeyType:UIReturnKeyDefault];
        self.enablesReturnKeyAutomatically=NO;
        [self inputviewForKeyboard];
        [self setDelegate:self];
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

#pragma mark -  ******************* UI methods ******************

//-------------------------------------- ************** ----------------------------------------
//                         *** add clear and done to keyboard  ***
//-------------------------------------- ************** ----------------------------------------
- (void)inputviewForKeyboard
{
    mToolBar_= [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.superview.bounds.size.width, 44)];
    [mToolBar_ setBarStyle:UIBarStyleDefault];
   // [mToolBar_ setTranslucent:YES];
    UIBarButtonItem *lflexibleButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace                                                                                     target:self action:nil];
    UIBarButtonItem *lCancelButtonItem=[[UIBarButtonItem alloc] initWithTitle:@" Clear " style:UIBarButtonItemStyleBordered target:self action:@selector(cancel_Event:)];
    lCancelButtonItem.tag=1;
    UIBarButtonItem *lDoneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" Done " style:UIBarButtonItemStyleDone target:self action:@selector(done_Event:)];
    lDoneBarButtonItem.tag=2;
    [mToolBar_ setItems:[NSArray arrayWithObjects:lflexibleButtonItem,lCancelButtonItem,lDoneBarButtonItem,nil]];

    self.inputAccessoryView=mToolBar_;
}

#pragma mark -  ******************* Button Action  methods ******************

//-------------------------------------- ************** ----------------------------------------
//                         *** button action when clear button is clicked  ***
//-------------------------------------- ************** ----------------------------------------
- (void)cancel_Event:(id)sender
{
    
    self.text=@"";

}

//-------------------------------------- ************** ----------------------------------------
//                         *** button action when done button is clicked  ***
//-------------------------------------- ************** ----------------------------------------
- (void)done_Event:(id)sender
{
  //  [self endEditing:YES];
    [self changeData];

}

-(void)changeData{
    switch(self.tag){
        case KSERVICEPOPUP_DETAILS:{
            [[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] setMDetails_:self.text];
            break;
        }
        case KSERVICEPOPUP_NOTES:{
               if([[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForSplashScreen_.mUserRole_  isEqualToString:@"Advisor"])
            [[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] setMAdvisorNotes_:self.text];
               else   if([[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForSplashScreen_.mUserRole_  isEqualToString:@"Technician"])
                   [[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] setMTechnicianNotes_:self.text];
               else   if([[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForSplashScreen_.mUserRole_  isEqualToString:@"Manager"])
                   [[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] setMManagerNotes_:self.text];


            break;
        }
        case KSERVICEPOPUP_LABOR:{
            if(![[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_]mPriceLabor_ ] isEqualToString:self.text]){
            [[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_]->isCustomLabour_=TRUE;
            
            [[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] setMPriceLabor_:self.text];
            }
            break;
        }
        case KSERVICEPOPUP_PARTS:{
            if(![[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_]mPriceParts_ ] isEqualToString:self.text]){

            [[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_]->isCustomParts_=TRUE;

            [[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] setMPriceParts_:self.text];
            }
            break;
        }
        case KSERVICEPOPUP_PRICE:{
            if(![[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_]mPrice_ ] isEqualToString:self.text]){

            [[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_]->isCustomPrice_=TRUE;

            [[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] setMPrice_:self.text];
            }
            break;
            
        }
        case KSERVICEPOPUP_COMPLAINT:{
            [[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] setMComplaint_:self.text];
            break;
            
        }
        case KSERVICEPOPUP_CAUSE:{
            [[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] setMCause_:self.text];
            break;
        }
        case KSERVICEPOPUP_CORRECTION:{
            [[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] setMCorrection_:self.text];
            break;
        }
    }
    
    [self resignFirstResponder];

    lAddServiceTableViewController->selectedsection=0;
    [lAddServiceTableViewController.tableView reloadData];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    switch(self.tag){
        case KSERVICEPOPUP_DETAILS:{
            [[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mAddServiceTableViewController_].view setFrame:CGRectMake(0, 37, 600, 486)];
          //  [[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mAddServiceTableViewController_].tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:KSERVICEPOPUP_DETAILS] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            break;
        }
        case KSERVICEPOPUP_NOTES:{
            [[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mAddServiceTableViewController_].view setFrame:CGRectMake(0, 37, 600, 486)];

         //  [[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mAddServiceTableViewController_].tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:KSERVICEPOPUP_NOTES] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            break;
        }
        case KSERVICEPOPUP_LABOR:{
            [[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mAddServiceTableViewController_].view setFrame:CGRectMake(0, 37, 600, 486-180)];

          // [[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mAddServiceTableViewController_].tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:KSERVICEPOPUP_LABOR] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            break;
        }
        case KSERVICEPOPUP_PARTS:{
            [[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mAddServiceTableViewController_].view setFrame:CGRectMake(0,37, 600, 486-180)];

        //   [[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mAddServiceTableViewController_].tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:KSERVICEPOPUP_PARTS] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            break;
        }
        case KSERVICEPOPUP_PRICE:{
            [[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mAddServiceTableViewController_].view setFrame:CGRectMake(0, 37, 600, 486-180)];

         //  [[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mAddServiceTableViewController_].tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:KSERVICEPOPUP_PRICE] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            break;
            
        }
        case KSERVICEPOPUP_COMPLAINT:{
            [[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mAddServiceTableViewController_].view setFrame:CGRectMake(0, 37, 600, 486-180)];

         //  [[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mAddServiceTableViewController_].tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:KSERVICEPOPUP_COMPLAINT] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            break;
            
        }
        case KSERVICEPOPUP_CAUSE:{
            [[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mAddServiceTableViewController_].view setFrame:CGRectMake(0, 37, 600, 486-180)];

          // [[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] /mAddServiceTableViewController_].tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:KSERVICEPOPUP_CAUSE] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            break;
        }
        case KSERVICEPOPUP_CORRECTION:{
            [[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mAddServiceTableViewController_].view setFrame:CGRectMake(0, 37, 600, 486-180)];
         //    [[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mAddServiceTableViewController_].tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:KSERVICEPOPUP_CORRECTION] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            break;
        }
    }

}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mAddServiceTableViewController_].view setFrame:CGRectMake(0, 37, 600, 486)];

    [self changeData];
}

@end
