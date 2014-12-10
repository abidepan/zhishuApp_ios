//
//  ViewController.h
//  star
//
//  Created by fuyiming on 14/11/6.
//  Copyright (c) 2014年 spetal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *qickResponseCodeVW;

- (IBAction)onQuickResponseCodeBtnClicked:(id)sender;




- (IBAction)onMineBtnClicked:(id)sender;
- (IBAction)onScanBtnClicked:(id)sender;
- (IBAction)onSettingBtnClicked:(id)sender;

@end

