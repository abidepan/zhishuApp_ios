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
#import "WebServer.h"

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


-(void) callServerWithUrl:(NSString*) urlString param:(NSDictionary *)param successCallBack:(WebServerCallBack)succeedCallBack loadingOptions:(NSDictionary*)loadingOptions failOptions:(NSDictionary*)faliOptoins{

    [self showLoadingViewWithTitle:[loadingOptions objectForKey:@"title"]];
    
    [[WebServer instance] startCallServerUrl:urlString param:param Succeed:^(NSInteger code, id data) {
        succeedCallBack(code,data);
        
    } Failed:^(NSInteger code, id data) {
        
        [self showErrorViewWithTitle:[faliOptoins objectForKey:@"title"]  Image:[faliOptoins objectForKey:@"image"]];
    }];
}


-(void) showErrorViewWithTitle:(NSString*)descTitle Image:(UIImage*)image{

    if (_errorView==nil) {
        
        _errorView = [[[NSBundle mainBundle] loadNibNamed:@"ITErrorView" owner:self options:nil] objectAtIndex:0];
        _errorView.bounds = self.view.bounds;
        
        [_errorView.errorBtn addTarget:self action:@selector(onErrorBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (descTitle!=nil) _errorView.errorTitleLbl.text = descTitle;
    if (image!=nil) [_errorView.errorImgView setImage:image];
    
    [self.view addSubview:_errorView];
    
}

-(void) showLoadingViewWithTitle:(NSString*)descTitle{
    
    if (_loadingView==nil) {
        
        _loadingView = [[[NSBundle mainBundle] loadNibNamed:@"ITLoadingView" owner:self options:nil] objectAtIndex:0];
        [_loadingView initLoadingContent];
        _loadingView.bounds = self.view.bounds;
    }
    if (descTitle !=nil)  _loadingView.progressHUD.labelText = descTitle;
    
    
    [self.view addSubview:_loadingView];
    
}

-(void) dismissErrorView{

    [_errorView removeFromSuperview];
}

-(void) dismissLoadingView{
    
    [_loadingView removeFromSuperview];
}

-(void) onErrorBtnClicked{

    if ([self respondsToSelector:@selector(onRetryPageRequest)]) {
        [self onRetryPageRequest];
    }
}

-(void)onRetryPageRequest{

}

@end
