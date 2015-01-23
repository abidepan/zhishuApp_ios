//
//  ITInputCodeBaseViewController.m
//  MatchApp
//
//  Created by fuyiming on 14/12/28.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITInputCodeBaseViewController.h"
#import "ITScanDetailViewController.h"

@interface ITInputCodeBaseViewController ()

@end

@implementation ITInputCodeBaseViewController

-(instancetype)init{

    self = [super init];
    
    if (self) {
        
    }
    return self;
}


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:@"ITInputCodeBaseViewController" bundle:nibBundleOrNil];
    
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bottomBg.layer.cornerRadius = 4;
    self.title = @"手动输入";
    
    _line1.frame = CGRectMake(_line1.frame.origin.x, _line1.frame.origin.y, _line1.frame.size.width, 0.5);
    _line2.frame = CGRectMake(_line2.frame.origin.x, _line2.frame.origin.y, _line2.frame.size.width, 0.5);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onSearchBtnClicked:(id)sender {
    
    if (_qrCodeTxtField.text.length == 0) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"二维码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    ITScanDetailViewController * scanDetail = [[ITScanDetailViewController alloc] initWithNibName:@"ITScanDetailViewController" bundle:nil];
    scanDetail.code = _qrCodeTxtField.text;
    scanDetail.codeType = CodeTypeQR;
    
    [self.navigationController pushViewController:scanDetail animated:YES];
    
    
}
- (IBAction)onClearBtnClicked:(id)sender {
    
    _qrCodeTxtField.text = @"";
}

@end
