//
//  ITQRCodeScanHistoryView.h
//  MatchApp
//
//  Created by fuyiming on 14/12/14.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITScanHistoryBaseView.h"

@interface ITQRCodeScanHistoryView : ITScanHistoryBaseView <UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong) UITableView * tableView;

@end
