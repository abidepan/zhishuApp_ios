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
#import "WebServer.h"

@interface UIBaseViewController : UIViewController

-(UINavigationController *) rootNavigationController;
-(UITabBarController *) rootTabBarController;

@property (nonatomic,strong) ITLoadingView* loadingView;

@property (nonatomic,strong) ITErrorView * errorView;

-(void) showErrorViewWithTitle:(NSString*)title Image:(UIImage*)image;
-(void) showLoadingViewWithTitle:(NSString*)title;

-(void) callServerWithUrl:(NSString*) urlString param:(NSDictionary *)param successCallBack:(WebServerCallBack)succeedCallBack loadingOptions:(NSDictionary*)loadingOptions failOptions:(NSDictionary*)faliOptoins;


@end
