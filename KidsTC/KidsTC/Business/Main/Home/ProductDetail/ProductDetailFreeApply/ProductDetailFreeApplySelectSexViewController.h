//
//  ProductDetailFreeApplySelectSexViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"

@interface ProductDetailFreeApplySelectSexViewController : ViewController
@property (nonatomic, assign) TCSexType sex;
@property (nonatomic, copy) void(^makeSureBlock)(NSDictionary *sexDic);
@end
