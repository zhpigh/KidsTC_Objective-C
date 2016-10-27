//
//  ProductDetailTwoColumnCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTwoColumnCell.h"

#import "ProductDetailTwoColumnTableViewBaseCell.h"
#import "ProductDetailTwoColumnTableViewTipCell.h"
#import "ProductDetailTwoColumnTableViewEmptyCell.h"
#import "ProductDetailTwoColumnTableViewConsultCell.h"

static NSString *const ID = @"ProductDetailTwoColumnTableViewBaseCell";

@interface ProductDetailTwoColumnCell ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, assign) BOOL webViewHasLoad;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ProductDetailTwoColumnTableViewTipCell *tipCell;
@property (nonatomic, strong) NSArray<NSArray<ProductDetailTwoColumnTableViewBaseCell *> *> *sections;

@end

@implementation ProductDetailTwoColumnCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self layoutIfNeeded];
    
    self.showType = ProductDetailTwoColumnShowTypeDetail;
    
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.opaque = YES;
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.scrollsToTop = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    
    
    self.tableView.scrollsToTop = NO;
    self.tableView.scrollEnabled = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.estimatedRowHeight = 66.0f;
    self.tipCell = [self viewWithNib:@"ProductDetailTwoColumnTableViewTipCell"];
    [self setupSections];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat h = 0;
    switch (_showType) {
        case ProductDetailTwoColumnShowTypeDetail:
        {
            CGFloat webH = self.webView.scrollView.contentSize.height;
            if (_webViewHasOpen) {
                h = webH;
            }else{
                if (webH>SCREEN_HEIGHT) {
                    h = SCREEN_HEIGHT;
                }else{
                    h = webH * 0.8;
                }
            }
        }
            break;
        case ProductDetailTwoColumnShowTypeConsult:
        {
            h = self.tableView.contentSize.height;
        }
            break;
    }
    return CGSizeMake(size.width, h);
}

- (void)setShowType:(ProductDetailTwoColumnShowType)showType {
    _showType = showType;
    switch (showType) {
        case ProductDetailTwoColumnShowTypeDetail:
        {
            self.webView.hidden = NO;
            self.tableView.hidden = YES;
        }
            break;
        case ProductDetailTwoColumnShowTypeConsult:
        {
            self.webView.hidden = YES;
            self.tableView.hidden = NO;
        }
            break;
    }
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    
    if (!_webViewHasLoad) {
        NSString *rulStr = data.detailUrl;
        rulStr = [rulStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:rulStr]];
        [self.webView loadRequest:request];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    _webViewHasLoad = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

- (void)setupSections {
    
    NSMutableArray *sections = [NSMutableArray array];
    
    NSMutableArray *section00 = [NSMutableArray array];
    [section00 addObject:_tipCell];
    [section00 addObject:self.emptyCell];
    [section00 addObject:self.consultCell];
    [section00 addObject:self.consultCell];
    if (section00.count>0) [sections addObject:section00];
    
    self.sections = [NSArray arrayWithArray:sections];
}

- (ProductDetailTwoColumnTableViewEmptyCell *)emptyCell {
    return [self viewWithNib:@"ProductDetailTwoColumnTableViewEmptyCell"];
}

- (ProductDetailTwoColumnTableViewConsultCell *)consultCell {
    return [self viewWithNib:@"ProductDetailTwoColumnTableViewConsultCell"];
}

- (id)viewWithNib:(NSString *)nib{
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section == self.sections.count - 1)?0.001:12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductDetailTwoColumnTableViewBaseCell *cell = self.sections[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeReplyConsult value:nil];
    }
}

@end
