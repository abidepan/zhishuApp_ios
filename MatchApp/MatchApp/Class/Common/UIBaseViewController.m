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
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissLoadingView];
            succeedCallBack(code,data);
        });
        
    } Failed:^(NSInteger code, id data) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissLoadingView];
            [self showErrorViewWithTitle:[faliOptoins objectForKey:@"title"]  Image:[faliOptoins objectForKey:@"image"]];
        });
        
    }];
}


-(void) showErrorViewWithTitle:(NSString*)descTitle Image:(UIImage*)image{

    if (_errorView==nil) {
        
        _errorView = [[[NSBundle mainBundle] loadNibNamed:@"ITErrorView" owner:self options:nil] objectAtIndex:0];
        [_errorView.errorBtn addTarget:self action:@selector(onErrorBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _errorView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    _errorView.errorTitleLbl.text = (descTitle==nil)?@"网络访问出错，请点击重试！":descTitle;
    if (image!=nil) [_errorView.errorImgView setImage:image];
    
    [self.view addSubview:_errorView];
    
}

-(void) showLoadingViewWithTitle:(NSString*)descTitle{
    
    if (_loadingView==nil) {
        
        _loadingView = [[ITLoadingView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
        [_loadingView initLoadingContent];
    }
    _loadingView.progressHUD.labelText = (descTitle ==nil)?@"加载中" :descTitle;
   
    [self.view addSubview:_loadingView];
    
}

-(void) dismissErrorView{

    [_errorView removeFromSuperview];
}

-(void) dismissLoadingView{
    
    [_loadingView removeFromSuperview];
}

-(void) onErrorBtnClicked{

    
    if ([self respondsToSelector:@selector(onRetryPageRequest)]
        && _errorView.superview !=nil) {
        [self dismissErrorView];
        [self onRetryPageRequest];
    }
    
    NSLog(@"%@",@"error btn clicked");
}

-(void)onRetryPageRequest{

}

@end
