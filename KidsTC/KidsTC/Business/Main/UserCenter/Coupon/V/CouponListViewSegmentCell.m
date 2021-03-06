//
//  CouponListViewSegmentCell.m
//  KidsTC
//
//  Created by 钱烨 on 9/6/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "CouponListViewSegmentCell.h"

@interface CouponListViewSegmentCell ()

@property (weak, nonatomic) IBOutlet UIView *tagView;

@end

@implementation CouponListViewSegmentCell

- (void)awakeFromNib {
    // Initialization code
    [self.tagView setHidden:YES];
    [self.contentView setBackgroundColor:COLOR_BG_CEll];
    [self.tagView setBackgroundColor:COLOR_PINK];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected) {
        [self.titleLabel setTextColor:COLOR_PINK];
        [self.tagView setHidden:NO];
    } else {
        [self.titleLabel setTextColor:[UIColor darkGrayColor]];
        [self.tagView setHidden:YES];
    }
}

@end
