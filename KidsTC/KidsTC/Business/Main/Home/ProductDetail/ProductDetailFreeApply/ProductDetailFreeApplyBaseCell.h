//
//  ProductDetailFreeApplyBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailData.h"
#import "ProductDetailFreeApplyShowModel.h"

typedef enum : NSUInteger {
    ProductDetailFreeApplyBaseCellActionTypeUserAddressTip = 1,
    ProductDetailFreeApplyBaseCellActionTypeUserAddress,
    ProductDetailFreeApplyBaseCellActionTypeActivityDate,
    ProductDetailFreeApplyBaseCellActionTypeActivityStore,
    ProductDetailFreeApplyBaseCellActionTypeSelectBirth,
    ProductDetailFreeApplyBaseCellActionTypeSelectAge,
    ProductDetailFreeApplyBaseCellActionTypeSelectSex,
    
} ProductDetailFreeApplyBaseCellActionType;

@class ProductDetailFreeApplyBaseCell;
@protocol ProductDetailFreeApplyBaseCellDelegate <NSObject>
- (void)productDetailFreeApplyBaseCell:(ProductDetailFreeApplyBaseCell *)cell actionType:(ProductDetailFreeApplyBaseCellActionType)type value:(id)value;
@end

@interface ProductDetailFreeApplyBaseCell : UITableViewCell
@property (nonatomic, strong) ProductDetailData *data;
@property (nonatomic, strong) ProductDetailFreeApplyShowModel *showModel;
@property (nonatomic, weak) id<ProductDetailFreeApplyBaseCellDelegate> delegate;
@end
