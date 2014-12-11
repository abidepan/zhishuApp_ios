//
//  ITErrorView.h
//  MatchApp
//
//  Created by fuyiming on 14/12/10.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITErrorView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *errorImgView;
@property (weak, nonatomic) IBOutlet UILabel *errorTitleLbl;
@property (weak, nonatomic) IBOutlet UIButton *errorBtn;

@end
