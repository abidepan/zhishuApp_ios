//
//  ITDataStore.h
//  MatchApp
//
//  Created by fuyiming on 14/12/12.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    ScanTypeQrCode,
    ScanTypeBarCode,
    ScanTypeNfc
}ITScanType; // 扫描类型

@interface ITDataStore : NSObject

// 数据存储
// 用户信息
@property (nonatomic,strong) NSMutableDictionary * userInfo;
// 设置信息
@property (nonatomic,strong) NSMutableDictionary * setting;
// 二维码历史记录
@property (nonatomic,strong) NSMutableArray * qrCodeHistoryRecords;
// 条形码历史记录
@property (nonatomic,strong) NSMutableArray * barCodeHistoryRecords;
// nfc历史记录
@property (nonatomic,strong) NSMutableArray * nfcHistoryRecords;

@property (nonatomic,assign)  ITScanType lastScanType;

+(ITDataStore *) instance;

-(void) saveUserInfo:(NSDictionary *) userInfoRecord;
-(void) removeUserInfo:(NSDictionary *) userInfoRecord;

-(void) saveLastScanType:(ITScanType) lastType;
-(NSInteger) getLastScanType;

-(void) addQrCodeRecord:(NSDictionary *)qrCodeRecord;
-(void) removeQrRecord:(NSDictionary *)barRecord;


-(void) addBarCodeRecord:(NSDictionary *)barCodeData;
-(void) removeBarRecord:(NSDictionary *)barRecord;


-(void) addNfcRecord:(NSDictionary *)nfcRecord;
-(void) removeNfcRecord:(NSDictionary *)nfcRecord;

-(void) saveSettingIsScanVoice:(BOOL) settingVoice;
-(BOOL) getSettingIsScanVoice;

-(void) saveSettingIsScanShake:(BOOL) settingShake;
-(BOOL) getSettingIsScanShake;

-(void) saveSettingScanTimeOut:(NSString *) settingScanTimeOut;
-(NSString *) getSettingScanTimeOut;


@end
