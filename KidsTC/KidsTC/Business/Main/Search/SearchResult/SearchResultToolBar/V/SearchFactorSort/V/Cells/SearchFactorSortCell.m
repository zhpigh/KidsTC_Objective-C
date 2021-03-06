//
//  SearchFactorSortCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorSortCell.h"
#import "Colours.h"

@interface SearchFactorSortCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *checkImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation SearchFactorSortCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.HLineH.constant = LINE_H;
}

- (void)setItem:(SearchFactorSortDataItem *)item {
    _item = item;
    self.img.image = [UIImage imageNamed:_item.img];
    self.title.text = _item.title;
    self.checkImg.hidden = !_item.selected;
    self.title.textColor = _item.selected?COLOR_PINK:[UIColor colorFromHexString:@"555555"];
}

- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) {
        self.actionBlock(_item);
    }
}


@end
