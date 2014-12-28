//
//  ITInputBarCodeViewController.m
//  MatchApp
//
//  Created by fuyiming on 14/12/28.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITInputBarCodeViewController.h"

@interface ITInputBarCodeViewController ()

@end

@implementation ITInputBarCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.qrCodeTxtField.placeholder = @"请输入条码信息";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
