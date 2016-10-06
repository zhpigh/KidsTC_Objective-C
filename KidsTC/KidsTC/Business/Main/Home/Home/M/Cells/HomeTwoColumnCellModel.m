//
//  HomeTwoColumnCellModel.m
//  KidsTC
//
//  Created by 钱烨 on 8/14/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "HomeTwoColumnCellModel.h"
#import "Macro.h"
@implementation HomeTwoColumnCellModel

- (instancetype)initWithRawData:(NSArray *)dataArray {
    self = [super initWithRawData:dataArray];
    if (self) {
        self.type = HomeContentCellTypeTwoColumn;
    }
    return self;
}

- (void)parseRawData:(NSArray *)dataArray {
    [super parseRawData:dataArray];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSDictionary *singleData in dataArray) {
        HomeTwoColumnElement *item = [[HomeTwoColumnElement alloc] initWithHomeData:singleData];
        if (item) {
            [tempArray addObject:item];
        }
    }
    self.twoColumnElementsArray = [NSArray arrayWithArray:tempArray];
}

- (CGFloat)cellHeight {
    NSUInteger count = [self.twoColumnElementsArray count];
    if (count > 0) {
        NSUInteger row = count / 2;
        NSUInteger left = count % 2;
        if (left > 0) {
            row ++;
        }//CGFloat height = (self.rowNumber * [self cellHeight]) + (self.rowNumber - 1) * self.bottomSeparation + 2 * VMargin;
        CGFloat hMargin = 10;
        CGFloat vMargin = 5;
        
        CGFloat width = (SCREEN_WIDTH - self.centerSeparation - hMargin * 2) * 0.5;
        CGFloat singleHeight = cellRatio * width;
        cellHeight = singleHeight * row + vMargin * 2 + (row - 1) * self.bottomSeparation;
    }
    
    return cellHeight;
}

- (NSArray *)imageUrlsArray {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (HomeTwoColumnElement *singleEle in self.twoColumnElementsArray) {
        if (singleEle.imageUrl) {
            [tempArray addObject:singleEle.imageUrl];
        }
    }
    return [NSArray arrayWithArray:tempArray];
}

- (NSArray *)elementModelsArray {
    return self.twoColumnElementsArray;
}

@end


@implementation HomeTwoColumnElement

@end