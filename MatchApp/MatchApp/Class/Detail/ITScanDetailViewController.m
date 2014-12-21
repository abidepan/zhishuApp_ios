//
//  ITScanDetailViewController.m
//  MatchApp
//
//  Created by fuyiming on 14/12/21.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITScanDetailViewController.h"
#import "Global.h"

@interface ITScanDetailViewController ()

@end

@implementation ITScanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫码详情";
    
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

-(void) loadData{

    if (_dataInfo ) {
        [self showData:_dataInfo];
    }else
    {
        [self requestDataFromServer];
    }
}


-(void) requestDataFromServer{

    NSString * url = kAppApi(@"api/product/verify.json");
    NSDictionary * dic = @{@"data":@"text:突发非常",@"device_id":[Global getDeviceUid],@"location":@"100.0,100.0"};
    
    [self callServerWithUrl:url param:dic successCallBack:^(NSInteger code, id data) {

        [self showData:data];
        
    } loadingOptions:nil failOptions:nil];

}


-(void) showData:(NSDictionary *) data{

    
}

-(void)onRetryPageRequest{
    
    [self requestDataFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
