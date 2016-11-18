//
//  ProductDetailAddressViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailAddressViewController.h"
#import "KTCMapUtil.h"
#import "UIBarButtonItem+Category.h"
#import "TCProgressHUD.h"
#import "iToast.h"
#import "RouteAnnotation.h"
#import "ProductDetailAddressAnnoView.h"
#import "ProductDetailAddressTitleView.h"
#import "UIBarButtonItem+Category.h"
#import "ProductDetailAddressSelStoreViewController.h"

@interface ProductDetailAddressViewController ()<BMKMapViewDelegate,ProductDetailAddressAnnoViewDelegate,ProductDetailAddressTitleViewDelegate,ProductDetailAddressSelStoreViewControllerDelegate>
@property (nonatomic, weak) BMKMapView *mapView;
@property (nonatomic, strong) BMKPointAnnotation* startAnnotation;
@property (nonatomic, strong) BMKPointAnnotation *destinationAnnotation;

@property (nonatomic, assign) MapRouteSearchType routeSearchType;
@end

@implementation ProductDetailAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTheme = NaviThemeWihte;
    
    [KTCMapService shareKTCMapService].needToCheckServiceOnLine = YES;
    
    [self initMapView];
    
    [self initNaviItems];
    
    self.currentIndex = 0;
}

- (id)viewWithNib:(NSString *)nib{
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
}

- (void)dealloc {
    [KTCMapUtil cleanMap:self.mapView];
    if (self.mapView) {
        self.mapView = nil;
    }
}

- (void)setCurrentIndex:(NSUInteger)currentIndex {
    _currentIndex = currentIndex;
    if (self.store.count>_currentIndex) {
        [KTCMapUtil cleanMap:self.mapView];
        [self setStartAnnotationCoordinate:[KTCMapService shareKTCMapService].currentLocation.location.coordinate];
        [self setDestinationAnnotationCoordinate:self.store[_currentIndex].location.location.coordinate];
        
        [KTCMapUtil resetMapView:self.mapView toFitLocations:@[self.store[_currentIndex].location.location]];
    }
}

#pragma mark private

- (void)setStartAnnotationCoordinate:(CLLocationCoordinate2D)coordinate {
    if (!self.startAnnotation) {
        self.startAnnotation = [[BMKPointAnnotation alloc]init];
    }
    if (CLLocationCoordinate2DIsValid(coordinate)) {
        [self.startAnnotation setCoordinate:coordinate];
    }
    NSArray *annos = [self.mapView annotations];
    if ([annos indexOfObject:self.startAnnotation] == NSNotFound) {
        [self.mapView addAnnotation:self.startAnnotation];
    }
}

- (void)setDestinationAnnotationCoordinate:(CLLocationCoordinate2D)coordinate {
    if (!self.destinationAnnotation) {
        self.destinationAnnotation = [[BMKPointAnnotation alloc]init];
    }
    if (CLLocationCoordinate2DIsValid(coordinate)) {
        [self.destinationAnnotation setCoordinate:coordinate];
    }
    NSArray *annos = [self.mapView annotations];
    if ([annos indexOfObject:self.destinationAnnotation] == NSNotFound) {
        
    }
    [self.mapView addAnnotation:self.destinationAnnotation];
    
    [KTCMapUtil resetMapView:self.mapView toFitStart:self.startAnnotation.coordinate andDestination:self.destinationAnnotation.coordinate];
}

#pragma amrk - initMapView

- (void)initMapView{
    BMKMapView *mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    mapView.mapType = BMKMapTypeStandard;
    mapView.showsUserLocation = YES;
    mapView.isSelectedAnnotationViewFront = YES;
    mapView.showMapScaleBar = YES;
    mapView.mapScaleBarPosition = CGPointMake(5, SCREEN_HEIGHT-50);
    mapView.delegate = self;
    
    [self.view addSubview:mapView];
    self.mapView = mapView;
}

#pragma mark  BMKMapViewDelegate

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    //指南针必须在加载完成后设置
    [self.mapView setCompassPosition:CGPointMake(SCREEN_WIDTH - 50, 70)];
    [self setStartAnnotationCoordinate:[KTCMapService shareKTCMapService].currentLocation.location.coordinate];
    [self setDestinationAnnotationCoordinate:self.store[_currentIndex].location.location.coordinate];
    
    [KTCMapUtil resetMapView:mapView toFitLocations:@[self.store[_currentIndex].location.location]];
}

static NSString *const annotationViewReuseIndentifier = @"annotationViewReuseIndentifier";
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewReuseIndentifier];
    if (!annotationView) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewReuseIndentifier];
        //annotationView.image = [KTCMapUtil poiAnnotationImage];
        annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    }
    annotationView.annotation = annotation;
    
    if (annotation == self.startAnnotation) {
        annotationView.image = [KTCMapUtil startAnnotationImage];
    }else if (annotation == self.destinationAnnotation){
        if (self.store.count>_currentIndex) {
            ProductDetailStore *store = self.store[_currentIndex];
            ProductDetailAddressAnnoView *tipView = [[[NSBundle mainBundle] loadNibNamed:@"ProductDetailAddressAnnoView" owner:self options:nil] firstObject];
            CGSize size = [store.location.moreDescription sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
            CGFloat min_w = 177;
            CGFloat self_w = size.width + 77;
            self_w = self_w<min_w?min_w:self_w;
            tipView.frame = CGRectMake(0, 0, self_w, 44);
            tipView.delegate = self;
            tipView.store = store;
            annotationView.paopaoView = [[BMKActionPaopaoView alloc]initWithCustomView:tipView];
            //设置是否可以拖拽
            annotationView.draggable = NO;
        }
    }
    
    if ([annotation isKindOfClass:[RouteAnnotation class]] &&
        annotation != self.startAnnotation &&
        annotation != self.destinationAnnotation) {
        return [RouteAnnotation routeAnnotationView:mapView viewForAnnotation:(RouteAnnotation*)annotation];
    }
    return annotationView;
}

