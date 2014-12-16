//
//  SDWebServer.m
//  ShanghaiDaily
//
//  Created by fuyiming on 13-6-12.
//  Copyright (c) 2013年 spetal. All rights reserved.
//

#import "WebServer.h"
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"
#import <AdSupport/AdSupport.h>

WebServer  *webserver;
dispatch_queue_t _taskDispatchQueue;

@implementation WebServer
//@synthesize WebServerCallBack = _WebServerCallBack;


+ (WebServer*) instance
{
    if (!webserver) {
        webserver = [[WebServer alloc] init];
        _taskDispatchQueue =dispatch_queue_create("com.itrace.webservices.taskDispatchQueue", DISPATCH_QUEUE_SERIAL);
    }
    return webserver;
}

- (void) startCallServerUrl:(NSString*) url param:(NSDictionary*)dict Succeed:(WebServerCallBack)succeedCallBack Failed:(WebServerCallBack)failedCallBack{
    
    dispatch_async(_taskDispatchQueue, ^(void){
        
        ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]];
        request.requestMethod = @"POST";
        
        if (dict!=nil) {
            id keys = [dict allKeys];
            NSUInteger count = [keys count];
            for (int i = 0; i < count; i++)
            {
                id key = [keys objectAtIndex: i];
                id value = [dict objectForKey: key];
                [request setPostValue:value forKey:key];
            }
        }
        [request setTimeOutSeconds:180];
        request.shouldAttemptPersistentConnection = NO;
        [request startSynchronous];
        
        //BOOL dataValid = NO;
        NSString *responseString = @"";
        int responseCode = -1;
        NSDictionary *resultData = nil;
        
        responseString = [NSString stringWithFormat:@"%@",[request responseString]];
        responseCode = request.responseStatusCode;
        if (responseCode == 200 && [responseString length] > 0) {
            
            resultData = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];//[responseString JSONValue];
            
            if (succeedCallBack!=nil) {
                succeedCallBack(responseCode,resultData);
                return ;
            }
                
            if (resultData) {
                
                succeedCallBack(responseCode,resultData);
            }else{
                
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:responseString delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
                [alert show];
            }
        }else{
            
            if (failedCallBack!=nil) {
                failedCallBack(responseCode,nil);
            }
        }
    });
}

@end
