//
//  ITUserCenterViewController.m
//  MatchApp
//
//  Created by match on 14-12-10.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITUserCenterViewController.h"
#import "Constants.h"

@interface ITUserCenterViewController ()

@end

@implementation ITUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"用户中心";
    
    _background=[[ITtextFiledBackground alloc] initWithFrame:CGRectMake(20, 200, kDeviceWidth - 40, 100)];
    [_background setBackgroundColor:[UIColor whiteColor]];
    [[_background layer] setCornerRadius:5];
    [[_background layer] setMasksToBounds:YES];
    [self.view addSubview:_background];
    
    _account = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, kDeviceWidth - 60, 50)];
    _account.placeholder =[ NSString stringWithFormat:@"用户名"];
    _account.tintColor = [UIColor blackColor]; // 光标颜色
    _account.layer.cornerRadius = 5.0;
    [_account setClearButtonMode:UITextFieldViewModeAlways];
    [_background addSubview:_account];
    
    _password = [[UITextField alloc] initWithFrame:CGRectMake(20, 50, kDeviceWidth - 60, 50)];
    _password.placeholder = [NSString stringWithFormat:@"密码"];
    _password.secureTextEntry = YES;
    _password.tintColor = [UIColor blackColor];
    _password.layer.cornerRadius = 5.0;
    [_password setClearButtonMode:UITextFieldViewModeAlways];
    [_background addSubview:_password];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_loginButton setFrame:CGRectMake(20, 320, kDeviceWidth - 40, 50)];
    [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [_loginButton setBackgroundColor:[UIColor colorWithRed:51/255.0 green:102/255.0 blue:255/255.0 alpha:1]];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginButton.layer.cornerRadius = 5.0;
    [self.view addSubview:_loginButton];
    
    _findPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_findPasswordButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [_findPasswordButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_findPasswordButton setFrame:CGRectMake(20, 380, 100, 50)];
    _findPasswordButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    _findPasswordButton.showsTouchWhenHighlighted = YES;
    _findPasswordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:_findPasswordButton];
    
    _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registerButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_registerButton setFrame:CGRectMake(kDeviceWidth - 20 - 55, 380, 50, 50)];
    _registerButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    _registerButton.showsTouchWhenHighlighted = YES;
    _registerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:_registerButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
