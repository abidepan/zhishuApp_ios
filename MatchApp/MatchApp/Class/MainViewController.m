//
//  ViewController.m
//  star
//
//  Created by fuyiming on 14/11/6.
//  Copyright (c) 2014年 spetal. All rights reserved.
//

#import "MainViewController.h"
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
@end