- (BMKOverlayView*)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = COLOR_BLUE;
        polylineView.strokeColor = COLOR_BLUE;
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}

- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    [views enumerateObjectsUsingBlock:^(BMKAnnotationView *view, NSUInteger idx, BOOL *stop) {
        if (view.annotation == self.destinationAnnotation) {
            [self.mapView selectAnnotation:view.annotation animated:YES];
        }
    }];
}

#pragma mark  ProductDetailAddressAnnoViewDelegate

- (void)productDetailAddressAnnoView:(ProductDetailAddressAnnoView *)view
                          actionType:(ProductDetailAddressAnnoViewActionType)type
                               value:(id)vlaue
{
    [self startRouteSearchWithType:self.routeSearchType];
}

#pragma mark - initNaviItems

- (void)initNaviItems {
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"其他门店" postion:UIBarButtonPositionRight
                                                                     target:self
                                                                     action:@selector(rightBarButtonItemAction)
                                                               andGetButton:^(UIButton *btn) {
                                                                   [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                                               }];
    ProductDetailAddressTitleView *titleView = [self viewWithNib:@"ProductDetailAddressTitleView"];
    titleView.delegate = self;
    titleView.bounds = CGRectMake(0, 0, 160, 44);
    self.navigationItem.titleView = titleView;
    
}

- (void)rightBarButtonItemAction{
    ProductDetailAddressSelStoreViewController *controller = [[ProductDetailAddressSelStoreViewController alloc] init];
    controller.store = self.store;
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:controller animated:NO completion:nil];
}

#pragma mark - ProductDetailAddressSelStoreViewControllerDelegate

- (void)productDetailAddressSelStoreViewController:(ProductDetailAddressSelStoreViewController *)controller
                                    didSelectIndex:(NSUInteger)index
{
    self.currentIndex = index;
}


#pragma mark - ProductDetailAddressTitleViewDelegate

- (void)productDetailAddressTitleView:(ProductDetailAddressTitleView *)view
                           actionType:(ProductDetailAddressTitleViewActionType)type
                                value:(id)value
{
    
    switch (type) {
        case ProductDetailAddressTitleViewActionTypeTexi:
        {
            [self startRouteSearchWithType:MapRouteSearchTypeDrive];
            self.routeSearchType = MapRouteSearchTypeDrive;
        }
            break;
        case ProductDetailAddressTitleViewActionTypeBus:
        {
            [self startRouteSearchWithType:MapRouteSearchTypeBus];
            self.routeSearchType = MapRouteSearchTypeDrive;
        }
            break;
        case ProductDetailAddressTitleViewActionTypeWorlk:
        {
            [self startRouteSearchWithType:MapRouteSearchTypeWalk];
            self.routeSearchType = MapRouteSearchTypeDrive;
        }
            break;
        default:
            break;
    }
}

#pragma mark - choiceRouteType

- (void)startRouteSearchWithType:(MapRouteSearchType)type {
    
    [TCProgressHUD showSVP];
    [[KTCMapService shareKTCMapService] startRouteSearchWithType:type
                                                 startCoordinate:self.startAnnotation.coordinate
                                                   endCoordinate:self.destinationAnnotation.coordinate
                                                         succeed:^(id result)
    {
        [TCProgressHUD dismissSVP];
        [self drawRouteLineDetailWithSearchResult:result];
    } failure:^(NSError *error) {
        [TCProgressHUD dismissSVP];
        [[iToast makeText:@"没有找到合适的路线"] show];
    }];
}

- (NSDictionary *)drawRouteLineDetailWithSearchResult:(id)result {
    NSDictionary *routeLineDic = nil;
    //解析
    if ([result isKindOfClass:[BMKDrivingRouteResult class]]) {
        
        //驾车
        routeLineDic = [KTCMapUtil drawRoutePolyLineOnMapView:self.mapView
                                               withStartCoord:self.startAnnotation.coordinate
                                                     endCoord:self.destinationAnnotation.coordinate
                                        andDrivingRouteResult:result
                                               autoResetToFit:YES];
        
    } else if ([result isKindOfClass:[BMKTransitRouteResult class]]) {
        
        //公交
        routeLineDic = [KTCMapUtil drawRoutePolyLineOnMapView:self.mapView
                                               withStartCoord:self.startAnnotation.
                        coordinate endCoord:self.destinationAnnotation.coordinate
                                        andTransitRouteResult:result
                                               autoResetToFit:YES];
        
    } else if ([result isKindOfClass:[BMKWalkingRouteResult class]]) {
        
        //步行
        routeLineDic = [KTCMapUtil drawRoutePolyLineOnMapView:self.mapView
                                               withStartCoord:self.startAnnotation.coordinate
                                                     endCoord:self.destinationAnnotation.coordinate
                                        andWalkingRouteResult:result
                                               autoResetToFit:YES];
        
    }
    return routeLineDic;
}
@end
