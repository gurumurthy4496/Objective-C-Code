//
//  ServicesNavigationController.m
//  ASRPro
//
//  Created by Kalyani on 17/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ServicesNavigationController.h"

@interface ServicesNavigationController ()

@end

@implementation ServicesNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}
@end
