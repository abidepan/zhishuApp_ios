//
//  ViewController.h
//  star
//
//  Created by fuyiming on 14/11/6.
//  Copyright (c) 2014年 spetal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCTopic.h"
#import "MBProgressHUD.h"

@interface MainViewController : UIViewController<JCTopicDelegate>

// JCTopic 循环滚动广告图片 第三方控件
@property(nonatomic,strong)JCTopic * Topic;
// UIPageControl 四个圆点按钮
@property (strong, nonatomic) IBOutlet UIPageControl *page;
// Toast弹框
@property(nonatomic,strong) MBProgressHUD * progressHUD;

// 功能模块
@property (weak, nonatomic) IBOutlet UIView *qickResponseCodeVW;
@property (weak, nonatomic) IBOutlet UIView *newsVM;
@property (weak, nonatomic) IBOutlet UIView *nfcVM;
@property (weak, nonatomic) IBOutlet UIView *mallVM;
@property (weak, nonatomic) IBOutlet UIView *historyVM;
@property (weak, nonatomic) IBOutlet UIView *makeCodeVM;
@property (weak, nonatomic) IBOutlet UIView *squartContainerVW;

- (IBAction)onQuickResponseCodeBtnClicked:(id)sender;
- (IBAction)onScanHistoryBtnClicked:(id)sender;
- (IBAction)onNewsBtnClicked:(id)sender;
- (IBAction)onShopBtnClicked:(id)sender;
- (IBAction)onMakeCodeBtnClicked:(id)sender;
- (IBAction)onNFCBtnClicked:(id)sender;

- (IBAction)onMineBtnClicked:(id)sender;
- (IBAction)onScanBtnClicked:(id)sender;
- (IBAction)onSettingBtnClicked:(id)sender;


@end

