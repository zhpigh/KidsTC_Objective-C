//
//  AccountCenterOrdersCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterOrdersCell.h"

#import "TipButton.h"
#define BTN_TITLE_HEIGHT 13
#define BTN_TITLE_BOTTOM_MARGIN 18
#define BTN_IMAGE_SIZE 24
#define BTN_TOP_MARGIN 18
@interface AccountCenterOrderButton : TipButton
@end
@implementation AccountCenterOrderButton
- (void)awakeFromNib{
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageX = (CGRectGetWidth(contentRect)-BTN_IMAGE_SIZE)*0.5;
    return CGRectMake(imageX, BTN_TOP_MARGIN, BTN_IMAGE_SIZE, BTN_IMAGE_SIZE);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleW = CGRectGetWidth(contentRect);
    CGFloat titleY = CGRectGetHeight(contentRect)-BTN_TITLE_HEIGHT-BTN_TITLE_BOTTOM_MARGIN;
    return CGRectMake(0, titleY, titleW, BTN_TITLE_HEIGHT);
}
@end

@interface AccountCenterOrdersCell ()
@property (weak, nonatomic) IBOutlet UIView *allOrderBGView;
@property (weak, nonatomic) IBOutlet UIView *HLine;
@property (weak, nonatomic) IBOutlet UIView *OrdersBGView;
@property (weak, nonatomic) IBOutlet UIButton *allOrderBtn;
@property (weak, nonatomic) IBOutlet AccountCenterOrderButton *waitPayBtn;
@property (weak, nonatomic) IBOutlet AccountCenterOrderButton *waitUseBtn;
@property (weak, nonatomic) IBOutlet AccountCenterOrderButton *waitReceiptBtn;
@property (weak, nonatomic) IBOutlet AccountCenterOrderButton *waitCommentBtn;
@property (weak, nonatomic) IBOutlet AccountCenterOrderButton *refundBtn;
@end

@implementation AccountCenterOrdersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.allOrderBtn.tag = AccountCenterCellActionTypeAllOrder;
    self.waitPayBtn.tag = AccountCenterCellActionTypeWaitPay;
    self.waitUseBtn.tag = AccountCenterCellActionTypeWaitUse;
    self.waitReceiptBtn.tag = AccountCenterCellActionTypeWaitReceipt;
    self.waitCommentBtn.tag = AccountCenterCellActionTypeWaitComment;
    self.refundBtn.tag = AccountCenterCellActionTypeRefund;
}

- (IBAction)action:(AccountCenterOrderButton *)sender {
    if ([self.delegate respondsToSelector:@selector(accountCenterBaseCell:actionType:value:)]) {
        [self.delegate accountCenterBaseCell:self actionType:sender.tag value:nil];
    }
}

- (void)setModel:(AccountCenterModel *)model {
    [super setModel:model];
    
    AccountCenterUserCount *userCount = model.data.userCount;
    
    self.waitPayBtn.badgeValue = userCount.order_wait_pay;
    self.waitUseBtn.badgeValue = userCount.order_wait_use;
    self.waitCommentBtn.badgeValue = userCount.order_wait_evaluate;
}


@end