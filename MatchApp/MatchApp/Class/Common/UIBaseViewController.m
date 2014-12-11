//
//  UIBaseViewController.m
//  star
//
//  Created by fuyiming on 14/11/7.
//  Copyright (c) 2014年 spetal. All rights reserved.
//

#import "UIBaseViewController.h"
#import "AppDelegate.h"
#import "ITLoadingView.h"
#import "ITErrorView.h"

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


-(void) showErrorViewWithTitle:(NSString*)title Image:(UIImage*)image{

    if (_errorView==nil) {
        
        _errorView = [[[NSBundle mainBundle] loadNibNamed:@"ITErrorView" owner:self options:nil] objectAtIndex:0];
    }
    
}

-(void) showLoadingViewWithTitle:(NSString*)title Image:(UIImage*)image{
    
    if (_loadingView==nil) {
        
        _loadingView = [[[NSBundle mainBundle] loadNibNamed:@"ITLoadingView" owner:self options:nil] objectAtIndex:0];
        [_loadingView initLoadingContent];
    }
    
}

@end
