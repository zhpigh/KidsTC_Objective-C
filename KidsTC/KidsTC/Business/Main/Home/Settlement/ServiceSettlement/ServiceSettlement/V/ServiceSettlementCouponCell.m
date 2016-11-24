//
//  ServiceSettlementCouponCell.m
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementCouponCell.h"

@interface ServiceSettlementCouponCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *tipView;
@property (weak, nonatomic) IBOutlet UIView *couponBGView;
@property (weak, nonatomic) IBOutlet UIView *couponDescBGView;
@property (weak, nonatomic) IBOutlet UILabel *couponTipL;
@property (weak, nonatomic) IBOutlet UILabel *promotionTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreTipL;

@property (weak, nonatomic) IBOutlet UILabel *couponDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponPriceTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponTipLabel;

@property (weak, nonatomic) IBOutlet UIView *scoreBGView;
@property (weak, nonatomic) IBOutlet UILabel *scoreTipLabel;
@property (weak, nonatomic) IBOutlet UITextField *scoreInputTf;
@property (weak, nonatomic) IBOutlet UILabel *useScoreTipLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation ServiceSettlementCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tipView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    self.couponTipL.textColor = [UIColor colorFromHexString:@"222222"];
    self.scoreTipL.textColor = [UIColor colorFromHexString:@"222222"];
    self.promotionTipLabel.textColor = COLOR_YELL;
    self.useScoreTipLabel.textColor = [UIColor colorFromHexString:@"555555"];
    
    self.couponDescBGView.backgroundColor = COLOR_PINK;
    self.couponDescBGView.layer.cornerRadius = 2;
    self.couponDescBGView.layer.masksToBounds = YES;
    
    self.couponPriceTipLabel.textColor = COLOR_PINK;
    
    self.HLineConstraintHeight.constant = LINE_H;
    self.scoreInputTf.textColor = COLOR_PINK;
    self.scoreInputTf.layer.borderWidth = LINE_H;
    self.scoreInputTf.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    
    UITapGestureRecognizer *couponTapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGRAction:)];
    [self.couponBGView addGestureRecognizer:couponTapGR];
    
    [self layoutIfNeeded];
}

- (void)setItem:(ServiceSettlementDataItem *)item{
    [super setItem:item];
    
    /**
     *  =====================优惠券====================
     */
    NSUInteger count = item.coupon.count;
    self.couponDescBGView.hidden = !(count>0);
    self.couponBGView.userInteractionEnabled = count>0;
    if (!self.couponDescBGView.hidden) {
        self.couponDescLabel.text = [NSString stringWithFormat:@"共%zd张可用",count];
    }
    self.couponPriceTipLabel.hidden = !item.maxCoupon;
    if (!self.couponPriceTipLabel.hidden) {
        self.couponPriceTipLabel.text = item.maxCoupon.desc;
    }
    
    NSString *couponTip = @"";
    if (count==0) {
        couponTip = @"不可使用";
    }else{
        if (item.maxCoupon) {
            couponTip = @"已使用";
        }else {
            couponTip = @"未使用";
        }
    }
    self.couponTipLabel.text = couponTip;
    
    /**
     *  ======================积分=====================
     */
    NSString *scorenumStr = [NSString stringWithFormat:@"%zd",item.scorenum];
    NSString *scorenumTip = [NSString stringWithFormat:@"共%@积分可使用",scorenumStr];
    UIFont *font = [UIFont systemFontOfSize:12];
    NSDictionary *att = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:scorenumTip
                                                                              attributes:att];
    [attStr addAttribute:NSForegroundColorAttributeName value:COLOR_PINK range:[scorenumTip rangeOfString:scorenumStr]];
    self.scoreTipLabel.attributedText = attStr;
    
    self.scoreInputTf.hidden = !(item.scorenum>0);
    if (!self.scoreInputTf.hidden) {
        self.scoreInputTf.text = @(item.usescorenum).stringValue;
    }
    self.useScoreTipLabel.text = item.scorenum>0?@"积分":@"不可使用";
}

- (void)tapGRAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(serviceSettlementBaseCell:actionType:value:)]) {
        [self.delegate serviceSettlementBaseCell:self actionType:ServiceSettlementBaseCellActionTypeCoupon value:nil];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([self.delegate respondsToSelector:@selector(serviceSettlementBaseCell:actionType:value:)]) {
        [self.delegate serviceSettlementBaseCell:self actionType:ServiceSettlementBaseCellActionTypeScore value:nil];
    }
    return NO;
}

@end
