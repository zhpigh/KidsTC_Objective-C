//
//  ProductDetailData.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//
#import "ProductDetailPromotionLink.h"
#import "ProductDetailBuyNotice.h"
#import "ProductDetailComment.h"
#import "ProduceDetialCommentItem.h"
#import "ProdectDetailCoupon.h"
#import "ProductDetailInsurance.h"
#import "ProductDetailNote.h"
#import "ProductDetailShare.h"
#import "ProductDetailStandard.h"
#import "ProductDetailStore.h"
#import "ProductDetailTime.h"
#import "RecommendProduct.h"
#import "CommentListItemModel.h"
#import "ProductDetailConsultItem.h"
#import "CommonShareObject.h"
#import "ProductDetailActor.h"
#import "ProductDetailTheater.h"
#import "ProductDetailPromise.h"
#import "ProductDetailOnlineBespeak.h"
#import "ProductDetailEnrollInfo.h"
#import "ProductDetailFreeRelatedProduct.h"
#import "ProductDetailCountDown.h"
#import "ProductDetailPlace.h"
#import "ProductDetailSecKillInfo.h"
#import "VideoPlayVideoRes.h"
#import "ProductDetailActivity.h"

typedef enum : NSUInteger {
    TCProductTypeService = 1,//服务
    TCProductTypeActivity = 2,//活动
    TCProductTypeMaterialObject = 3//实物
} TCProductType;

typedef enum : NSUInteger {
    ProductDetailUseValidTimeTypeLong = 1,//长期有效
    ProductDetailUseValidTimeTypePartTime,//时间区间有效
} ProductDetailUseValidTimeType;

typedef enum : NSUInteger {
    ProductDetailTwoColumnShowTypeDetail=100,//详情
    ProductDetailTwoColumnShowTypeConsult//咨询
} ProductDetailTwoColumnShowType;

