//
//  ITScanCodeBaseViewController.h
//  MatchApp
//
//  Created by fuyiming on 14/12/28.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "UIBaseViewController.h"

@interface ITScanCodeBaseViewController :  UIBaseViewController<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
{
    double timeoutCount;
    int num;
    NSTimer * timer;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;

@end
