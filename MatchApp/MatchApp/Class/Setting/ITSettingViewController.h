//
//  ITSettingViewController.h
//  MatchApp
//
//  Created by fuyiming on 14/12/9.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYCommonItem.h"

@interface ITSettingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *settingTableView;


@property (nonatomic,retain) YYCommonItem *scantimeout;
@property (nonatomic,assign) NSString * scanTimeOutString;


@end
