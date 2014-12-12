//
//  ITScanViewController.m
//  MatchApp
//
//  Created by fuyiming on 14/12/9.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITScanHistoryViewController.h"

@interface ITScanHistoryViewController ()

@end

@implementation ITScanHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"扫码历史";
    
    [self showLoadingViewWithTitle:@"加载中..."];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)onRetryPageRequest{
 
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
