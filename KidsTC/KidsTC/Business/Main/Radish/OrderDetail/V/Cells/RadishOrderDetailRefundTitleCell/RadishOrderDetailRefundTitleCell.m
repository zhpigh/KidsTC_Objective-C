//
//  RadishOrderDetailRefundTitleCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailRefundTitleCell.h"

@interface RadishOrderDetailRefundTitleCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation RadishOrderDetailRefundTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
