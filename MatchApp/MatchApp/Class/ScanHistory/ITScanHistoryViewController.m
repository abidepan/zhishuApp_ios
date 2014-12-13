//
//  ITScanViewController.m
//  MatchApp
//
//  Created by fuyiming on 14/12/9.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITScanHistoryViewController.h"
#import "Constants.h"
#import "ITDataStore.h"

@interface ITScanHistoryViewController ()
{
    UISegmentedControl * _segment;
    
    NSArray * _tableViews;
    
}
@end

@implementation ITScanHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"扫码历史";
    
    double y = (IOS7?64:0)+6;
    
    _segment = [[UISegmentedControl alloc] initWithFrame:CGRectMake(kDeviceWidth/8, y, 0.75*kDeviceWidth, 32.0f)];
    [_segment insertSegmentWithTitle:@"二维码" atIndex:0 animated:NO];
    [_segment insertSegmentWithTitle:@"条码" atIndex:1 animated:NO];
    [_segment insertSegmentWithTitle:@"NFC" atIndex:2 animated:NO];
    [_segment addTarget:self action:@selector(onValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segment];
    _segment.selectedSegmentIndex = [ITDataStore instance].lastScanType;
    
    UITableView* table1 = [[UITableView alloc] initWithFrame:CGRectMake(0, y+ 38, kDeviceWidth, kDeviceHeight-y-38) style:UITableViewStylePlain];
    UITableView* table2 = [[UITableView alloc] initWithFrame:CGRectMake(0, y+ 38, kDeviceWidth, kDeviceHeight-y-38) style:UITableViewStylePlain];
    UITableView* table3 = [[UITableView alloc] initWithFrame:CGRectMake(0, y+ 38, kDeviceWidth, kDeviceHeight-y-38) style:UITableViewStylePlain];
    
    _tableViews = @[table1,table2,table3];
    
    [self.view addSubview:table1];
}

-(void) onValueChanged:(UISegmentedControl *) segment{

    NSInteger index = segment.selectedSegmentIndex;
    
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)onRetryPageRequest{
 
    
}
@end
