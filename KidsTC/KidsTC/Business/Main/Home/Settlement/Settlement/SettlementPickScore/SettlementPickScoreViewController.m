//
//  SettlementPickScoreViewController.m
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "SettlementPickScoreViewController.h"
#import "iToast.h"

@interface SettlementPickScoreViewController ()
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIView *scoreInputBGView;
@property (weak, nonatomic) IBOutlet UITextField *scoreInputTf;
@property (weak, nonatomic) IBOutlet UILabel *reachMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineTwoConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineConstraintWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *AlertViewConstraintBottomMargin;

@end

@implementation SettlementPickScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTheme = NaviThemeWihte;
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.HLineConstraintHeight.constant = LINE_H;
    self.HLineTwoConstraintHeight.constant = LINE_H;
    self.VLineConstraintWidth.constant = LINE_H;
    
    self.cancleBtn.tag = ServiceSettlementPickScoreActionTypeCancle;
    self.sureBtn.tag = ServiceSettlementPickScoreActionTypeSure;
    
    self.scoreInputTf.layer.cornerRadius = 4;
    self.scoreInputTf.layer.masksToBounds = YES;
    self.scoreInputTf.layer.borderColor = [UIColor colorFromHexString:@"CBCBCB"].CGColor;
    self.scoreInputTf.layer.borderWidth = 1;
    [self.scoreInputTf addTarget:self action:@selector(textFieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.alertView.hidden = YES;
    
    self.totalScoreNumLabel.text = [NSString stringWithFormat:@"%zd",self.scoreNum];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self show];
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}
- (IBAction)cancle:(UIButton *)sender {
    [self hide];
}
- (IBAction)sure:(UIButton *)sender {
    [self hide];
    if (self.resultBlock) {
        NSUInteger numVlaue = [self.scoreInputTf.text integerValue];
        self.resultBlock(numVlaue);
    }
}

- (void)show{
    self.AlertViewConstraintBottomMargin.constant = - CGRectGetHeight(self.alertView.frame);
    [self.view layoutIfNeeded];
    self.alertView.hidden = NO;
    self.view.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        self.AlertViewConstraintBottomMargin.constant = 0;
        [self.view layoutIfNeeded];
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    } completion:^(BOOL finished) {
        [self.scoreInputTf becomeFirstResponder];
    }];
}

- (void)hide{
    [self.scoreInputTf resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        self.view.backgroundColor = [UIColor clearColor];
        self.AlertViewConstraintBottomMargin.constant = - CGRectGetHeight(self.alertView.frame);
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self back];
    }];
}

- (void)textFieldTextDidChange:(UITextField *)textField {
    NSUInteger numVlaue = [textField.text integerValue];
    if (textField.text.length>0) {
        NSString *regex = @"^[1-9]\\d{0,}$";
        NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL validate = [pred evaluateWithObject:textField.text];
        if (!validate) {
            [[iToast makeText:@"请输入合法积分数值"] show];
        }
    }
    if (numVlaue>self.scoreNum) {
        NSString *tipStr = [NSString stringWithFormat:@"最多只可使用%zd积分",self.scoreNum];
        [[iToast makeText:tipStr] show];
        numVlaue = self.scoreNum;
    }
    textField.text = numVlaue>0?[NSString stringWithFormat:@"%zd",numVlaue]:@"";
    self.reachMoneyLabel.text = [NSString stringWithFormat:@"%0.1f元",numVlaue/10.0];
    //[textField resignFirstResponder];
    //[textField becomeFirstResponder];
    [self.view layoutIfNeeded];
}

- (void)keyboardWillShow:(NSNotification *)noti {
    [super keyboardWillShow:noti];
    self.AlertViewConstraintBottomMargin.constant = self.keyboardHeight;
    [self.view layoutIfNeeded];
}

- (void)keyboardWillDisappear:(NSNotification *)noti {
    [super keyboardWillDisappear:noti];
    self.AlertViewConstraintBottomMargin.constant = 0;
    [self.view layoutIfNeeded];
}

@end
