//
//  ServiceCommentListViewHeaderCell.m
//  KidsTC
//
//  Created by 钱烨 on 7/29/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "ServiceCommentListViewHeaderCell.h"

@implementation ServiceCommentListViewHeaderCell

- (void)awakeFromNib {
    // Initialization code
    [self.contentView setBackgroundColor:COLOR_BG_CEll];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end