//
//  WholesaleOrderDetailToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WholesaleOrderDetailData.h"

extern CGFloat const kWholesaleOrderDetailToolBarH;

typedef enum : NSUInteger {
    WholesaleOrderDetailToolBarActionTypeShare = 50,//分享
    WholesaleOrderDetailToolBarActionTypeHome,//首页
    WholesaleOrderDetailToolBarActionTypeBuy,//去支付
    WholesaleOrderDetailToolBarActionTypeMySale,//用户自己的拼团信息
    WholesaleOrderDetailToolBarActionTypeProductHome,//更多拼团
} WholesaleOrderDetailToolBarActionType;

@class WholesaleOrderDetailToolBar;
@protocol WholesaleOrderDetailToolBarDelegate <NSObject>
- (void)wholesaleOrderDetailToolBar:(WholesaleOrderDetailToolBar *)toolBar actionType:(WholesaleOrderDetailToolBarActionType)type value:(id)value;
@end

@interface WholesaleOrderDetailToolBar : UIView
@property (nonatomic, strong) WholesaleOrderDetailData *data;
@property (nonatomic, weak) id<WholesaleOrderDetailToolBarDelegate> delegate;
@end
