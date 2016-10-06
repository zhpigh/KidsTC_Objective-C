//
//  HomeRecommendCellModel.m
//  KidsTC
//
//  Created by Altair on 12/31/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "HomeRecommendCellModel.h"
#import "UILabel+Additions.h"

@implementation HomeRecommendCellModel

- (instancetype)initWithRawData:(NSArray *)dataArray {
    self = [super initWithRawData:dataArray];
    if (self) {
        self.type = HomeContentCellTypeRecommend;
    }
    return self;
}

- (void)parseRawData:(NSArray *)dataArray {
    [super parseRawData:dataArray];
    HomeRecommendElement *item = [[HomeRecommendElement alloc] initWithRawData:[dataArray firstObject]];
    if (item) {
        self.recommendElementsArray = [NSArray arrayWithObject:item];
        cellHeight = [item cellHeight];
    }
}

- (CGFloat)cellHeight {
    return cellHeight;
}

- (NSArray *)elementModelsArray {
    return [self recommendElementsArray];
}

@end


@implementation HomeRecommendElement
@synthesize cellHeight = _cellHeight;

- (instancetype)initWithRawData:(NSDictionary *)data {
    if (!data || ![data isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self = [super init];
    if (self) {
        NSString *identifier = nil;
        if ([data objectForKey:@"serveId"]) {
            identifier = [NSString stringWithFormat:@"%@", [data objectForKey:@"serveId"]];
            
        }
        NSString *channelId = nil;
        if ([data objectForKey:@"channelId"]) {
            channelId = [NSString stringWithFormat:@"%@", [data objectForKey:@"channelId"]];
        }
        if ([identifier length] == 0) {
            return nil;
        }
        
        self.segueModel = [SegueModel modelWithDestination:SegueDestinationServiceDetail paramRawData:[NSDictionary dictionaryWithObjectsAndKeys:identifier, @"pid", channelId, @"cid", nil]];
        self.imageUrl = [NSURL URLWithString:[data objectForKey:@"imgUrl"]];
        self.title = [data objectForKey:@"serveName"];
        self.promotionPrice = [[data objectForKey:@"price"] floatValue];
        self.originalPrice = [[data objectForKey:@"storePrice"] floatValue];
        self.saledCount = [[data objectForKey:@"sale"] integerValue];
        self.imageRatio = [[data objectForKey:@"picRate"] floatValue];
        if (self.imageRatio <= 0) {
            self.imageRatio = 0.6;
        }
        
        CGFloat height = self.imageRatio * [UIScreen mainScreen].bounds.size.width;
//        height += [ToolBox heightForLabelWithWidth:SCREEN_WIDTH - 20 LineBreakMode:NSLineBreakByCharWrapping Font:[UIFont systemFontOfSize:13] topGap:10 bottomGap:10 andText:self.title];
        
        if ([self.title length] == 0) {
            return 0;
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 20, [UIFont systemFontOfSize:13].pointSize)];
        [label setLineBreakMode:NSLineBreakByCharWrapping];
        [label setFont:[UIFont systemFontOfSize:13]];
        [label setText:self.title];
        height = [label sizeToFitWithMaximumNumberOfLines:0] + 10 + 10;
        height += 25;
        _cellHeight = height;
    }
    return self;
}

@end