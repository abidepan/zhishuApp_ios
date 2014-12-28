//
//  ITScanBarCodeViewController.m
//  MatchApp
//
//  Created by fuyiming on 14/12/28.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITScanBarCodeViewController.h"
#import "ITInputBarCodeViewController.h"
#import "ITScanDetailViewController.h"

@interface ITScanBarCodeViewController ()

@end

@implementation ITScanBarCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"条形码扫描";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ====== scan code delegate ======

-(NSArray *) getScanCodeTypes{
    
    return @[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
}

-(void) onInputScanCodeBtnClicked{
    
    ITInputBarCodeViewController * barinputcode = [[ITInputBarCodeViewController alloc] init];
    [self.navigationController pushViewController:barinputcode animated:YES];
}

-(void) onGetScanCode:(ITScanDetailViewController * )scanDetail{
    
    scanDetail.codeType = CodeTypeQR;
}

@end
