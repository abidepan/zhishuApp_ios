//
//  ITInputQRCodeViewController.m
//  MatchApp
//
//  Created by fuyiming on 14/12/25.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITInputQRCodeViewController.h"
#import "ITScanDetailViewController.h"

@interface ITInputQRCodeViewController ()

@end

@implementation ITInputQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)onSearchBtnClicked:(id)sender {
    
    if (_qrCodeTxtField.text.length==0) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"二维码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    ITScanDetailViewController * scanDetail = [[ITScanDetailViewController alloc] initWithNibName:@"ITScanDetailViewController" bundle:nil];
    scanDetail.code = _qrCodeTxtField.text;
    scanDetail.codeType = CodeTypeQR;
    
    [self.navigationController pushViewController:scanDetail animated:YES];
    

}
@end
