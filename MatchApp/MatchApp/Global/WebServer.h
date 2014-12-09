//
//  WebServer.h
//  Pocket
//
//  Created by fuyiming on 13-11-6.
//  Copyright (c) 2013年 Spetal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WebServerCallBack)(NSInteger,id);

@interface WebServer : NSObject
{
    
    
}

//@property (nonatomic,strong) NSString* (^WebServerCallBack)(NSInteger,id) ;

+ (WebServer*) instance;
- (void) startCallServerUrl:(NSString*) url param:(NSDictionary*)dic Succeed:(WebServerCallBack)succeedCallBack Failed:(WebServerCallBack)failedCallBack;

@end
