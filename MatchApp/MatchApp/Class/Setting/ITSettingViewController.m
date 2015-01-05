//
//  ITSettingViewController.m
//  MatchApp
//
//  Created by fuyiming on 14/12/9.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITSettingViewController.h"
#import "YYCommonGroup.h"
#import "YYCommonCell.h"
#import "YYCommonSwitchItem.h"
#import "YYCommonArrowItem.h"
#import "ITDataStore.h"
#import "ITSettingIPViewController.h"

@interface ITSettingViewController ()

@property(nonatomic,strong)NSMutableArray *groups;

@end

@implementation ITSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    _scanTimeOutString = @"";
    
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
    YYCommonItem *beebSwitch = [YYCommonItem itemWithTitle:@"提示音" icon:@"setting_beeb"];
    
    YYCommonItem *vibrateSwitch = [YYCommonItem itemWithTitle:@"震动" icon:@"setting_vibrate"];
    
    _scantimeout = [YYCommonItem itemWithTitle:@"扫描超时" icon:@"setting_scan_timeout"];
    
    ITSettingViewController * _weakSelf = self;
    
    _scantimeout.operation = ^{
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"扫描超时" message:@"" delegate:_weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"10秒",@"15秒", @"20秒", @"30秒", nil];
        [alter show];
    };
    
    //读取扫描超时时间
    NSString * scanTimeOut =[[ITDataStore instance] getSettingScanTimeOut];
    _scantimeout.subtitle = scanTimeOut?scanTimeOut:@"30秒";
    
    group.items = @[beebSwitch, vibrateSwitch, _scantimeout];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //该方法由UIAlertViewDelegate协议定义，在点击AlertView按钮时自动执行，
    //所以如果这里再用alertView来弹出提示，就会死循环，不停的弹AlertView
    _scanTimeOutString = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([_scanTimeOutString isEqualToString:@"取消"]) { return;}
    
    NSLog(@"%@",_scanTimeOutString);
    _scantimeout.subtitle = _scanTimeOutString;
    
    //保存扫描超时时间
    [[ITDataStore instance] saveSettingScanTimeOut:_scanTimeOutString];
    
    [_settingTableView reloadData];
}

- (void)setupGroup1 {
    //1.创建组
    YYCommonGroup *group = [YYCommonGroup group];
    [self.groups addObject:group];
    
    //2.设置组的基本数据
    
    //3.设置组中所有行的数据
    YYCommonArrowItem *gamecenter = [YYCommonArrowItem itemWithTitle:@"版本更新" icon:@"setting_version"];
    YYCommonArrowItem *near = [YYCommonArrowItem itemWithTitle:@"用户反馈" icon:@"setting_feedback"];
    YYCommonArrowItem *clearcache = [YYCommonArrowItem itemWithTitle:@"清除缓存" icon:@"setting_help"];
    YYCommonArrowItem *share = [YYCommonArrowItem itemWithTitle:@"软件分享" icon:@"setting_shareapp"];
    
    group.items = @[gamecenter,near,clearcache,share];
    
}

- (void)setupGroup2 {
    //1.创建组
    YYCommonGroup *group = [YYCommonGroup group];
    [self.groups addObject:group];
    
    //2.设置组的基本数据
    
    //3.设置组中所有行的数据
    YYCommonArrowItem *video = [YYCommonArrowItem itemWithTitle:@"设置服务器IP" icon:@"setting_server_ip"];
    video.destVcClass = [ITSettingIPViewController class];
    YYCommonArrowItem *music = [YYCommonArrowItem itemWithTitle:@"使用帮助" icon:@"setting_clear_cache"];
    music.destVcClass = [ITSettingIPViewController class];
    YYCommonArrowItem *movie = [YYCommonArrowItem itemWithTitle:@"关于" icon:@"setting_about"];
    
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
    
    // 提示音
    if(indexPath.section == 0 && indexPath.row == 0){
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        
        BOOL isScanVoice =[[ITDataStore instance] getSettingIsScanVoice];
        [switchView setOn:isScanVoice animated:NO];
        
        [switchView addTarget:self action:@selector(beebSwitchChanged:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = switchView;
    }
    
    // 振动
    if(indexPath.section == 0 && indexPath.row == 1){
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        
        BOOL isScanShake =[[ITDataStore instance] getSettingIsScanShake];
        [switchView setOn:isScanShake animated:NO];
        
        [switchView addTarget:self action:@selector(shakeSwitchChanged:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = switchView;
    }

    
    //3.返回cell
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
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

// 提示音
- (void) beebSwitchChanged:(id)sender {
    UISwitch* switchControl = sender;
    NSLog( @"The beebSwitchChanged is %@", switchControl.on ? @"ON" : @"OFF" );
    
    [[ITDataStore instance] saveSettingIsScanVoice:switchControl.on];
}

// 振动
- (void) shakeSwitchChanged:(id)sender {
    UISwitch* switchControl = sender;
    NSLog( @"The shakeSwitchChanged is %@", switchControl.on ? @"ON" : @"OFF" );
    
    [[ITDataStore instance] saveSettingIsScanShake:switchControl.on];
}

@end
