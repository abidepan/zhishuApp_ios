//
//  ITDataStore.m
//  MatchApp
//
//  Created by fuyiming on 14/12/12.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITDataStore.h"

#define MAX_SAVED_RECORDS 30

NSString * kITLastScanType = @"kITLastScanType";
NSString * kITUserInfo = @"kITUserInfo";
NSString * kITQrCodeHistory = @"kITQrCodeHistory";
NSString * kITBarCodeHistory = @"kITBarCodeHistory";
NSString * kITNfcHistory = @"kITNfcHistory";
NSString * kITSetting = @"kITSetting";

NSString * kITSettingIsScanVoice = @"kITSettingIsScanVoice";
NSString * kITSettingIsScanShake = @"kITSettingIsScanShake";
NSString * kITSettingScanTimeOut = @"kITSettingScanTimeOut";

@implementation ITDataStore

+(ITDataStore *) instance{
    
    static dispatch_once_t itDataStorePredicate;
    static ITDataStore * itDataStore;
    dispatch_once(&itDataStorePredicate, ^{
        itDataStore = [[ITDataStore alloc] init];
        
        itDataStore.userInfo = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:kITUserInfo]];
        
        itDataStore.qrCodeHistoryRecords = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:kITQrCodeHistory]];
        
        itDataStore.barCodeHistoryRecords = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:kITBarCodeHistory]];
        
        itDataStore.nfcHistoryRecords = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:kITNfcHistory]];
        
        itDataStore.lastScanType = [[NSUserDefaults standardUserDefaults] boolForKey:kITLastScanType];
        
        itDataStore.setting = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:kITSetting]];
    });
    return itDataStore;
}

-(void) saveUserInfo:(NSDictionary *) userInfoData{

    _userInfo =[NSMutableDictionary dictionaryWithDictionary:userInfoData];
    
    [[NSUserDefaults standardUserDefaults] setObject:_userInfo forKey:kITUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) removeUserInfo:(NSDictionary *) userInfoRecord{

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kITUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) saveLastScanType:(ITScanType) lastType{

    [[NSUserDefaults standardUserDefaults] setBool:lastType forKey:kITLastScanType];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(void) addQrCodeRecord:(NSDictionary *)qrRawCodeRecord{
    
    NSDictionary * qrCodeRecord  = [self filterNullPointerValues:qrRawCodeRecord];
    
    [_qrCodeHistoryRecords insertObject:qrCodeRecord atIndex:0];
    
    if (_qrCodeHistoryRecords.count > MAX_SAVED_RECORDS) {
        [_qrCodeHistoryRecords removeLastObject];
    }
    [self saveQrCodeRecords];
}

-(void) removeQrRecord:(NSDictionary *)barCodeRecord{

    [_qrCodeHistoryRecords removeObject:barCodeRecord];
    [self saveQrCodeRecords];
}

-(void) saveQrCodeRecords{

    [[NSUserDefaults standardUserDefaults] setObject:_qrCodeHistoryRecords forKey:kITQrCodeHistory];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) addBarCodeRecord:(NSDictionary *)barCodeRecord{

    [_barCodeHistoryRecords insertObject:barCodeRecord atIndex:0];
    
    if (_barCodeHistoryRecords.count > MAX_SAVED_RECORDS) {
        
        [_barCodeHistoryRecords removeLastObject];
    }
    
    [self saveBarCodeRecords];
}

-(void) removeBarRecord:(NSDictionary *)barCodeRecord{

    [_barCodeHistoryRecords removeObject:barCodeRecord];
    [self saveBarCodeRecords];
}

-(void) saveBarCodeRecords{
    
    [[NSUserDefaults standardUserDefaults] setObject:_barCodeHistoryRecords forKey:kITBarCodeHistory];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(void) addNfcRecord:(NSDictionary *)nfcRecord{

    [_nfcHistoryRecords insertObject:nfcRecord atIndex:0];
    
    if (_nfcHistoryRecords.count > MAX_SAVED_RECORDS) {
        
        [_nfcHistoryRecords removeLastObject];
    }
    [self saveNfcCodeRecords];
}

-(void) removeNfcRecord:(NSDictionary *)nfcRecord{

    [_nfcHistoryRecords removeObject:nfcRecord];
    [self saveNfcCodeRecords];
}

-(void) saveNfcCodeRecords{
    
    [[NSUserDefaults standardUserDefaults] setObject:_nfcHistoryRecords forKey:kITNfcHistory];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSDictionary *) filterNullPointerValues:(NSDictionary * )dic{

    NSMutableDictionary * mDic = [[NSMutableDictionary alloc] init];
    for (NSString * key in [dic allKeys]) {
        
        id v =[dic objectForKey:key];
        
        if (v==nil || v==[NSNull null]) {
            [mDic setObject:@"" forKey:key];
        }else
        {
            [mDic setObject:v forKey:key];
        }
    }

    return [NSDictionary dictionaryWithDictionary:mDic];
}

-(void) saveSettingIsScanVoice:(NSString *) settingVoice{

    [self.setting setObject:settingVoice forKey:kITSettingIsScanVoice];
    [[NSUserDefaults standardUserDefaults] setObject:self.setting forKey:kITSetting];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *) getSettingIsScanVoice{

    return [self.setting objectForKey:kITSettingIsScanVoice];
}

-(void) saveSettingIsScanShake:(NSString *) settingShake{

    [self.setting setObject:settingShake forKey:kITSettingIsScanShake];
    [[NSUserDefaults standardUserDefaults] setObject:self.setting forKey:kITSetting];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *) getSettingIsScanShake{

    return [self.setting objectForKey:kITSettingIsScanShake];
}

-(void) saveSettingScanTimeOut:(NSString *) settingScanTimeOut{

    [self.setting setObject:settingScanTimeOut forKey:kITSettingScanTimeOut];
    [[NSUserDefaults standardUserDefaults] setObject:self.setting forKey:kITSetting];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *) getSettingScanTimeOut{

    return [self.setting objectForKey:kITSettingScanTimeOut];
}


@end
