//
//  AccountCenterViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterViewController.h"

#import "GHeader.h"
#import "BuryPointManager.h"
#import "OnlineCustomerService.h"
#import "SegueMaster.h"

#import "AccountCenterModel.h"

#import "AccountCenterView.h"

#import "SoftwareSettingViewController.h"
#import "NotificationCenterViewController.h"
#import "AccountSettingViewController.h"

#import "CollectProductViewController.h"
#import "FavourateViewController.h"
#import "OrderListViewController.h"
#import "CommentTableViewController.h"
#import "CouponListViewController.h"
#import "BrowseHistoryViewController.h"
#import "FlashServiceOrderListViewController.h"
#import "AppointmentOrderListViewController.h"
#import "ArticleWeChatTableViewController.h"
#import "WebViewController.h"

@interface AccountCenterViewController ()<AccountCenterViewDelegate>
@property (nonatomic, strong) AccountCenterModel *model;
@property (nonatomic, strong) AccountCenterView *accountCenterView;
@end

@implementation AccountCenterViewController

- (void)loadView {
    AccountCenterView *accountCenterView = [[AccountCenterView alloc] init];
    accountCenterView.delegate = self;
    self.view = accountCenterView;
    self.accountCenterView = accountCenterView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageId = 10901;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self loadData];
}

- (void)loadData{
    [Request startWithName:@"GET_USER_CENTER" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadDataSuccess:[AccountCenterModel modelWithDictionary:dic]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadDataFailure:error];
    }];
}

- (void)loadDataSuccess:(AccountCenterModel *)model {
    self.model = model;
    self.accountCenterView.model = model;
}

- (void)loadDataFailure:(NSError *)error {
    
}


#pragma mark - AccountCenterViewDelegate

- (void)accountCenterView:(AccountCenterView *)view actionType:(AccountCenterViewActionType)type value:(id)value {
    [self checkLogin:type relultBlock:^{
        [self checkOverAccountCenterView:view actionType:type value:value];
    }];
}

- (void)checkLogin:(AccountCenterViewActionType)type relultBlock:(void(^)())resultBlock{
    
    switch (type) {
            
        case AccountCenterViewActionTypeMessageCenter:
        case AccountCenterViewActionTypeLogin:
        case AccountCenterViewActionTypeAccountSetting:
            
        case AccountCenterViewActionTypeCollectionProduct:
        case AccountCenterViewActionTypeCollectionStore:
        case AccountCenterViewActionTypeCollectionContent:
        case AccountCenterViewActionTypeCollectionPeople:
            
        case AccountCenterViewActionTypeAllOrder:
        case AccountCenterViewActionTypeWaitPay:
        case AccountCenterViewActionTypeWaitUse:
        case AccountCenterViewActionTypeWaitReceipt:
        case AccountCenterViewActionTypeWaitComment:
        case AccountCenterViewActionTypeRefund:
            
        case AccountCenterViewActionTypeScore:
        case AccountCenterViewActionTypeRadish:
        case AccountCenterViewActionTypeCoupon:
        case AccountCenterViewActionTypeECard:
        case AccountCenterViewActionTypeBalance:
            
        case AccountCenterViewActionTypeHistory:
        case AccountCenterViewActionTypeMyFlash:
        case AccountCenterViewActionTypeMyAppoinment:
            
        {
            [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
                if(resultBlock)resultBlock();
            }];
        }
            break;
            
        case AccountCenterViewActionTypeSoftwareSetting:
        case AccountCenterViewActionTypeRadishMall:
        case AccountCenterViewActionTypeShareMakeMoney:
        case AccountCenterViewActionTypeBringUpHeadline:
        case AccountCenterViewActionTypeCustomerServices:
        case AccountCenterViewActionTypeOpinion:
        case AccountCenterViewActionTypeSegue:
        {
            if(resultBlock)resultBlock();
        }
    }
}

