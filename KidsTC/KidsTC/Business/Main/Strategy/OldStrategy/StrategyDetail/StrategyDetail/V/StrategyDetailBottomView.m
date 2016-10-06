//
//  StrategyDetailBottomView.m
//  KidsTC
//
//  Created by Altair on 1/22/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "StrategyDetailBottomView.h"
#import "ToolBox.h"

@interface StrategyDetailBottomView ()

@property (weak, nonatomic) IBOutlet UIView *leftBGView;
@property (weak, nonatomic) IBOutlet UIView *gapView;
@property (weak, nonatomic) IBOutlet UIView *rightBGView;
@property (weak, nonatomic) IBOutlet UILabel *leftTagLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTagLabel;

- (void)didClickedLeft;
- (void)didClickedRight;

@end

@implementation StrategyDetailBottomView

#pragma mark Initialization


- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self = [super awakeAfterUsingCoder:aDecoder];
    static BOOL bLoad;
    if (!bLoad)
    {
        bLoad = YES;
        StrategyDetailBottomView *view = [ToolBox getObjectFromNibWithView:self];
        [view buildSubviews];
        return view;
    }
    bLoad = NO;
    return self;
}

- (void)buildSubviews {
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedLeft)];
    [self.leftBGView addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedRight)];
    [self.rightBGView addGestureRecognizer:tap2];
    
    [self.leftTagLabel setTextColor:COLOR_PINK];
    self.leftTagLabel.layer.cornerRadius = 9;
    self.leftTagLabel.layer.borderColor = COLOR_PINK.CGColor;
    self.leftTagLabel.layer.borderWidth = LINE_H;
    
    [self.rightTagLabel setTextColor:COLOR_TEXT];
    self.rightTagLabel.layer.cornerRadius = 9;
    self.rightTagLabel.layer.borderColor = COLOR_TEXT.CGColor;
    self.rightTagLabel.layer.borderWidth = LINE_H;
}


- (void)didClickedLeft {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickedLeftButtonOnStrategyDetailBottomView:)]) {
        [self.delegate didClickedLeftButtonOnStrategyDetailBottomView:self];
    }
}


- (void)didClickedRight {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickedRightButtonOnStrategyDetailBottomView:)]) {
        [self.delegate didClickedRightButtonOnStrategyDetailBottomView:self];
    }
}

- (void)hideLeftTag:(BOOL)hideLeft rightTag:(BOOL)hideRight {
    [self.leftTagLabel setHidden:hideLeft];
    [self.rightTagLabel setHidden:hideRight];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end