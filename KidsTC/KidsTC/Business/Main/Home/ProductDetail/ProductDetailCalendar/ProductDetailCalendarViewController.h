//
//  ProductDetailCalendarViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "ProductDetailTimeItem.h"

@interface ProductDetailCalendarViewController : ViewController
@property (nonatomic, strong) NSArray<ProductDetailTimeItem *> *times;
@end