- (void)checkOverAccountCenterView:(AccountCenterView *)view actionType:(AccountCenterViewActionType)type value:(id)value {
    
    UIViewController *toController = nil;
    switch (type) {
        case AccountCenterViewActionTypeSoftwareSetting:
        {
            toController = [[SoftwareSettingViewController alloc]init];
        }
            break;
        case AccountCenterViewActionTypeMessageCenter:
        {
            toController = [[NotificationCenterViewController alloc]init];
        }
            break;
        case AccountCenterViewActionTypeLogin:
        {
            
        }
            break;
        case AccountCenterViewActionTypeAccountSetting:
        {
            AccountCenterUserInfo *userInfo = self.model.data.userInfo;
            AccountSettingModel *model = [AccountSettingModel modelWithHeaderUrl:userInfo.headUrl userName:userInfo.usrName mobile:userInfo.mobile];
            AccountSettingViewController *controller = [[AccountSettingViewController alloc]init];
            controller.model = model;
            toController = controller;
        }
            break;
        case AccountCenterViewActionTypeCollectionProduct:
        {
            toController = [[CollectProductViewController alloc] init];
            [BuryPointManager trackEvent:@"event_skip_usr_favorlist" actionId:21505 params:nil];
        }
            break;
        case AccountCenterViewActionTypeCollectionStore:
        {
            toController = [[FavourateViewController alloc] initWithNibName:@"FavourateViewController" bundle:nil];
            [BuryPointManager trackEvent:@"event_skip_usr_favorlist" actionId:21505 params:nil];
        }
            break;
        case AccountCenterViewActionTypeCollectionContent:
        {
            toController = [[FavourateViewController alloc] initWithNibName:@"FavourateViewController" bundle:nil];
            [BuryPointManager trackEvent:@"event_skip_usr_favorlist" actionId:21505 params:nil];
        }
            break;
        case AccountCenterViewActionTypeCollectionPeople:
        {
            toController = [[FavourateViewController alloc] initWithNibName:@"FavourateViewController" bundle:nil];
            [BuryPointManager trackEvent:@"event_skip_usr_favorlist" actionId:21505 params:nil];
        }
            break;
        case AccountCenterViewActionTypeAllOrder:
        {
            toController = [[OrderListViewController alloc] initWithOrderListType:OrderListTypeAll];
            NSDictionary *params = @{@"type":@(OrderListTypeAll)};
            [BuryPointManager trackEvent:@"event_skip_usr_orderlist" actionId:21508 params:params];
        }
            break;
        case AccountCenterViewActionTypeWaitPay:
        {
            toController = [[OrderListViewController alloc] initWithOrderListType:OrderListTypeWaitingPayment];
            NSDictionary *params = @{@"type":@(OrderListTypeWaitingPayment)};
            [BuryPointManager trackEvent:@"event_skip_usr_orderlist" actionId:21508 params:params];
        }
            break;
        case AccountCenterViewActionTypeWaitUse:
        {
            toController = [[OrderListViewController alloc] initWithOrderListType:OrderListTypeWaitingUse];
            NSDictionary *params = @{@"type":@(OrderListTypeWaitingUse)};
            [BuryPointManager trackEvent:@"event_skip_usr_orderlist" actionId:21508 params:params];
        }
            break;
        case AccountCenterViewActionTypeWaitReceipt:
        {
            
        }
            break;
        case AccountCenterViewActionTypeWaitComment:
        {
            CommentTableViewController *controller = [[CommentTableViewController alloc]init];
            controller.isHaveWaitToComment = self.model.data.userCount.order_wait_evaluate>0;
            toController = controller;
            NSDictionary *params = @{@"type":@(OrderListTypeWaitingComment)};
            [BuryPointManager trackEvent:@"event_skip_usr_orderlist" actionId:21508 params:params];
        }
            break;
        case AccountCenterViewActionTypeRefund:
        {
            toController = [[OrderListViewController alloc] initWithOrderListType:OrderListTypeRefund];
            NSDictionary *params = @{@"type":@(OrderListTypeRefund)};
            [BuryPointManager trackEvent:@"event_skip_usr_orderlist" actionId:21508 params:params];
        }
            break;
        case AccountCenterViewActionTypeScore:
        {
            
        }
            break;
        case AccountCenterViewActionTypeRadish:
        {
            
        }
            break;
        case AccountCenterViewActionTypeCoupon:
        {
            toController = [[CouponListViewController alloc] initWithNibName:@"CouponListViewController" bundle:nil];
            [BuryPointManager trackEvent:@"event_skip_usr_couponlist" actionId:21509 params:nil];
        }
            break;
        case AccountCenterViewActionTypeECard:
        {
            
        }
            break;
        case AccountCenterViewActionTypeBalance:
        {
            
        }
            break;
        case AccountCenterViewActionTypeHistory:
        {
            toController = [[BrowseHistoryViewController alloc]init];
            [BuryPointManager trackEvent:@"event_skip_usr_history" actionId:21507 params:nil];
        }
            break;
        case AccountCenterViewActionTypeRadishMall:
        {
            WebViewController *controller = [[WebViewController alloc]init];
            controller.urlString = self.model.data.radish.linkUrl;
            toController = controller;
            [BuryPointManager trackEvent:@"event_skip_usr_sign" actionId:21506 params:nil];
        }
            break;
        case AccountCenterViewActionTypeMyFlash:
        {
            toController = [[FlashServiceOrderListViewController alloc]init];
            [BuryPointManager trackEvent:@"event_skip_usr_flashlist" actionId:21511 params:nil];
        }
            break;
        case AccountCenterViewActionTypeMyAppoinment:
        {
            toController = [[AppointmentOrderListViewController alloc] initWithNibName:@"AppointmentOrderListViewController" bundle:nil];
            [BuryPointManager trackEvent:@"event_skip_usr_storelist" actionId:21510 params:nil];
        }
            break;
        case AccountCenterViewActionTypeShareMakeMoney:
        {
            WebViewController *controller = [[WebViewController alloc]init];
            controller.urlString = self.model.data.radish.linkUrl;
            toController = controller;
            [BuryPointManager trackEvent:@"event_skip_usr_sign" actionId:21506 params:nil];
        }
            break;
        case AccountCenterViewActionTypeBringUpHeadline:
        {
            toController = [[ArticleWeChatTableViewController alloc] init];
            [BuryPointManager trackEvent:@"event_skip_usr_newstop" actionId:21512 params:nil];
        }
            break;
        case AccountCenterViewActionTypeCustomerServices:
        {
            NSString *str = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
            WebViewController *controller = [[WebViewController alloc]init];
            controller.urlString = str;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case AccountCenterViewActionTypeOpinion:
        {
            
        }
            break;
        case AccountCenterViewActionTypeSegue:
        {
            SegueModel *model = value;
            [SegueMaster makeSegueWithModel:model fromController:self];
            NSMutableDictionary *params = [@{@"type":@(model.destination)} mutableCopy];
            if (model.segueParam && [model.segueParam isKindOfClass:[NSDictionary class]]) {
                [params setObject:model.segueParam forKey:@"params"];
            }
            [BuryPointManager trackEvent:@"event_skip_usr_banner" actionId:21513 params:params];
        }
    }
    if (toController) [self.navigationController pushViewController:toController animated:YES];
    
}


@end