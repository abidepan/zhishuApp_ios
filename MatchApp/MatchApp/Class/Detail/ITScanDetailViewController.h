//
//  ITScanDetailViewController.h
//  MatchApp
//
//  Created by fuyiming on 14/12/21.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "UIBaseViewController.h"

@interface ITScanDetailViewController : UIBaseViewController

@property(nonatomic,strong) NSString * code;
@property(nonatomic,assign) CodeType codeType;
@property (nonatomic,strong) NSDictionary * dataInfo;

@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;
@end
