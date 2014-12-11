//
//  UIBaseViewController.h
//  star
//
//  Created by fuyiming on 14/11/7.
//  Copyright (c) 2014年 spetal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITLoadingView.h"
#import "ITErrorView.h"

@interface UIBaseViewController : UIViewController

-(UINavigationController *) rootNavigationController;
-(UITabBarController *) rootTabBarController;

@property (nonatomic,strong) ITLoadingView* loadingView;

@property (nonatomic,strong) ITErrorView * errorView;


@end
