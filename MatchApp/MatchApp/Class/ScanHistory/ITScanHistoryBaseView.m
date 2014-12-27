//
//  ITScanHistoryBaseView.m
//  MatchApp
//
//  Created by fuyiming on 14/12/14.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITScanHistoryBaseView.h"

@implementation ITScanHistoryBaseView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    if (self) {
        
        _noRecordsLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50)];
        _noRecordsLbl.font = kAppFont(12);
        _noRecordsLbl.textColor = [UIColor lightGrayColor];
        _noRecordsLbl.textAlignment = NSTextAlignmentCenter;
        _noRecordsLbl.text = @"暂无相关历史纪录";
        
    }
    return self;
}

-(void) onHistoryViewAppear{}

-(void) onHistoryViewDisappear{}

@end
