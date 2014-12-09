//
//  AppDelegate.h
//  star
//
//  Created by fuyiming on 14/11/6.
//  Copyright (c) 2014年 spetal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) UINavigationController *centerNavigationController;
@property (retain, nonatomic) UIViewController *leftController;
@property (strong, nonatomic) UITabBarController * tabBarViewController;

@end

