//
//  ServicesScheduledCell.m
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ServicesScheduledCell.h"

@implementation ServicesScheduledCell
@synthesize mServicesDict_;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)addViewToCell{
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self removeSubviews];
    if(self.contentView.tag%2==0)
        [ self.contentView setBackgroundColor:[UIColor whiteColor]];
    else
        [ self.contentView setBackgroundColor:[UIColor colorWithRed:(236.0/255.0) green:(240.0/255.0) blue:(241.0/255.0) alpha:1.0]];
    [self addCurrentServicesCell];
}



-(void)removeSubviews{
    for (UIView *subview in [self.contentView subviews]){
        [subview removeFromSuperview];
    }
}

-(void)addCurrentServicesCell{
    UIView *lCellView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 690, self.contentView.frame.size.height)];
    [lCellView setBackgroundColor:[UIColor clearColor]];
    lCellView.clipsToBounds=YES;
    
    //Service Label
    UILabel* lTempServiceLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 10, SERVICE_LABEL_WIDTH_SCHEDULED, 20)];
    [lTempServiceLabel setTag:SERVICE_LABEL_TAG_SCHEDULED];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempServiceLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[mServicesDict_  objectForKey:@"ServiceName"] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [lTempServiceLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [lCellView addSubview:lTempServiceLabel];
    
    //Accesory Button
    ServicesApproveButton* lTempApproveButton = [[ServicesApproveButton alloc] initWithFrame:CGRectMake(660, 15, APPROVE_BUTTON_WIDTH_SCHEDULED, 20)];
    [lTempApproveButton setApprovestate:UNDECIDEDSTATE];
    if([[self.mServicesDict_ objectForKey:@"Approved" ] boolValue])
        [lTempApproveButton setApprovestate:APPROVESTATE];
    if([[self.mServicesDict_ objectForKey:@"Declined" ] boolValue])
        [lTempApproveButton setApprovestate:DECLINESTATE];
    

    [lTempApproveButton setTag:APPROVE_BUTTON_TAG_SCHEDULED];
    [lTempApproveButton setApprovestate:UNDECIDEDSTATE];
    [lTempApproveButton addTarget:self action:@selector(isApproveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [lCellView addSubview:lTempApproveButton];
    [self.contentView addSubview:lCellView];
}

-(void)isApproveButtonClicked:(ServicesApproveButton*)sender{
    if([sender approvestate]==APPROVESTATE){
        [sender setApprovestate:DECLINESTATE];
        [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForApproveServiceLine:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ LineID:[self.mServicesDict_ objectForKey:KID] ApproveDict:[[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID",@"false",@"Data", nil] mutableCopy]];
    }
    else if([sender approvestate]==DECLINESTATE){
        [sender setApprovestate:UNDECIDEDSTATE];
        [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForApproveServiceLine:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ LineID:[self.mServicesDict_ objectForKey:KID] ApproveDict:[[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID", nil] mutableCopy]];
    }
    else if([sender approvestate]==UNDECIDEDSTATE){
        [sender setApprovestate:APPROVESTATE];
        [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForApproveServiceLine:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ LineID:[self.mServicesDict_ objectForKey:KID] ApproveDict:[[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID",@"true",@"Data", nil] mutableCopy]];
        
        
    }
}

@end
