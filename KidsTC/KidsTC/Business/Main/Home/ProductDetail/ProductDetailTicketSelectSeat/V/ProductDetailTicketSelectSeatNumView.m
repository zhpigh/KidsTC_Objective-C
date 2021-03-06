//
//  ProductDetailTicketSelectSeatNumView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/19.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ProductDetailTicketSelectSeatNumView.h"
#import "Colours.h"
#import "iToast.h"
#import "ServiceSettlementBuyNumTfInputView.h"

@interface ProductDetailTicketSelectSeatNumView ()<UITextFieldDelegate,ServiceSettlementBuyNumTfInputViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *numContainer;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UIView *VLineOne;
@property (weak, nonatomic) IBOutlet UIView *VLineTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineOneH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineTwoH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineTwoH;
@end

@implementation ProductDetailTicketSelectSeatNumView

- (void)awakeFromNib {
    [super awakeFromNib];
    UIColor *borderColor = [UIColor colorFromHexString:@"dedede"];
    UIColor *grayColor = [UIColor colorFromHexString:@"222222"];
    
    self.numContainer.layer.cornerRadius = 4;
    self.numContainer.layer.masksToBounds = YES;
    self.numContainer.layer.borderColor = borderColor.CGColor;
    self.numContainer.layer.borderWidth = LINE_H;
    self.VLineOne.backgroundColor = borderColor;
    self.VLineTwo.backgroundColor = borderColor;
    self.VLineOneH.constant = LINE_H;
    self.VLineTwoH.constant = LINE_H;
    self.HLineTwoH.constant = LINE_H;
    self.tf.textColor = grayColor;
    [self.addBtn setTitleColor:grayColor forState:UIControlStateNormal];
    [self.reduceBtn setTitleColor:grayColor forState:UIControlStateNormal];
    
    self.tipL.textColor = grayColor;
    
    ServiceSettlementBuyNumTfInputView *inputView = [[NSBundle mainBundle] loadNibNamed:@"ServiceSettlementBuyNumTfInputView" owner:self options:nil].firstObject;
    inputView.delegate = self;
    inputView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    self.tf.inputAccessoryView = inputView;
    
    [self layoutIfNeeded];
    
    [NotificationCenter addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)setSeat:(ProductDetailTicketSelectSeatSeat *)seat {
    _seat = seat;
    self.tf.text = [NSString stringWithFormat:@"%zd",_seat.count];
    [self setupEnable];
}

- (IBAction)reduce:(UIButton *)sender {
    NSInteger count = self.tf.text.integerValue;
    self.tf.text = [NSString stringWithFormat:@"%zd",--count];
    [self resetText];
    [self setupEnable];
    [self checkTextFieldChange];
    [self layoutIfNeeded];
}

- (IBAction)add:(UIButton *)sender {
    NSInteger count = self.tf.text.integerValue;
    self.tf.text = [NSString stringWithFormat:@"%zd",++count];
    [self resetText];
    [self setupEnable];
    [self checkTextFieldChange];
    [self layoutIfNeeded];
}

- (void)setupEnable {
    NSInteger count = self.tf.text.integerValue;
    
    if (count<=self.seat.minBuyNum) {
        self.reduceBtn.enabled = NO;
    }else{
        self.reduceBtn.enabled = YES;
    }
    if (count>=self.seat.maxBuyNum) {
        self.addBtn.enabled = NO;
    }else{
        self.addBtn.enabled = YES;
    }
    if (self.reduceBtn.enabled==NO && self.addBtn.enabled == NO) {
        self.tf.enabled = NO;
    }else{
        self.tf.enabled = YES;
    }
}

- (void)resetText {
    
    if (self.seat==nil) return;
    
    NSInteger count = self.tf.text.integerValue;
    if (count<self.seat.minBuyNum) {
        [[iToast makeText:[NSString stringWithFormat:@"最小购买数量%zd",self.seat.minBuyNum]] show];
        self.tf.text = [NSString stringWithFormat:@"%zd",self.seat.minBuyNum];
    }
    if (count>self.seat.maxBuyNum) {
        [[iToast makeText:[NSString stringWithFormat:@"最大购买数量%zd",self.seat.maxBuyNum]] show];
        self.tf.text = [NSString stringWithFormat:@"%zd",self.seat.maxBuyNum];
    }
}

- (void)checkTextFieldChange{
    if ([self.delegate respondsToSelector:@selector(productDetailTicketSelectSeatNumView:actionType:value:)]) {
        [self.delegate productDetailTicketSelectSeatNumView:self actionType:ProductDetailTicketSeatNumActionTypeBuyCountDidChange value:self.tf.text];
    }
}

#pragma mark - addObserverMethod

- (void)textFieldTextDidChange {
    [self setupEnable];
    [self layoutIfNeeded];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self resetText];
    [self setupEnable];
    [self checkTextFieldChange];
    [self layoutIfNeeded];
}

#pragma mark - ServiceSettlementBuyNumTfInputViewDelegate
- (void)serviceSettlementBuyNumTfInputView:(ServiceSettlementBuyNumTfInputView *)view actionType:(ServiceSettlementBuyNumTfInputViewActionType)type value:(id)value {
    [self.tf resignFirstResponder];
}

- (void)dealloc
{
    [NotificationCenter removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

@end
