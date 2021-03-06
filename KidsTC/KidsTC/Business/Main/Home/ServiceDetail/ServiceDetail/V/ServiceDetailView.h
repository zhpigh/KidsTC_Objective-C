//
//  ServiceDetailView.h
//  KidsTC
//
//  Created by 钱烨 on 7/13/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDetailModel.h"
#import "ServiceDetailMoreInfoView.h"

@class ServiceDetailView;

@protocol ServiceDetailViewDataSource <NSObject>

- (ServiceDetailModel *)detailModelForServiceDetailView:(ServiceDetailView *)detailView;

@end

@protocol ServiceDetailViewDelegate <NSObject>

- (void)didClickedCouponOnServiceDetailView:(ServiceDetailView *)detailView;

- (void)serviceDetailView:(ServiceDetailView *)detailView didChangedMoreInfoViewTag:(ServiceDetailMoreInfoViewTag)viewTag;

- (void)serviceDetailView:(ServiceDetailView *)detailView didClickedStoreCellAtIndex:(NSUInteger)index;

- (void)serviceDetailView:(ServiceDetailView *)detailView didClickedCommentCellAtIndex:(NSUInteger)index;

- (void)didClickedMoreCommentOnServiceDetailView:(ServiceDetailView *)detailView;

- (void)serviceDetailView:(ServiceDetailView *)detailView didScrolledAtOffset:(CGPoint)offset;

- (void)serviceDetailView:(ServiceDetailView *)detailView didSelectedLinkWithSegueModel:(SegueModel *)model;

- (void)didClickedStoreBriefOnServiceDetailView:(ServiceDetailView *)detailView;

- (void)didClickedAllRelatedServiceOnServiceDetailView:(ServiceDetailView *)detailView;

- (void)serviceDetailView:(ServiceDetailView *)detailView didSelectedRelatedServiceAtIndex:(NSUInteger)index;

- (void)serviceDetailViewDidClickSeleteMeal:(ServiceDetailView *)detailView;
@end

@interface ServiceDetailView : UIView

@property (nonatomic, assign) id<ServiceDetailViewDataSource> dataSource;
@property (nonatomic, assign) id<ServiceDetailViewDelegate> delegate;

- (void)setIntroductionUrlString:(NSString *)urlString;

- (void)reloadData;

@end
