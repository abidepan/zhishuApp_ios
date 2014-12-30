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
@property (weak, nonatomic) IBOutlet UIView *newsVM;
@property (weak, nonatomic) IBOutlet UIView *nfcVM;
@property (weak, nonatomic) IBOutlet UIView *mallVM;
@property (weak, nonatomic) IBOutlet UIView *historyVM;
@property (weak, nonatomic) IBOutlet UIView *makeCodeVM;



- (IBAction)onQuickResponseCodeBtnClicked:(id)sender;
- (IBAction)onScanHistoryBtnClicked:(id)sender;





- (IBAction)onMineBtnClicked:(id)sender;
- (IBAction)onScanBtnClicked:(id)sender;
- (IBAction)onSettingBtnClicked:(id)sender;
- (IBAction)onNFCBtnClicked:(id)sender;

@end