@interface ProductDetailData : NSObject
@property (nonatomic, strong) NSString *serveId;
@property (nonatomic, strong) NSString *chId;
@property (nonatomic, assign) PriceSort priceSort;
@property (nonatomic, strong) NSString *priceSortName;
@property (nonatomic, strong) NSString *simpleName;
@property (nonatomic, strong) NSString *serveName;
@property (nonatomic, strong) NSString *promote;
@property (nonatomic, assign) TCProductType productType;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray<NSString *> *applyContent;
@property (nonatomic, strong) NSArray<ProductDetailPromotionLink *> *promotionLink;
@property (nonatomic, assign) NSUInteger buyMinNum;
@property (nonatomic, assign) NSUInteger buyMaxNum;
@property (nonatomic, assign) BOOL isFavor;
@property (nonatomic, strong) NSArray<ProductDetailBuyNotice *> *buyNotice;
@property (nonatomic, strong) NSArray<NSString *> *narrowImg;
@property (nonatomic, assign) CGFloat picRate;
@property (nonatomic, assign) NSUInteger evaluate;
@property (nonatomic, assign) NSUInteger saleCount;
@property (nonatomic, assign) NSUInteger remainCount;
@property (nonatomic, strong) ProductDetailComment *comment;
@property (nonatomic, assign) NSUInteger commentImgCount;
@property (nonatomic, strong) NSArray<ProduceDetialCommentItem *> *commentList;
@property (nonatomic, strong) NSArray<ProdectDetailCoupon *> *coupon_provide;
@property (nonatomic, assign) BOOL canProvideCoupon;
@property (nonatomic, strong) NSString *detailUrl;
@property (nonatomic, strong) NSArray<NSString *> *fullCut;
@property (nonatomic, strong) NSArray<NSString *> *coupons;
@property (nonatomic, strong) NSString *originalPrice;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *priceDesc;
@property (nonatomic, strong) ProductDetailInsurance *insurance;
@property (nonatomic, strong) ProductDetailNote *note;
@property (nonatomic, strong) ProductDetailShare *share;
@property (nonatomic, strong) NSArray<ProductDetailStandard *> *product_standards;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *statusDesc;
@property (nonatomic, strong) NSArray<ProductDetailStore *> *store;
@property (nonatomic, assign) NSUInteger advisoryCount;
@property (nonatomic, strong) ProductDetailTime *time;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, assign) NSInteger seeNum;
@property (nonatomic, assign) NSInteger wantSeeNum;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSArray<ProductDetailActor *> *actors;
@property (nonatomic, strong) ProductDetailTheater *theater;
@property (nonatomic, strong) ProductDetailPromise *promise;
@property (nonatomic, strong) NSString *kind;
@property (nonatomic, strong) NSString *ticketTime;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, assign) NSInteger favorCount;
@property (nonatomic, strong) NSString *xiaoBianNote;
@property (nonatomic, assign) FreeType freeType;
@property (nonatomic, strong) NSString *freeTypeDesc;
@property (nonatomic, strong) NSString *productText;
@property (nonatomic, strong) NSString *trickName;
@property (nonatomic, strong) NSArray<NSString *> *tricks;
@property (nonatomic, strong) NSString *useValidStartTime;
@property (nonatomic, strong) NSString *useValidEndTime;
@property (nonatomic, assign) ProductDetailUseValidTimeType useValidTimeType;
@property (nonatomic, strong) NSString *useValidTimeDesc;
@property (nonatomic, strong) ProductDetailOnlineBespeak *onlineBespeak;
@property (nonatomic, strong) ProductDetailEnrollInfo *enrollInfo;
@property (nonatomic, assign) BOOL isEnrolled;
@property (nonatomic, strong) NSString *originalPriceDesc;
@property (nonatomic, assign) CGFloat storePrice;
@property (nonatomic, strong) NSArray<NSString *> *joinMember;
@property (nonatomic, strong) ProductDetailFreeRelatedProduct *relatedProduct;
@property (nonatomic, strong) ProductDetailCountDown *countDown;
@property (nonatomic, assign) PlaceType placeType;
@property (nonatomic, strong) NSArray<ProductDetailPlace *> *place;
@property (nonatomic, assign) NSInteger currentPlaceIndex;
@property (nonatomic, strong) NSString *commentNo;
@property (nonatomic, assign) NSInteger commentRelationType;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) ProductDetailSecKillInfo *secKillInfo;
@property (nonatomic, assign) BOOL isShowRemainCount;
@property (nonatomic, assign) BOOL isShowProductStandards;
@property (nonatomic, strong) NSString *standardTitle;
@property (nonatomic, strong) NSString *standardName;
@property (nonatomic, strong) VideoPlayVideoRes *productVideoRes;
@property (nonatomic, strong) NSArray<ProductDetailActivity *> *activities;

#pragma mark - selfDefine

//type
@property (nonatomic, assign) ProductDetailType type;

//info
@property (nonatomic, strong) NSAttributedString *attServeName;
@property (nonatomic, strong) NSAttributedString *attPromote;
@property (nonatomic, strong) NSString *priceStr;
@property (nonatomic, strong) NSAttributedString *attNum;

//apply
@property (nonatomic, strong) NSArray<NSAttributedString *> *attApply;

//recommend
@property (nonatomic, strong) NSArray<RecommendProduct *> *recommends;

//consult
@property (nonatomic, strong) NSArray<ProductDetailConsultItem *> *consults;

//canBuy
@property (nonatomic, assign) BOOL isCanBuy;

//评论详情
@property (nonatomic, strong) NSArray<CommentListItemModel *> *commentItemsArray;

//shareObj
@property (nonatomic, strong) CommonShareObject *shareObject;

//showType
@property (nonatomic, assign) ProductDetailTwoColumnShowType showType;
@property (nonatomic, assign) BOOL webViewHasOpen;
@property (nonatomic, assign) BOOL webViewHasLoad;

//ticket
@property (nonatomic, strong) NSAttributedString *attTicketContent;

@property (nonatomic, strong) NSAttributedString *attSynopsis;

@property (nonatomic, strong) NSAttributedString *attTicketPromise;

@property (nonatomic, strong) NSArray<NSString *> *supplierPhones;

@property (nonatomic, assign) BOOL synopsisOpen;

@property (nonatomic, strong) NSAttributedString *attTrickStr;

@end



