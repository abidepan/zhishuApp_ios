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

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onQuickResponseCodeBtnClicked:(id)sender {
    ITScanQRCodeViewController* sacnView =[[ITScanQRCodeViewController alloc] initWithNibName:@"ITScanQRCodeViewController" bundle:nil];
    [self.navigationController pushViewController:sacnView animated:YES];
}

- (IBAction)onMineBtnClicked:(id)sender {

}

- (IBAction)onScanBtnClicked:(id)sender {

    ITScanHistoryViewController * sacnView =[[ITScanHistoryViewController alloc] initWithNibName:@"ITScanHistoryViewController" bundle:nil];
    [self.navigationController pushViewController:sacnView animated:YES];
}

- (IBAction)onSettingBtnClicked:(id)sender {
    ITSettingViewController * settingView =[[ITSettingViewController alloc] initWithNibName:@"ITSettingViewController" bundle:nil];
    [self.navigationController pushViewController:settingView animated:YES];

}
@end
