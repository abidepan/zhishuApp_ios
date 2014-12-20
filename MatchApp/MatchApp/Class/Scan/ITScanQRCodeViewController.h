//
//  ITScanQRCodeViewController.h
//  MatchApp
//
//  Created by fuyiming on 14/12/9.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface ITScanQRCodeViewController : UIViewController<ZBarReaderDelegate,ZBarReaderViewDelegate>
{
    ZBarReaderView * _readerView;
    ZBarCameraSimulator * _cameraSim;
}

@end
