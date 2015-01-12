//
//  ViewController.m
//  star
//
//  Created by fuyiming on 14/11/6.
//  Copyright (c) 2014年 spetal. All rights reserved.
//

#import "MainViewController.h"
#import "Constants.h"
#import "ITScanHistoryViewController.h"
#import "ITSettingViewController.h"
#import "ITScanQRCodeViewController.h"
#import "ITMakeCodeViewController.h"
#import "ITUserCenterViewController.h"
#import "ITScanNfcCodeViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initViews];
}

-(void) initViews{
    
    self.title = @"查真";
    
    _qickResponseCodeVW.layer.cornerRadius =40.0f;
    _newsVM.layer.cornerRadius =40.0f;
    _nfcVM.layer.cornerRadius =40.0f;
    _mallVM.layer.cornerRadius =40.0f;
    _historyVM.layer.cornerRadius =40.0f;
    _makeCodeVM.layer.cornerRadius =40.0f;
    
    // 广告滚动实例化
    _Topic = [[JCTopic alloc]initWithFrame:CGRectMake(0, 64, kDeviceWidth, 160)];
    // 代理
    _Topic.JCdelegate = self;
    // 创建数据
    NSMutableArray * tempArray = [[NSMutableArray alloc]init];
    // 本地图片
    //***********************//
    //key pic = 本地 UIImage
    //key title = 显示的标题 NSString
    //key isLoc = 是否本地图片 Bool
    //***********************//
    UIImage * image = [UIImage imageNamed:@"pic_1.jpg"];
    //image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeTile];
    [tempArray addObject:[NSDictionary dictionaryWithObjects:@[image ,@"",@YES] forKeys:@[@"pic",@"title",@"isLoc"]]];
    UIImage * image1 = [UIImage imageNamed:@"pic_2.jpg"];
    //image1 = [image1 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [tempArray addObject:[NSDictionary dictionaryWithObjects:@[image1 ,@"",@YES] forKeys:@[@"pic",@"title",@"isLoc"]]];
    UIImage * image2 = [UIImage imageNamed:@"pic_3.jpg"];
    [tempArray addObject:[NSDictionary dictionaryWithObjects:@[image2 ,@"",@YES] forKeys:@[@"pic",@"title",@"isLoc"]]];
    UIImage * image3 = [UIImage imageNamed:@"pic_4.jpg"];
    [tempArray addObject:[NSDictionary dictionaryWithObjects:@[image3 ,@"",@YES] forKeys:@[@"pic",@"title",@"isLoc"]]];

    //加入数据
    _Topic.pics = tempArray;
    //更新
    [_Topic upDate];
    [self.view addSubview:_Topic];
    
    _page = [[UIPageControl alloc]initWithFrame:CGRectMake(kDeviceWidth - 80, 214, 80, 8)];
    _page.currentPageIndicatorTintColor = [UIColor greenColor];
    _page.pageIndicatorTintColor = [UIColor grayColor];
    
    [self.view addSubview:_page];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Function area
// 二维码
- (IBAction)onQuickResponseCodeBtnClicked:(id)sender {
    
    ITScanQRCodeViewController* sacnView =[[ITScanQRCodeViewController alloc] init];
    [self.navigationController pushViewController:sacnView animated:YES];
}

// 历史记录
- (IBAction)onScanHistoryBtnClicked:(id)sender {
    
    ITScanHistoryViewController * sacnView =[[ITScanHistoryViewController alloc] initWithNibName:@"ITScanHistoryViewController" bundle:nil];
    [self.navigationController pushViewController:sacnView animated:YES];
}


#pragma mark - Tabbar
// 用户中心
- (IBAction)onMineBtnClicked:(id)sender {
    
    ITUserCenterViewController* userView = [[ITUserCenterViewController alloc]initWithNibName:@"ITUserCenterViewController" bundle:nil];
    [self.navigationController pushViewController:userView animated:YES];
}

// 二维码
- (IBAction)onScanBtnClicked:(id)sender {
    
    ITScanQRCodeViewController* sacnView =[[ITScanQRCodeViewController alloc] init];
    [self.navigationController pushViewController:sacnView animated:YES];
}

// 设置
- (IBAction)onSettingBtnClicked:(id)sender {
    
    ITSettingViewController * settingView =[[ITSettingViewController alloc] initWithNibName:@"ITSettingViewController" bundle:nil];
    [self.navigationController pushViewController:settingView animated:YES];

}

- (IBAction)onNFCBtnClicked:(id)sender {
    
    ITScanNfcCodeViewController* nfcView = [[ITScanNfcCodeViewController alloc] initWithNibName:@"ITScanNfcCodeViewController" bundle:nil];
    [self.navigationController pushViewController:nfcView animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    //停止自己滚动的timer
    //[_Topic releaseTimer];
}

-(void)didClick:(id)data{
    //_label2.text = [NSString stringWithFormat:@"%@",(NSArray*)data];
}

-(void)currentPage:(int)page total:(NSUInteger)total{
    //_label1.text = [NSString stringWithFormat:@"Current Page %d",page+1];
    _page.numberOfPages = total;
    _page.currentPage = page;
}
@end
