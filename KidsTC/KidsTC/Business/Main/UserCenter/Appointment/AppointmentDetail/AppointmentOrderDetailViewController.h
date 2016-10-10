//
//  AppointmentOrderDetailViewController.h
//  KidsTC
//
//  Created by 钱烨 on 8/12/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "ViewController.h"
@class AppointmentOrderModel;
@class AppointmentOrderDetailViewController;

@protocol AppointmentOrderDetailViewControllerDelegate <NSObject>

- (void)AppointmentOrderDetailViewController:(AppointmentOrderDetailViewController *)vc didCanceledOrderWithId:(NSString *)orderId;

@end

@interface AppointmentOrderDetailViewController : ViewController

@property (nonatomic, assign) id<AppointmentOrderDetailViewControllerDelegate> delegate;

- (instancetype)initWithAppointmentOrderModel:(AppointmentOrderModel *)model;

@end
