//
//  ServicePackageCell.m
//  ASRPro
//
//  Created by Kalyani on 19/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ServicePackageCell.h"

@implementation ServicePackageCell
@synthesize mLabel;
@synthesize mPrice;
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


-(void)addViewToCell :(BOOL)aSection withText:(NSString*)aText withPrice:(NSString*)aPrice {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self removeSubviews];
    [self setMLabel:aText];
    [self setMPrice:aPrice];
    section=aSection;
    if(aSection==TRUE)
        [self addFastMover];
    else
        [self addChildSGID];
    
    UIView* lTempView=[[UIView alloc]initWithFrame:self.frame];
    [lTempView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:lTempView ];

}

-(void)removeSubviews{
    for (UIView *subview in [self.contentView subviews])
    {
        [subview removeFromSuperview];
    }
    
}

-(void)addFastMover {
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    UIImageView* lImgView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 20, 20)];
    [lImgView setImage:kFAST_MOVER_ICON_SERVICEPACKAGE];
    [self.contentView addSubview:lImgView];
    UILabel* lTempLabel=[[UILabel alloc] initWithFrame:CGRectMake(30, 10, 150, 20)];
    [[GenericFiles genericFiles]createUILabelWithInstance:lTempLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:mLabel labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:lTempLabel];
    if(![mPrice isEqualToString:@""]){
        UILabel* lTempPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake(190, 10, 80, 20)];
        [[GenericFiles genericFiles]createUILabelWithInstance:lTempPriceLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"$%@",mPrice] labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:lTempPriceLabel];
    }
    UIView* lDividerLine=[[UILabel alloc] initWithFrame:CGRectMake(0, 39, self.frame.size.width, 1)];
    [lDividerLine setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:lDividerLine];

    
}

-(void)addChildSGID{
    [self.contentView setBackgroundColor:[UIColor colorWithRed:(19.0/255.0) green:(124.0/255.0) blue:(253.0/255.0) alpha:1.0]];
    UILabel* lTempLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 5, 250, 20)];
    [[GenericFiles genericFiles]createUILabelWithInstance:lTempLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:mLabel labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:lTempLabel];
    UIView* lDividerLine=[[UILabel alloc] initWithFrame:CGRectMake(0, 39, self.frame.size.width, 1)];
    [lDividerLine setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:lDividerLine];

}




@end
