//
//  AppDelegate.m
//  star
//
//  Created by fuyiming on 14/11/6.
//  Copyright (c) 2014年 spetal. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "Constants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.centerNavigationController = [[UINavigationController alloc] initWithRootViewController:self.window.rootViewController];
    _centerNavigationController.navigationBar.translucent = NO;
    
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    [self setAppearance];
    
    return YES;
}

-(void) setAppearance{
    
    if (IOS7) {
        [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              kWhiteColor,
                                                              NSForegroundColorAttributeName,
                                                              [UIFont boldSystemFontOfSize:20],
                                                              NSFontAttributeName,
                                                              nil]];
        [[UINavigationBar appearance] setTintColor:kWhiteColor];
        //kRGB(217, 105, 105)
        [[UINavigationBar appearance] setBarTintColor:kLightBlueColor];
        [[UITabBar appearance] setBackgroundColor:kLightBlueColor];
        [[UITabBar appearance] setTintColor:kAppleRedColor];
        
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                             forBarMetrics:UIBarMetricsDefault];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }else
    {
        [[UINavigationBar appearance] setTintColor:kLightBlueColor];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [[UIBarButtonItem appearance] setTintColor:kLightBlueColor];
        [[UITabBar appearance] setTintColor:kAppleRedColor];
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