//
//  ITScanQRCodeViewController.m
//  MatchApp
//
//  Created by fuyiming on 14/12/9.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITScanQRCodeViewController.h"
#import "ITScanDetailViewController.h"
#import "Constants.h"
#import "ITInputQRCodeViewController.h"

@interface ITScanQRCodeViewController ()

@end

@implementation ITScanQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"二维码扫描";
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark ====== scan code delegate ======

-(NSArray *) getScanCodeTypes{
    
    return @[AVMetadataObjectTypeQRCode];
}

-(void) onInputScanCodeBtnClicked{
    
    ITInputQRCodeViewController * qrinputcode = [[ITInputQRCodeViewController alloc] init];
    [self.navigationController pushViewController:qrinputcode animated:YES];
}

-(void) onGetScanCode:(ITScanDetailViewController * )scanDetail{
    
    scanDetail.codeType = CodeTypeQR;
}


@end
