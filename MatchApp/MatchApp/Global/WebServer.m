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
        _taskDispatchQueue =dispatch_queue_create("com.spetal.webservices.taskDispatchQueue", DISPATCH_QUEUE_SERIAL);
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
                
                NSString* str= [NSString stringWithFormat:@"Get price table failed:code=%d,%@", responseCode,responseString];
                [self performSelectorOnMainThread:@selector(onErrorOccurred:) withObject:str waitUntilDone:NO];
            }
        }else{
            
            if (failedCallBack!=nil) {
                failedCallBack(responseCode,nil);
                return;
            }
            
            NSString * title = @"Access Failed";
            NSString * str= [NSString stringWithFormat:@"Get price table failed:code=%d,error=%@", responseCode,[request error]];
            
            switch ([request error].code) {
                case 1:
                    
                    title = @"No Internet Connection";
                    str= @"Oops! The application cannot access any online content. Please check your internet connection and try again.";
                    break;
                    
                case 2:
                    title = @"Connection Time Out";
                    str= @"Try to relaunch the application.";
                    break;
            }
            
            NSMutableArray * ar = [[NSMutableArray alloc] initWithObjects:title,str, nil];
            [self performSelectorOnMainThread:@selector(onErrorOccurred:) withObject:ar  waitUntilDone:NO];
        }
    });
}


-(void) onErrorOccurred:(NSMutableArray*) ar{
    
    [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].windows objectAtIndex:0] animated:YES];
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString([ar objectAtIndex:0], nil)
                                message:NSLocalizedString([ar objectAtIndex:1], nil)
                               delegate:self
                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                      otherButtonTitles:nil] show];
}



@end
