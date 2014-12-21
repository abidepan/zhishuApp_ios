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
#import "ITScanHistoryBaseView.h"
#import "ITQRCodeScanHistoryView.h"
#import "ITBarCodeScanHistoryView.h"
#import "ITNfcCodeScanHistoryView.h"


@interface ITScanHistoryViewController ()
{
    UISegmentedControl * _segment;
    NSArray * _scanHistoryViews;
    NSInteger _currentSelectedIndex;
    
}
@end

@implementation ITScanHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"扫码历史";
    
    double y = (IOS7?64:0)+6;
    _segment = [[UISegmentedControl alloc] initWithFrame:CGRectMake(kDeviceWidth/8, y, 0.75*kDeviceWidth, 32.0f)];
    [_segment addTarget:self action:@selector(onValueChanged:) forControlEvents:UIControlEventValueChanged];
    CGRect mainViewRect = CGRectMake(0, y+ 38, kDeviceWidth, kDeviceHeight-y-38) ;
    
    ITScanHistoryBaseView * qrSacnView = [[ITQRCodeScanHistoryView alloc] initWithFrame:mainViewRect];
    ITScanHistoryBaseView * barSacnView = [[ITBarCodeScanHistoryView alloc] initWithFrame:mainViewRect];
    ITScanHistoryBaseView * nfcSacnView = [[ITNfcCodeScanHistoryView alloc] initWithFrame:mainViewRect];
    qrSacnView.parentNav = self.navigationController;
    barSacnView.parentNav = self.navigationController;
    nfcSacnView.parentNav = self.navigationController;
    _scanHistoryViews = @[qrSacnView,barSacnView,nfcSacnView];
    
    for (int i=0; i<_scanHistoryViews.count; i++) {
        ITScanHistoryBaseView * scanView = [_scanHistoryViews objectAtIndex:i];
        [_segment insertSegmentWithTitle:scanView.title atIndex:i animated:NO];
    }
    _currentSelectedIndex = _segment.selectedSegmentIndex = [ITDataStore instance].lastScanType;
    
    [self.view addSubview:_segment];
    [self.view addSubview:[_scanHistoryViews objectAtIndex:_segment.selectedSegmentIndex]];
}




-(void) onValueChanged:(UISegmentedControl *) segment{

    NSInteger newIndex = segment.selectedSegmentIndex;
    
    double y = (IOS7?64:0)+44;
    if(_currentSelectedIndex != newIndex){
    
        
        UIView * oldView = [_scanHistoryViews objectAtIndex:_currentSelectedIndex];
        UIView * newView = [_scanHistoryViews objectAtIndex:newIndex];
        
        BOOL right =  newIndex > _currentSelectedIndex;
        
        [newView setFrame:CGRectMake(right ? kDeviceWidth : -kDeviceWidth, y, kDeviceWidth, kDeviceHeight-y)];
        
        [self.view addSubview: newView];
        
        [UIView animateWithDuration:0.35 animations:^{
            [oldView setFrame:CGRectMake(right ?-kDeviceWidth:kDeviceWidth, y, kDeviceWidth, kDeviceHeight-y)];
            [newView setFrame:CGRectMake(0, y, kDeviceWidth, kDeviceHeight-y)];
            
        } completion:^(BOOL finished) {
            [oldView removeFromSuperview];
            
        }];
        _currentSelectedIndex = newIndex;
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)onRetryPageRequest{
 
    
}
@end
