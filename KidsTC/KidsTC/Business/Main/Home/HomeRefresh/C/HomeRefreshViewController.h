//
//  HomeRefreshViewController.h
//  KidsTC
//
//  Created by zhanping on 2016/9/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//


#import "WebViewController.h"
@interface HomeRefreshViewController : WebViewController
@property (nonatomic, copy) void (^resultBlock)();
@end