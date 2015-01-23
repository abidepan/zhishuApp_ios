//
//  ITScanCodeBaseViewController.m
//  MatchApp
//
//  Created by fuyiming on 14/12/28.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITScanCodeBaseViewController.h"
#import "ITScanDetailViewController.h"
#import "Constants.h"
#import "ITInputQRCodeViewController.h"
#import "ITDataStore.h"
#import "ITScanRectView.h"

@interface ITScanCodeBaseViewController ()
{
    CGRect _scanRect;
    CGRect _lineRect;
    UIButton * _lightBtn;
    UILabel * _labIntroudction;
}
@end

@implementation ITScanCodeBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    double y = IOS7?100:36;
    _scanRect = CGRectMake(30, y, kDeviceWidth-60, kDeviceWidth-60);
    _lineRect = CGRectMake(_scanRect.origin.x+10, _scanRect.origin.y, _scanRect.size.width-20, 2);
    [self initScanView];
    
    [self setupCamera];
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [self startScan];
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [self stopScan];
    if (_lightBtn.tag==1) {
        [self setLightOn:NO];
    }
}



-(void) startScan{

    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(scanAnimation) userInfo:nil repeats:YES];
    
    if ([_session canAddInput:self.input]) [_session addInput:self.input];
    if ([_session canAddOutput:self.output])[_session addOutput:self.output];
    [_session startRunning];
}

-(void) stopScan{

    [timer invalidate];
    timeoutCount =0;
    [_session removeInput:self.input];
    [_session removeOutput:self.output];
    [_session stopRunning];
}

-(void) initScanView{
    
    [self initBlackTransparentBackground];
    self.view.backgroundColor = [UIColor clearColor];
    
    _labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(10, _scanRect.origin.y+_scanRect.size.height+30.0f, kDeviceWidth-20 , 25)];
    _labIntroudction.backgroundColor = [UIColor clearColor];
    _labIntroudction.font = kAppFont(15);
    _labIntroudction.minimumScaleFactor = 0.5;
    _labIntroudction.adjustsFontSizeToFitWidth = YES;
    _labIntroudction.textAlignment = NSTextAlignmentCenter;
    _labIntroudction.textColor=[UIColor whiteColor];
    _labIntroudction.text=@"将二维码图像置于矩形方框内，即可自动扫描识别。";
    [self.view addSubview:_labIntroudction];
    
    
    ITScanRectView * scanRect = [[ITScanRectView alloc] initWithFrame:_scanRect];
    [self.view addSubview:scanRect];
    
    timeoutCount=0.0f;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:_lineRect];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    
}

