//
//  UIBaseViewController.m
//  star
//
//  Created by fuyiming on 14/11/7.
//  Copyright (c) 2014年 spetal. All rights reserved.
//

#import "UIBaseViewController.h"
#import "AppDelegate.h"

@interface UIBaseViewController ()

@end

@implementation UIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UINavigationController *) rootNavigationController{

    return ((AppDelegate *)[UIApplication sharedApplication].delegate ).centerNavigationController;
}

-(UITabBarController *) rootTabBarController{

    return ((AppDelegate *)[UIApplication sharedApplication].delegate ).tabBarViewController;
}

@end
