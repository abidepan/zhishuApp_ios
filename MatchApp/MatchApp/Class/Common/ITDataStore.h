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
}ITScanType;

@interface ITDataStore : NSObject

@property (nonatomic,strong) NSMutableDictionary * userInfo;
@property (nonatomic,strong) NSMutableDictionary * setting;
@property (nonatomic,strong) NSMutableArray * qrCodeHistoryRecords;
@property (nonatomic,strong) NSMutableArray * barCodeHistoryRecords;
@property (nonatomic,strong) NSMutableArray * nfcHistoryRecords;

@property (nonatomic,assign)  ITScanType lastScanType;

+(ITDataStore *) instance;

-(void) saveUserInfo:(NSDictionary *) userInfoRecord;
-(void) removeUserInfo:(NSDictionary *) userInfoRecord;

-(void) saveLastScanType:(ITScanType) lastType;

-(void) addQrCodeRecord:(NSDictionary *)qrCodeRecord;
-(void) removeQrRecord:(NSDictionary *)barRecord;


-(void) addBarCodeRecord:(NSDictionary *)barCodeData;
-(void) removeBarRecord:(NSDictionary *)barRecord;


-(void) addNfcRecord:(NSDictionary *)nfcRecord;
-(void) removeNfcRecord:(NSDictionary *)nfcRecord;

-(void) saveSettingIsScanVoice:(NSString *) settingVoice;
-(NSString *) getSettingIsScanVoice;

-(void) saveSettingIsScanShake:(NSString *) settingShake;
-(NSString *) getSettingIsScanShake;

-(void) saveSettingScanTimeOut:(NSString *) settingScanTimeOut;
-(NSString *) getSettingScanTimeOut;


@end
