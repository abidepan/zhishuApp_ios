//
//  ITInputCodeBaseViewController.h
//  MatchApp
//
//  Created by fuyiming on 14/12/28.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseViewController.h"

@interface ITInputCodeBaseViewController : UIBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *qrCodeTxtField;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;

@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
- (IBAction)onSearchBtnClicked:(id)sender;
- (IBAction)onClearBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bottomBg;
@end
