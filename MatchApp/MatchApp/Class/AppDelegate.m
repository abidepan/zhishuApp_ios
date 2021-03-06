//
//  AppDelegate.m
//  star
//
//  Created by fuyiming on 14/11/6.
//  Copyright (c) 2014年 spetal. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"
#import "Constants.h"
#import "ITDataStore.h"
#import "MobClick.h"
#import "UMFeedback.h"
#import "UMSocial.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //[application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [ITDataStore instance];
    [self setAppearance];
    
    // 友盟
    [MobClick startWithAppkey:@"54b7778bfd98c56e3a000b94" reportPolicy:BATCH channelId:@""];
    
    // 更新
    //[MobClick checkUpdate:@"有新版本更新啦！" cancelButtonTitle:@"暂不更新" otherButtonTitles:@"去更新"];
    
    // 用户反馈
    [UMFeedback setAppkey:@"54b7778bfd98c56e3a000b94"];
    
    // 社会化分享
    [UMSocialData setAppKey:@"54b7778bfd98c56e3a000b94"];
    
    return YES;
}

-(void) setAppearance{
    
    if (IOS7) {
        [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              kAppleBlueColor,
                                                              NSForegroundColorAttributeName,
                                                              nil]];
        
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                             forBarMetrics:UIBarMetricsDefault];
        
    }else
    {
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kAppleBlueColor}];

    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
