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


-(void) addQrCodeRecord:(NSDictionary *)qrCodeRecord{
    
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



@end
