//
//  SectionViewWalkAround.m
//  ASRPro
//
//  Created by Krishna kuchimanchi on 16/05/13.
//  Copyright (c) 2013 Value Labs. All rights reserved.
//

#import "SectionViewWalkAround.h"

#define kImage_Width 79
#define kImage_Height 29


@implementation SectionViewWalkAround

@synthesize section;
@synthesize sectionTitle;
@synthesize discButton;
@synthesize delegate;

+ (Class)layerClass {
    
    return [CAGradientLayer class];
}

- (id)initWithFrame:(CGRect)frame WithTitle: (NSString *) title Section:(NSInteger)sectionNumber delegate: (id <SectionViewWalkAround>) Delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(discButtonPressed:)];
        [self addGestureRecognizer:tapGesture];
        self.userInteractionEnabled = YES;
        
        self.section = sectionNumber;
        self.delegate = Delegate;
        
        CGRect LabelFrame = self.bounds;
        CGRectInset(LabelFrame, 0.0, 5.0);
        //----- UIIMAGE-VIEW -----
        UIImageView *lImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (frame.size.height-27)/2, kImage_Width, kImage_Height)];
        [lImageView setBackgroundColor:[UIColor clearColor]];
        title = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
        [lImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",title]]];
        [self addSubview:lImageView];
        //----- UILABEL -----
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15 + lImageView.frame.size.width,0,self.frame.size.width - (lImageView.frame.size.width + 15 + 10), frame.size.height)];
        label.text = title;
        label.font = [UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        sectionTitle = label;
        //----- UIBUTTON -----
        CGRect buttonFrame = CGRectMake(LabelFrame.size.width, 0, 50, LabelFrame.size.height);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = buttonFrame;
        [button setBackgroundColor:[UIColor clearColor]];
        [button addTarget:self action:@selector(discButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        self.discButton = button;
        CALayer *topBorder = [CALayer layer];
        topBorder.borderColor = [UIColor whiteColor].CGColor;
        topBorder.borderWidth = 1;
        topBorder.frame = CGRectMake(frame.origin.x, sectionTitle.frame.size.height-1, frame.size.width, 1);
        [self.layer addSublayer:topBorder];
        [self setBackgroundColor:[UIColor ASRProBlueColor]];
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
