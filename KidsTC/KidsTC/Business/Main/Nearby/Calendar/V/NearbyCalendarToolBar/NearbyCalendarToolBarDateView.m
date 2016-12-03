//
//  NearbyCalendarToolBarDateView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyCalendarToolBarDateView.h"
#import <EventKit/EventKit.h>
#import "FSCalendar.h"
#import "FSCalendarHeader.h"

@interface NearbyCalendarToolBarDateView ()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>
@property (nonatomic, strong) FSCalendar *calendar;
@end

@implementation NearbyCalendarToolBarDateView

- (FSCalendar *)calendar {
    if (!_calendar) {
        FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        calendar.dataSource = self;
        calendar.delegate = self;
        calendar.pagingEnabled = NO; // important
        calendar.allowsSelection = YES;
        calendar.allowsMultipleSelection = NO;
        calendar.focusOnSingleSelectedDate = NO;
        calendar.appearance.headerDateFormat = @"yyyy年MM月";
        calendar.appearance.headerTitleColor = [UIColor darkGrayColor];
        calendar.appearance.weekdayTextColor = [UIColor blackColor];
        calendar.appearance.selectionColor = COLOR_PINK;
        calendar.placeholderType = FSCalendarPlaceholderTypeFillHeadTail;
        calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase|FSCalendarCaseOptionsHeaderUsesDefaultCase;
        calendar.appearance.todayColor = [UIColor clearColor];
        calendar.appearance.titleTodayColor = [UIColor blackColor];
        [self addSubview:calendar];
        _calendar = calendar;
    }
    return _calendar;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.calendar.frame = self.bounds;
}

#pragma mark - FSCalendarDelegate

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date {
    if ([self.delegate respondsToSelector:@selector(nearbyCalendarToolBarDateView:didSelectDate:)]) {
        [self.delegate nearbyCalendarToolBarDateView:self didSelectDate:date];
    }
}



@end