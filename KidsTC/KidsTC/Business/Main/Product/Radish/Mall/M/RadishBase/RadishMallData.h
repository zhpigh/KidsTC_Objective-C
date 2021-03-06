//
//  RadishMallData.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RadishMallIcon.h"
#import "RadishMallProduct.h"
#import "RadishMallBanner.h"
#import "RadishUserData.h"

@interface RadishMallData : NSObject

@property (nonatomic, strong) NSString *ruleUrl;
@property (nonatomic, assign) BOOL isNeedLoadBackUrl;
@property (nonatomic, strong) NSString *backUrl;
@property (nonatomic, strong) NSArray<RadishMallIcon *> *icons;
@property (nonatomic, strong) NSArray<RadishMallProduct *> *topProducts;
@property (nonatomic, strong) NSArray<RadishMallProduct *> *hotProducts;
@property (nonatomic, strong) NSArray<RadishMallBanner *> *banners;
//selfDeine
@property (nonatomic, strong) NSArray<RadishMallProduct *> *showProducts;
@property (nonatomic, strong) RadishUserData *userData;
@end
