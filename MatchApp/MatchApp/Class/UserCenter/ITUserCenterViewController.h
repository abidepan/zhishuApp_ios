//
//  ITUserCenterViewController.h
//  MatchApp
//
//  Created by match on 14-12-10.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITtextFiledBackground.h"
#import "UIBaseViewController.h"

@interface ITUserCenterViewController : UIBaseViewController

@property (nonatomic,strong) UITextField *account;
@property (nonatomic,strong) UITextField *password;
@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) ITtextFiledBackground *background;

@property (nonatomic,strong) UIButton *findPasswordButton;
@property (nonatomic,strong) UIButton *registerButton;

@end
