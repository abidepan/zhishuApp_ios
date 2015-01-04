//
//  Constants.h
//  Iwu
//
//  Created by chris on 4/29/14.
//  Copyright (c) 2014 superjia. All rights reserved.
//


#ifndef kDeviceWidth
    #define kDeviceWidth ([[UIScreen mainScreen] bounds].size.width)
#endif

#ifndef kDeviceHeight
    #define kDeviceHeight ([[UIScreen mainScreen] bounds].size.height)
#endif

#ifndef kRGB
    #define kRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#endif

#ifndef kRGBA
    #define kRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#endif

#define kAppFont(size) [UIFont systemFontOfSize:size]
#define kAppFontBold(size) [UIFont boldSystemFontOfSize:size]

#define kStr(str) NSLocalizedString(str, nil)


#ifndef IOS7
#define IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#endif

#ifndef IOS8
#define IOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#endif

#define kAppleBlueColor kRGB(0.0, 122.0, 255.0)

#define kLightBlueColor kRGB(43.0, 142.0, 216.0)


#define kAppHostProtocal @"http"
#define kAppHost @"itts.itrace.com.cn"
#define kAppHostPort @"80"

#define kAppApi(api) [NSString stringWithFormat:@"%@://%@:%@/%@", kAppHostProtocal, kAppHost, kAppHostPort, api]



typedef enum {
    TagTypeRfid,
    TagTypeQR,
    TagTypeNumber,
    TagTypeBar
}TagType;


typedef enum {
    CodeTypeQR,
    CodeTypeBar,
    CodeTypeNFC,
}CodeType;


typedef enum {
    
    CodeFormatCard,
    CodeFormatPhone,
    CodeFormatText,
    CodeFormatWebsite,
    CodeFormatPosition,
    CodeFormatWifi
}CodeFormat;


typedef enum {
    
    ScanResultFailed = -1,
    ScanResultLegal,
    ScanResultIllegalNoCompany,
    ScanResultIllegalNoProduct,
    ScanResultIllegalError,
    ScanResultIllegalOther
}ScanResultState;




