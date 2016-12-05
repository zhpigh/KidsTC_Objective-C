//
//  ProductOrderFreeListStore.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ProductOrderFreeListStore : NSObject
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *mapAddress;
@end
