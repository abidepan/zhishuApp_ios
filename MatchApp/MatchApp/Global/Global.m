//
//  Global.m
//  Pocket
//
//  Created by Fleming Fu on 13-12-24.
//  Copyright (c) 2013年 Spetal. All rights reserved.
//

#import "Global.h"

@implementation Global

+(void) makeBorderedRoundButton:(UIButton *)btn{
    
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 4;
    btn.layer.borderColor = btn.titleLabel.textColor.CGColor;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn.clipsToBounds = YES;

    UIGraphicsBeginImageContextWithOptions(btn.frame.size, NO, 0);
    [[UIColor colorWithCGColor:btn.titleLabel.textColor.CGColor] setFill];
    CGContextFillRect(UIGraphicsGetCurrentContext(), btn.bounds);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [btn setBackgroundImage:image forState:UIControlStateHighlighted];
}

+ (NSString *)stringWithUUID
{
	CFUUIDRef uuidObject = CFUUIDCreate(nil);
	NSString *uuidString = (NSString *)CFBridgingRelease(
                                                         CFUUIDCreateString(nil, uuidObject));
	CFRelease(uuidObject);
	return uuidString;
}

+ (NSString *) stringFromDate:(NSDate *) date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddhhmmss"];
    return [dateFormatter stringFromDate:date];
    
}

+ (NSDate *) dateFromString:(NSString *) str{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMddhhmmss"];
    return [dateFormat dateFromString:str];
}


+ (NSDate *) dateFromShortString:(NSString *) str{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    return [dateFormat dateFromString:str];
}

+ (NSString *) stringFromDate:(NSDate *) date Format:(NSString*)format{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
    
}

+ (NSDate *) dateFromString:(NSString *)str Format:(NSString*)format{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat dateFromString:str];
}

+ (NSString*) getDeviceUid{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

@end