-(void) initBlackTransparentBackground{
    
    UIView * vw1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, _scanRect.origin.y)];
    UIView *vw2 = [[UIView alloc] initWithFrame:CGRectMake(0, _scanRect.origin.y, _scanRect.origin.x, _scanRect.size.height)];
    UIView *vw3 = [[UIView alloc] initWithFrame:CGRectMake(_scanRect.size.width + _scanRect.origin.x, _scanRect.origin.y, _scanRect.origin.x, _scanRect.size.height)];
    UIView * vw4 = [[UIView alloc] initWithFrame:CGRectMake(0, _scanRect.origin.y +_scanRect.size.height, kDeviceWidth, kDeviceHeight - _scanRect.origin.y -_scanRect.size.height)];
    
    [vw1 setBackgroundColor:kRGBA(0, 0, 0, 0.5)];
    [vw2 setBackgroundColor:kRGBA(0, 0, 0, 0.5)];
    [vw3 setBackgroundColor:kRGBA(0, 0, 0, 0.5)];
    [vw4 setBackgroundColor:kRGBA(0, 0, 0, 0.5)];
    
    [self.view addSubview:vw1];
    [self.view addSubview:vw2];
    [self.view addSubview:vw3];
    [self.view addSubview:vw4];
    
    double t = (kDeviceHeight- _scanRect.origin.y-_scanRect.size.height-50.0f)*2/3;
    double startY = kDeviceHeight-MAX(t, 60) - (IOS7?0:64);
    
    UIView * moreBtnsView = [[UIView alloc] initWithFrame:CGRectMake(_scanRect.origin.x, startY+5, _scanRect.size.width, 30)];
    
    moreBtnsView.backgroundColor = kLightBlueColor;
    moreBtnsView.layer.cornerRadius = 4;
    [self.view addSubview:moreBtnsView];
    
    UIView * spliteView = [[UIView alloc] initWithFrame:CGRectMake(_scanRect.origin.x+ _scanRect.size.width/2, startY+5, 0.5, 30)];
    spliteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:spliteView];
    
    _lightBtn = [[UIButton alloc] initWithFrame:CGRectMake(_scanRect.origin.x , startY, _scanRect.size.width/2, 40)];
    _lightBtn.tag =0;
    [self.view addSubview:_lightBtn];
    [_lightBtn setTitle:@"开闪光灯" forState:UIControlStateNormal];
    [_lightBtn addTarget:self action:@selector(onLightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * inputBtn = [[UIButton alloc] initWithFrame:CGRectMake(_scanRect.origin.x + _scanRect.size.width/2, startY, _scanRect.size.width/2, 40)];
    [self.view addSubview:inputBtn];
    
    [inputBtn setTitle:@"手动输入" forState:UIControlStateNormal];
    [inputBtn addTarget:self action:@selector(onInputBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void) onLightBtnClicked{
    
    [self setLightOn:(_lightBtn.tag==0)];
}


-(void) setLightOn:(BOOL)isOn{
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]&& [device hasFlash]) {
        [device lockForConfiguration:nil];
        _lightBtn.tag = isOn?1:0;
        [device setTorchMode: _lightBtn.tag];//AVCaptureTorchModeOn
        [device setFlashMode:_lightBtn.tag];
        [device unlockForConfiguration];
        
        [_lightBtn setTitle:!isOn?@"开闪光灯":@"关闪光灯" forState:UIControlStateNormal];
        
    }else{
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"未检测到闪光灯,请检查。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return ;
    }
}


-(void) onInputBtnClicked{
    
    [self onInputScanCodeBtnClicked];
}

-(void)scanAnimation
{
    //处理超时
    timeoutCount += 0.02;
    NSString * scanTimeOut = [[ITDataStore instance] getSettingScanTimeOut] ;
    if (!scanTimeOut) scanTimeOut = @"30秒";
    
    NSInteger timeout =  [[scanTimeOut stringByReplacingOccurrencesOfString:@"秒" withString:@""] integerValue];
    if (timeoutCount >= timeout) {
        
        [self stopScan];
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"扫描超时啦~~" delegate:self cancelButtonTitle:@"继续扫码" otherButtonTitles:@"手动输入", nil];
        alert.delegate = self;
        alert.tag = 999;
        [alert show];
    }
    
    //处理扫描动画
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
    if (![self isCameraAvailable]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"未检测到摄像头,请检查。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
        return ;
    }
    
    if(IOS7)
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
        _output.metadataObjectTypes =[self getScanCodeTypes];// 类型
        _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _preview.frame =self.view.layer.bounds;
        [self.view.layer insertSublayer:self.preview atIndex:0];
        
        [_session startRunning];
    }
}

-(BOOL) isCameraAvailable{
    
    BOOL cameraAvailable = [UIImagePickerController isCameraDeviceAvailable:
                            UIImagePickerControllerCameraDeviceRear];//前
    BOOL frontCameraAvailable = [UIImagePickerController isCameraDeviceAvailable:
                                 UIImagePickerControllerCameraDeviceFront];//后
    return cameraAvailable || frontCameraAvailable;
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
    
    [self playSoundAndShake];
    
    [_session removeInput:self.input];
    [_session removeOutput:self.output];
    [_session stopRunning];
    
    ITScanDetailViewController * scanDetail = [[ITScanDetailViewController alloc] initWithNibName:@"ITScanDetailViewController" bundle:nil];
    scanDetail.code = stringValue;
    [self onGetScanCode:scanDetail];
    [self.navigationController pushViewController:scanDetail animated:YES];
    
    NSLog(@"%@",stringValue);
}


-(void) playSoundAndShake{

    if ([[ITDataStore instance] getSettingIsScanShake]) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    
    if ([[ITDataStore instance] getSettingIsScanVoice]) {
    
        static SystemSoundID soundIDTest = 0;
        NSString * path = [[NSBundle mainBundle] pathForResource:@"sound" ofType:@"mp3"];
        if (path) {
            AudioServicesCreateSystemSoundID( (__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundIDTest );
        }
        AudioServicesPlaySystemSound( soundIDTest );
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark ===== alertview delegate =====

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 999) {
        if (buttonIndex == 0) {
            
            [self startScan];
        }
        else
        {
            [self onInputScanCodeBtnClicked];
            
        }
    }
}

#pragma mark ====== scan code delegate ======

-(NSArray *) getScanCodeTypes{return @[AVMetadataObjectTypeQRCode];}

-(void) onInputScanCodeBtnClicked{ }

-(void) onGetScanCode:(ITScanDetailViewController * )scanDetail{}

@end
