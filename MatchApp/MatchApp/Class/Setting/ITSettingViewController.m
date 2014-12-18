//
//  ITSettingViewController.m
//  MatchApp
//
//  Created by fuyiming on 14/12/9.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITSettingViewController.h"
#import "YYCommonGroup.h"
#import "YYCommonItem.h"
#import "YYCommonCell.h"
#import "YYCommonSwitchItem.h"
#import "YYCommonArrowItem.h"

#import "ITSettingIPViewController.h"

@interface ITSettingViewController ()

@property(nonatomic,strong)NSMutableArray *groups;

@end

@implementation ITSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    // 初始化模型数据
    [self setupGroups];
    
    //设置tableview的属性
    //设置全局背景色
    //self.settingTableView.backgroundColor = ;
    self.settingTableView.sectionFooterHeight = 0;
    self.settingTableView.sectionHeaderHeight = 15;
    //self.settingTableView.separatorStyle = UITableViewCellEditingStyleNone;
    
    // 让第一个section的高度也为15
    self.settingTableView.contentInset = UIEdgeInsetsMake(15 - 30, 0, 0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-懒加载
- (NSMutableArray *)groups {
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)setupGroups {
    //第0组
    [self setupGroup0];
    //第1组
    [self setupGroup1];
    //第2组
    [self setupGroup2];
}

- (void)setupGroup0 {
    
    //1.创建组
    YYCommonGroup *group = [YYCommonGroup group];
    [self.groups addObject:group];
    
    //2.设置组的基本数据
    group.groupheader = @"第0组";
    group.grougfooter = @"第0组的尾部";
    
    //3.设置组中所有行的数据
    YYCommonSwitchItem *beebSwitch = [YYCommonSwitchItem itemWithTitle:@"提示音" icon:@"search"];
    //hotStatus.subtitle = @"扫描成功后会“biu~”一声";
    
    YYCommonSwitchItem *vibrateSwitch = [YYCommonSwitchItem itemWithTitle:@"震动" icon:@"search"];
    //findPeople.subtitle = @"扫描成功后会抽搐一下";
    
    YYCommonItem *scantimeout = [YYCommonItem itemWithTitle:@"扫描超时" icon:@"search"];
    scantimeout.operation = ^{
        
        // NSLog(@"---------扫描超时--30s---------");
        
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"选中的行信息" message:scantimeout.title delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    };
    
    group.items = @[beebSwitch, vibrateSwitch, scantimeout];
}

- (void)setupGroup1 {
    //1.创建组
    YYCommonGroup *group = [YYCommonGroup group];
    [self.groups addObject:group];
    
    //2.设置组的基本数据
    
    //3.设置组中所有行的数据
    YYCommonArrowItem *gamecenter = [YYCommonArrowItem itemWithTitle:@"版本更新" icon:@"search"];
    YYCommonArrowItem *near = [YYCommonArrowItem itemWithTitle:@"用户反馈" icon:@"search"];
    YYCommonArrowItem *clearcache = [YYCommonArrowItem itemWithTitle:@"清除缓存" icon:@"search"];
    YYCommonArrowItem *share = [YYCommonArrowItem itemWithTitle:@"软件分享" icon:@"search"];
    
    group.items = @[gamecenter,near,clearcache,share];
    
}

- (void)setupGroup2 {
    //1.创建组
    YYCommonGroup *group = [YYCommonGroup group];
    [self.groups addObject:group];
    
    //2.设置组的基本数据
    
    //3.设置组中所有行的数据
    YYCommonArrowItem *video = [YYCommonArrowItem itemWithTitle:@"设置服务器IP" icon:@"search"];
    video.destVcClass = [ITSettingIPViewController class];
    YYCommonArrowItem *music = [YYCommonArrowItem itemWithTitle:@"使用帮助" icon:@"search"];
    music.destVcClass = [ITSettingIPViewController class];
    YYCommonArrowItem *movie = [YYCommonArrowItem itemWithTitle:@"关于" icon:@"search"];
    
    group.items = @[video,music,movie];
}

#pragma mark  Data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    YYCommonGroup *group = self.groups[section];
    return group.items.count;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1.获取cell
    YYCommonCell *cell = [YYCommonCell cellWithTablView:tableView];
    //2.设置cell的显示数据
    YYCommonGroup *group = self.groups[indexPath.section];
    YYCommonItem *item = group.items[indexPath.row];
    cell.item = item;
    
    [cell setindexPath:indexPath rowsInSection:group.items.count];
    //3.返回cell
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1.取出这行对应的item模型
    YYCommonGroup *group = self.groups[indexPath.section];
    YYCommonItem *item = group.items[indexPath.row];
    
    //2.判断有无需要跳转的控制器
    if (item.destVcClass) {
        UIViewController *desrVc = [[item.destVcClass alloc]init];
        desrVc.title = item.title;
        [self.navigationController pushViewController:desrVc animated:YES];
    }
    
    //3.判断有无需要执行的代码段
    if (item.operation) {
        item.operation();
    }
    
}

@end
