//
//  ScoreProductData.m
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreProductData.h"
#import "NSString+Category.h"

@implementation ScoreProductData
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"products":[ScoreProductItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (![_title isNotNull]) _title = @"会员精选";
    return YES;
}
@end
