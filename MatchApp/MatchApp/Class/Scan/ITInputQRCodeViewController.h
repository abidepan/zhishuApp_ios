//
//  ITInputQRCodeViewController.h
//  MatchApp
//
//  Created by fuyiming on 14/12/25.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITInputQRCodeViewController : UIViewController
- (IBAction)onSearchBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *qrCodeTxtField;

@end
