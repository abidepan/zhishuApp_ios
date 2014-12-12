//
//  ITLoadingView.h
//  MatchApp
//
//  Created by fuyiming on 14/12/10.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ITLoadingView : UIView

-(void)initLoadingContent;

@property(nonatomic,strong) MBProgressHUD * progressHUD;

@end
