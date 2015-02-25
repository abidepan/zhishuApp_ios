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
#import "MobClick.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initViews];
}

-(void) initViews{
    
    self.title = @"查真";
    
    [self resizeCircleItems];
    [self initTopSlide];
}

// 适配屏幕
-(void) resizeCircleItems{
    
    // 模块按钮半径
    double cornerRadius =  40;
    // 广告栏高度
    double TopicHeight =  160;
    // 按钮区域大小调整
    CGFloat x = _squartContainerVW.frame.origin.x;
    CGFloat y = _squartContainerVW.frame.origin.y;
    CGFloat width = _squartContainerVW.frame.size.width;
    CGFloat height = _squartContainerVW.frame.size.height;
    
    if (kDeviceWidth > 320) {
        double time = kDeviceWidth/320.0f;
        cornerRadius *=time;
    }
    
    // 6/6s 时广告栏高度加160+40 -- 5/5s时160 -- 4s时160-20
    if (kDeviceHeight > 568) {
        TopicHeight += 40;
        y += 40;
        height -= 40;
    } else if (kDeviceHeight < 568) {
        TopicHeight -= 20;
        y -= 20;
        height += 20;
    }
    
    // 广告滚动实例化
    _Topic = [[JCTopic alloc]initWithFrame:CGRectMake(0, 64, kDeviceWidth, TopicHeight)];
    _page = [[UIPageControl alloc]initWithFrame:CGRectMake(kDeviceWidth - 80, y - 10, 80, 8)];
    
    // 按钮区域大小调整
    [_squartContainerVW setFrame:CGRectMake(x , y, width, height)];
    
    // marginV --Y方向上模块间距
    // marginH --X方向上模块间距
    double marginV = (_squartContainerVW.bounds.size.height - 4 * cornerRadius)/3.0;
    double marginH = (_squartContainerVW.bounds.size.width - 6 * cornerRadius)/4.0;
    
    [_qickResponseCodeVW setFrame:CGRectMake(marginH, marginV, 2*cornerRadius, 2*cornerRadius)];
    [_nfcVM setFrame:CGRectMake(2* (marginH +cornerRadius) , marginV, 2*cornerRadius, 2*cornerRadius)];
    [_mallVM setFrame:CGRectMake(3* marginH + 4*cornerRadius , marginV, 2*cornerRadius, 2*cornerRadius)];
    
    [_newsVM setFrame:CGRectMake(marginH, 2*( marginV+cornerRadius), 2*cornerRadius, 2*cornerRadius)];
    [_historyVM setFrame:CGRectMake(2* (marginH +cornerRadius) ,2*( marginV+cornerRadius), 2*cornerRadius, 2*cornerRadius)];
    [_makeCodeVM setFrame:CGRectMake(3* marginH + 4*cornerRadius , 2*( marginV+cornerRadius), 2*cornerRadius, 2*cornerRadius)];
    
    // 设置圆弧
    _qickResponseCodeVW.layer.cornerRadius = cornerRadius;
    _nfcVM.layer.cornerRadius = cornerRadius;
    _mallVM.layer.cornerRadius = cornerRadius;
    _newsVM.layer.cornerRadius = cornerRadius;
    _historyVM.layer.cornerRadius = cornerRadius;
    _makeCodeVM.layer.cornerRadius = cornerRadius;
    
}

-(void) setY:(double)y forView:(UIView*)vw{
    
    [vw setFrame:CGRectMake(vw.frame.origin.x, y, vw.frame.size.width, vw.frame.size.height)];
}

-(void) resizeView:(UIView *)vw times:(double)time{
    
    CGPoint center = vw.center;
    [vw setBounds:CGRectMake(0, 0, vw.bounds.size.width * time, vw.bounds.size.height * time)];
    vw.center = center;
}

-(void)initTopSlide{

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

// NFC
- (IBAction)onNFCBtnClicked:(id)sender {
    
    //    ITScanNfcCodeViewController* nfcView = [[ITScanNfcCodeViewController alloc] initWithNibName:@"ITScanNfcCodeViewController" bundle:nil];
    //    [self.navigationController pushViewController:nfcView animated:YES];
    
    [self showToast];
}

- (IBAction)onShopBtnClicked:(id)sender {
    [self showToast];
}

- (IBAction)onNewsBtnClicked:(id)sender {
    [self showToast];
}

// 历史记录
- (IBAction)onScanHistoryBtnClicked:(id)sender {
    
    ITScanHistoryViewController * sacnView =[[ITScanHistoryViewController alloc] initWithNibName:@"ITScanHistoryViewController" bundle:nil];
    [self.navigationController pushViewController:sacnView animated:YES];
}

- (IBAction)onMakeCodeBtnClicked:(id)sender {
    [self showToast];
}

#pragma mark - Tabbar
// 用户中心
- (IBAction)onMineBtnClicked:(id)sender {
    
//    ITUserCenterViewController* userView = [[ITUserCenterViewController alloc]initWithNibName:@"ITUserCenterViewController" bundle:nil];
//    [self.navigationController pushViewController:userView animated:YES];
    
    [self showToast];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 友盟统计
    [MobClick beginLogPageView:@"PageOne"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    // 友盟统计
    [MobClick endLogPageView:@"PageOne"];
    
    //停止自己滚动的timer
    //[_Topic releaseTimer];
}

// 广告栏点击事件
-(void)didClick:(id)data{
    //_label2.text = [NSString stringWithFormat:@"%@",(NSArray*)data];
}

-(void)currentPage:(int)page total:(NSUInteger)total{
    //_label1.text = [NSString stringWithFormat:@"Current Page %d",page+1];
    _page.numberOfPages = total;
    _page.currentPage = page;
}

- (IBAction)showToast{
 
    // Toast 弹框
    _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];

    [self.view addSubview:_progressHUD];
    _progressHUD.labelText = @"此功能暂未投入使用，请耐心等待";
    _progressHUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    //    HUD.yOffset = 150.0f;
    //    HUD.xOffset = 100.0f;
    
    [_progressHUD showAnimated:YES whileExecutingBlock:^{
        sleep(1.5);
    } completionBlock:^{
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }];
}


@end
