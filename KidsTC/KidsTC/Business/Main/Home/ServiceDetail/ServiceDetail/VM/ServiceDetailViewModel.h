//
//  ServiceDetailViewModel.h
//  KidsTC
//
//  Created by 钱烨 on 8/15/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//


#import "ServiceDetailView.h"

@interface ServiceDetailViewModel : NSObject
@property (nonatomic, strong, readonly) ServiceDetailModel *detailModel;

- (instancetype)initWithView:(UIView *)view;

- (void)startUpdateDataWithServiceId:(NSString *)serviceId channelId:(NSString *)channelId Succeed:(void (^)(NSDictionary *data))succeed failure:(void (^)(NSError *error))failure;

- (void)addToSettlementWithBuyCount:(NSUInteger)count
                        storeId:(NSString *)storeId
                        succeed:(void (^)(NSDictionary *data))succeed
                        failure:(void (^)(NSError *error))failure;

- (void)addOrRemoveFavouriteWithSucceed:(void (^)(NSDictionary *data))succeed failure:(void (^)(NSError *error))failure;

- (void)resetMoreInfoViewWithViewTag:(ServiceDetailMoreInfoViewTag)viewTag;

@end