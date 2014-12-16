//
//  InspectionFormPopupViewController.m
//  ASRPro
//
//  Created by Kalyani on 01/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "InspectionFormPopupViewController.h"

@interface InspectionFormPopupViewController ()

@end

@implementation InspectionFormPopupViewController
@synthesize mDropDownTable_;
@synthesize mDropDown_;

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
    // Do any additional setup after loading the view from its nib.
    [self intTheViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)intTheViews{
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    [mDropDownTable_ setFrame:CGRectMake(0, 30, 300, 270)];
    [[GenericFiles genericFiles] createUIButtonInstance:mDropDown_ buttonTitle:@"" buttonTitleColor:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    [mDropDownTable_.layer setBorderColor:[UIColor blackColor].CGColor];
    [mDropDownTable_.layer setBorderWidth:1.0];
    [mDropDownTable_ setSeparatorStyle:UITableViewCellSeparatorStyleNone];

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormsArray_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            CustomButtonForDropDown* mCustomButtonForDropDown_=[[CustomButtonForDropDown alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height-1)];
   // Configure the cell...
        [mCustomButtonForDropDown_ setTag:1];
   [cell.contentView addSubview:mCustomButtonForDropDown_];
        UIView*mTempView=[[UIView alloc] initWithFrame:CGRectMake(0, 29, cell.contentView.frame.size.width, 1)];
        [mTempView setBackgroundColor:[UIColor blackColor]];
        [cell.contentView addSubview:mTempView];
    }
    [self resetTableViews:cell];
    [self populateFormsSectionWithIndexPath:indexPath cell:cell tableView:tableView];
    cell.accessoryType=UITableViewCellAccessoryNone;
  //  cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    return cell;
}


- (void)resetTableViews:(UITableViewCell*)tableViewCell  {
	// reset UILabels;
        CustomButtonForDropDown *lUILabel = (CustomButtonForDropDown*)[tableViewCell viewWithTag:1];
        [lUILabel setTitle:nil forState:UIControlStateNormal];
}

- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView  {
 
    CustomButtonForDropDown *lCustomButtonForDropDown = (CustomButtonForDropDown*)[tableViewCell.contentView viewWithTag:1];
    [[GenericFiles genericFiles] createUIButtonInstance:lCustomButtonForDropDown buttonTitle:[[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormsArray_ objectAtIndex:indexPath.row] objectForKey:@"Name"] buttonTitleColor:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];

    [lCustomButtonForDropDown setMFormDict_:[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormsArray_ objectAtIndex:indexPath.row]];
    [lCustomButtonForDropDown addTarget:self action:@selector(DropDownClicked:) forControlEvents:UIControlEventTouchUpInside];

   }

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Row pressed!!");
  
}

- (IBAction)DroDownButtonAction:(id)sender {
    UIButton* lTempButton=(UIButton*)sender;
    if(lTempButton.isSelected)
    {
        [self.view setFrame:CGRectMake(5, 98, 300, 31)];
        [lTempButton setSelected:FALSE];
    }
    else{
        [self.view setFrame:CGRectMake(5,98, 300, 300)];
        [lTempButton setSelected:TRUE];
 
    }
}

-(void)DropDownClicked:(CustomButtonForDropDown*)sender{
    [self.view setFrame:CGRectMake(5, 98, 300, 31)];

    [mDropDown_ setTitle:[sender.mFormDict_ objectForKey:@"Name"] forState:UIControlStateNormal];
    [mDropDown_ setMFormDict_:sender.mFormDict_];
    [mDropDown_ setSelected:FALSE];

}

-(void)hideInspectionForm{
    if(mDropDown_.isSelected){
    [self.view setFrame:CGRectMake(5, 98, 300, 31)];
        [mDropDown_ setSelected:FALSE];

    }

}

@end
@implementation CustomButtonForDropDown

@synthesize mFormDict_;

@end
