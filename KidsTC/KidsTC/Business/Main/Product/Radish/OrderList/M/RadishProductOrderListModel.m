//
//  RadishProductOrderListModel.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductOrderListModel.h"

@implementation RadishProductOrderListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data":[RadishProductOrderListItem class]};
}
@end

