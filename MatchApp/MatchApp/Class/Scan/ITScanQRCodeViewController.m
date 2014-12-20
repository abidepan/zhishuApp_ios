//
//  ITScanQRCodeViewController.m
//  MatchApp
//
//  Created by fuyiming on 14/12/9.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITScanQRCodeViewController.h"
#import "ZBarSDK.h"

@interface ITScanQRCodeViewController ()

@end

@implementation ITScanQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"二维码扫描";
    
//    _readerView = [[ZBarReaderView alloc]init];
//    _readerView.frame = self.view.bounds;
//    _readerView.frame = CGRectMake(0, 0, kDeviceWidth-60, kDeviceWidth-60);
//    
//    _readerView.scanCrop = CGRectMake(30,(kDeviceHeight - kDeviceWidth+60 )/2, kDeviceWidth-60, kDeviceWidth-60);
//    
//    _readerView.readerDelegate = self;
    

    _readerView = [[ZBarReaderView alloc] init];
    //_readerView.frame = CGRectMake(0-2, 0-2, bgImgView.frame.size.width+4, heightReaderView);
    _readerView.frame = CGRectMake(30,(kDeviceHeight - kDeviceWidth+60 )/2, kDeviceWidth-60, kDeviceWidth-60);
    _readerView.readerDelegate = self;
    //关闭闪光灯
    _readerView.torchMode = 0;
    _readerView.tracksSymbols = NO;
    [_readerView setZoom:1.5];
    [_readerView setBackgroundColor:[UIColor whiteColor]];
    _readerView.layer.borderColor = [UIColor blackColor].CGColor;
    _readerView.layer.borderWidth = 2;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_readerView start];
    [self.view addSubview:_readerView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark ====== ZBAR ======
- (void) readerControllerDidFailToRead: (ZBarReaderController*) reader
                             withRetry: (BOOL) retry{


}



- (void) readerView: (ZBarReaderView*) readerView
     didReadSymbols: (ZBarSymbolSet*) symbols
          fromImage: (UIImage*) image{


}


@end
