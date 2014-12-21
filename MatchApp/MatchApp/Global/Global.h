//
//  Global.h
//  Pocket
//
//  Created by Fleming Fu on 13-12-24.
//  Copyright (c) 2013年 Spetal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Global : NSObject

+(void) makeBorderedRoundButton:(UIButton *)btn;

+ (NSString *)stringWithUUID;

+ (NSDate *) dateFromString:(NSString *) str;
+ (NSString *) stringFromDate:(NSDate *) date;
+ (NSDate *) dateFromShortString:(NSString *) str;
+ (NSDate *) dateFromString:(NSString *)str Format:(NSString*)format;
+ (NSString *) stringFromDate:(NSDate *) date Format:(NSString*)format;

+ (NSString*) getDeviceUid;
@end
