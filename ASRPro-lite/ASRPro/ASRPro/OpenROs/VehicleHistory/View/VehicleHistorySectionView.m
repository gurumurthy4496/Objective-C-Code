//
//  VehicleHistorySectionView.m
//  ASRPro
//
//  Created by GuruMurthy on 26/10/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "VehicleHistorySectionView.h"

@implementation VehicleHistorySectionView

@synthesize section;
@synthesize mRONumber;
@synthesize mCreateDate;
@synthesize delegate;

+ (Class)layerClass {
    
    return [CAGradientLayer class];
}

- (id)initWithFrame:(CGRect)frame WithRONumber: (NSString *)aRONumber CreateDate:(NSString *)aCreateDate Section:(NSInteger) aSectionNumber currentMode:(int)aCurrentMode delegate: (id <VehicleHistorySectionView>)aDelegate  {

    self = [super initWithFrame:frame];
    if (self) {
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(discButtonPressed:)];
        [self addGestureRecognizer:tapGesture];
        
        self.userInteractionEnabled = YES;
        
        self.section = aSectionNumber;
        self.delegate = aDelegate;
        
        [self setBackgroundColor:[UIColor whiteColor]];
        // ----------------------------;
        // RO# Label;
        // ----------------------------;
        
        CGSize lROlabelWidth = [aRONumber sizeWithFont:[UIFont regularFontOfSize:17 fontKey:kFontNameHelveticaNeueKey]];
        
        UILabel *lRoNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, lROlabelWidth.width, frame.size.height)];
        lRoNumberLabel.text = aRONumber;
        lRoNumberLabel.font = [UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey];
        lRoNumberLabel.backgroundColor = [UIColor clearColor];
        lRoNumberLabel.textColor = [UIColor blackColor];
        lRoNumberLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:lRoNumberLabel];
        self.mRONumber = lRoNumberLabel;
        RELEASE_NIL(lRoNumberLabel);
        
        // ----------------------------;
        // Date Label;
        // ----------------------------;
        
        CGSize lCreateDateLabelWidth = [aRONumber sizeWithFont:[UIFont regularFontOfSize:20 fontKey:kFontNameHelveticaNeueKey]];
        
         NSString *lTempCreatedDate = (aCreateDate != nil) ?aCreateDate :@"";
        
        
        UILabel *lDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(300 + 50, 0, lCreateDateLabelWidth.width+20, frame.size.height)];
        lDateLabel.text = lTempCreatedDate;
        lDateLabel.font = [UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey];
        lDateLabel.backgroundColor = [UIColor clearColor];
        lDateLabel.textColor = [UIColor blackColor];
        
        if (aCurrentMode != 100) {
             NSString *lCurrentDateStr = ([lTempCreatedDate isEqualToString:@""])?@"":NSLocalizedString(@"lCurrentlyOpenRO", @"lCurrentlyOpenRO");
            lDateLabel.text = lCurrentDateStr;
            lDateLabel.textColor = [UIColor ASRProCustomAlertSelectedStateColor];
        }
        
        lDateLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:lDateLabel];
        self.mCreateDate = lDateLabel;
        RELEASE_NIL(lDateLabel);
        
        // ----------------------------;
        // Date Label;
        // ----------------------------;
        
        UIImage *lDiscloserImage = [UIImage imageNamed:@"down-arrow"];
        
        CGRect buttonFrame = CGRectMake(frame.size.width - lDiscloserImage.size.width - 20, (frame.size.height - lDiscloserImage.size.height)/2, lDiscloserImage.size.width, lDiscloserImage.size.height);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = buttonFrame;
        [button setImage:[UIImage imageNamed:@"right-arrow"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"down-arrow"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(discButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setHidden:NO];
        if ([aRONumber isEqualToString:NSLocalizedString(@"lNoVehicleHistoryFound", @"lNoVehicleHistoryFound")]) {
            [button setHidden:YES];
        }
        [self addSubview:button];
        self.discButton = button;
        CALayer *topBorder = [CALayer layer];
        topBorder.borderColor = [UIColor lightGrayColor].CGColor;
        topBorder.borderWidth = 1;
        topBorder.frame = CGRectMake(frame.origin.x, frame.size.height-1, frame.size.width, 1);
        [self.layer addSublayer:topBorder];
        
    }
    return self;
}

- (void) discButtonPressed : (id) sender
{
    [self toggleButtonPressed:TRUE];
}

- (void) toggleButtonPressed : (BOOL) flag
{
    self.discButton.selected = !self.discButton.selected;
    if(flag)
    {
        if (self.discButton.selected)
        {
            if ([self.delegate respondsToSelector:@selector(sectionOpened:)])
            {
                [self.delegate sectionOpened:self.section];
            }
        } else
        {
            if ([self.delegate respondsToSelector:@selector(sectionClosed:)])
            {
                [self.delegate sectionClosed:self.section];
            }
        }
    }
}

@end