//
//  ITScanDetailViewController.m
//  MatchApp
//
//  Created by fuyiming on 14/12/21.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITScanDetailViewController.h"
#import "Global.h"
#import "ITDataStore.h"

@interface ITScanDetailViewController ()

@end

@implementation ITScanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫码详情";
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

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    _bgScrollView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight +100);
}


-(void) requestDataFromServer{
    
    if (_code==nil || _code.length == 0) { return;}
    
    NSString * url = kAppApi(@"api/product/verify.json");
    // 01L013B001AF907BBG0EJW
    NSDictionary * dic = @{@"data":_code,@"device_id":[Global getDeviceUid],@"location":@"100.0,100.0"};
    
    [self callServerWithUrl:url param:dic successCallBack:^(NSInteger code, id data) {
        
        [self showRemoteData:data];
        
        
    } loadingOptions:nil failOptions:nil];
}

-(void) showRemoteData:(NSDictionary *) data{

    NSString * productStr = [data objectForKey:@"product"];
    NSDictionary * product = [NSJSONSerialization JSONObjectWithData:[productStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    [self showData:product];
    [[ITDataStore instance] addQrCodeRecord:product];
}


-(void) showData:(NSDictionary *) product{
    
    UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, kDeviceWidth-20, 200)];
    lbl.numberOfLines = 0;
    lbl.text = [NSString stringWithFormat:@"%@ = %@ ,\n %@ = %@ ,\n %@ = %@ ,\n %@ = %@ ,\n %@ = %@ ,\n", @"company_name",[product objectForKey:@"company_name"] ,@"company_addr",[product objectForKey:@"company_addr"] ,@"company_contact",[product objectForKey:@"company_contact"] ,@"product_name",[product objectForKey:@"product_name"] ,@"factory_name",[product objectForKey:@"factory_name"] ,nil];
    
    //[self.view addSubview: lbl];
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
