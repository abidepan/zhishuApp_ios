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
{
    CGRect _scanRect;
    CGRect _lineRect;
}

@end

@implementation ITScanQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"二维码扫描";
    
    _scanRect = CGRectMake(30, 80, kDeviceWidth-60, kDeviceWidth-60);
    _lineRect = CGRectMake(_scanRect.origin.x+10, _scanRect.origin.y, _scanRect.size.width-20, 2);
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initScanView];
    [self setupCamera];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [timer invalidate];
    [_session stopRunning];
}

-(void) initScanView{

    self.view.backgroundColor = [UIColor clearColor];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(0, _scanRect.origin.y+_scanRect.size.height+30.0f, kDeviceWidth , 25)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.font = kAppFont(13);
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将二维码图像置于矩形方框内，即可自动扫描识别。";
    [self.view addSubview:labIntroudction];

    UIImageView * imageView = [[UIImageView alloc]initWithFrame:_scanRect];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    num =0;
    _line = [[UIImageView alloc] initWithFrame:_lineRect];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(scanAnimation) userInfo:nil repeats:YES];

}

-(void)scanAnimation
{
    num ++;
    if (2*num >= _scanRect.size.height) {
        _line.frame = _lineRect;
        num = 0;
    }else{
        _line.frame = CGRectMake(_lineRect.origin.x, _lineRect.origin.y+2*num, _lineRect.size.width, _lineRect.size.height);
    }
}

- (void)setupCamera
{
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_output setRectOfInterest:CGRectMake(_scanRect.origin.y/kDeviceHeight, _scanRect.origin.x/kDeviceWidth, _scanRect.size.height/kDeviceHeight, _scanRect.size.width/kDeviceWidth)];
    
    
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input]) [_session addInput:self.input];
    if ([_session canAddOutput:self.output])[_session addOutput:self.output];
    
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];// 类型
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    [_session startRunning];
}

#pragma mark ====== AVCaptureMetadataOutputObjectsDelegate ======

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    [_session stopRunning];
     NSLog(@"%@",stringValue);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
