//
//  DropDownView.m
//  ASRPro
//
//  Created by Kalyani on 14/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "DropDownView.h"

@implementation DropDownView
@synthesize mDropDownButton_;
@synthesize mDropDownTable_;
@synthesize mkeysArray_;
@synthesize mTempArray_;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       // [self initTheVIews];
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

-(void)initTheVIews :(int)height{
   maxheight=[mTempArray_ count]*40;
    if(maxheight>height)
        maxheight=height;
    mDropDownButton_=[[CustomButtonForDropDownView alloc ] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 38)];
    [mDropDownButton_ addTarget:self action:@selector(buttonclicked:) forControlEvents:UIControlEventTouchUpInside];
    mDropDownTable_=[[UITableView alloc ] initWithFrame:CGRectMake(0, 38, self.frame.size.width, maxheight)];
    [[GenericFiles genericFiles] createUIButtonInstance:mDropDownButton_ buttonTitle:@"" buttonTitleColor:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 10) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
  [mDropDownTable_.layer setBorderColor:[UIColor colorWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1.0].CGColor];
    
    
    [mDropDownTable_.layer setBorderWidth:1.0];
    [mDropDownTable_ setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [mDropDownTable_ setDataSource:self];
    [mDropDownTable_ setDelegate:self];
    [self addSubview:mDropDownTable_];
    [self addSubview:mDropDownButton_];
    [self setBackgroundColor:[UIColor whiteColor]];
   [self setClipsToBounds:YES];


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [mTempArray_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        CustomButtonForDropDownView* mCustomButtonForDropDown_=[[CustomButtonForDropDownView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, cell.contentView.frame.size.height-2)];
        // Configure the cell...
        [mCustomButtonForDropDown_ setTag:1];
        [mCustomButtonForDropDown_ addTarget:self action:@selector(DropDownClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:mCustomButtonForDropDown_];
        UIView*mTempView=[[UIView alloc] initWithFrame:CGRectMake(0, cell.contentView.frame.size.height-2, self.frame.size.width, 1)];
        [mTempView setBackgroundColor:[UIColor colorWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1.0]];
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
    
    CustomButtonForDropDownView *lCustomButtonForDropDown = (CustomButtonForDropDownView*)[tableViewCell.contentView viewWithTag:1];
    [[GenericFiles genericFiles] createUIButtonInstance:lCustomButtonForDropDown buttonTitle:[[mTempArray_ objectAtIndex:indexPath.row] objectForKey:[mkeysArray_ objectAtIndex:0]] buttonTitleColor:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    if(mkeysArray_!=nil){
    [lCustomButtonForDropDown setMFormDict_:[mTempArray_ objectAtIndex:indexPath.row]];
    }
    else{
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0;
}

#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    DLog(@"Row pressed!!");
//    
//}

- (void)buttonclicked:(id)sender {

    UIButton* lTempButton=(UIButton*)sender;
    if(lTempButton.isSelected)
    {
        CGRect frame=self.frame;
        frame.size.height=38;
        [self setFrame:frame];
//        frame=self.frame;
//        frame.size.height=30;
//        [self setFrame:frame];

        [self.superview bringSubviewToFront:self];
        [self bringSubviewToFront:self.mDropDownTable_];
        [lTempButton setSelected:FALSE];
        if([self.delegate respondsToSelector:@selector(changeHeight:Tag:View:)]) {
            [self.delegate changeHeight:38 Tag:self.tag View:self];
        }

    }
    else{

        CGRect frame=self.frame;
        frame.size.height=maxheight+38;
        [self setFrame:frame];
//        frame=self.superview.frame;
//        frame.size.height=maxheight+30;
//        [self.superview setFrame:frame];
//        
        [self.superview bringSubviewToFront:self];
        [self bringSubviewToFront:self.mDropDownTable_];

        [lTempButton setSelected:TRUE];

        if([self.delegate respondsToSelector:@selector(changeHeight:Tag:View:)]) {
            [self.delegate changeHeight:maxheight+38 Tag:self.tag View:self];
        }

    }
}

-(void)DropDownClicked:(CustomButtonForDropDownView*)sender{

    CGRect frame=self.frame;
    frame.size.height=38;
    [self setFrame:frame];
//    frame=self.superview.frame;
//    frame.size.height=40;
//    [self.superview setFrame:frame];

    [self.superview.superview bringSubviewToFront:self.superview];
    [mDropDownButton_ setMFormDict_:sender.mFormDict_];

    [mDropDownButton_ setTitle:[sender.mFormDict_ objectForKey:[mkeysArray_ objectAtIndex:0]]];
    [mDropDownButton_ setSelected:FALSE];
    if([self.delegate respondsToSelector:@selector(changeHeight:Tag:View:)]) {
        [self.delegate changeHeight:38 Tag:self.tag View:self];
    }

}

-(void)hideDropDown{
    if([mDropDownButton_ isSelected]){

    CGRect frame=self.frame;
    frame.size.height=38;
    [self setFrame:frame];
    
    [self.superview bringSubviewToFront:self];
    [mDropDownButton_ setSelected:FALSE];
        if([self.delegate respondsToSelector:@selector(changeHeight:Tag:View:)]) {
            [self.delegate changeHeight:38 Tag:self.tag View:self];
        }

    }
}


@end
@implementation CustomButtonForDropDownView

@synthesize mFormDict_;
-(void)setTitle:(NSString *)title{
    if([title isEqualToString:@""])
    {
        [self setTitle:@"(Tap to input)" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    else{
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  
    }
    
}
@end


