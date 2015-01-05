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

@property (weak, nonatomic) IBOutlet UILabel *resultValidateLabelView;
@property (weak, nonatomic) IBOutlet UILabel *resultValidateNumLabelView;
@property (weak, nonatomic) IBOutlet UILabel *resultValidatePromptLabelView;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *imagePromptLabelView;



@property (weak, nonatomic) IBOutlet UILabel *productNameLabelView;
@property (weak, nonatomic) IBOutlet UILabel *brandNameLabelView;
@property (weak, nonatomic) IBOutlet UILabel *produceTimeLabelView;
@property (weak, nonatomic) IBOutlet UILabel *batchNameLabelView;

@property (weak, nonatomic) IBOutlet UILabel *factoryNameLabelView;
@property (weak, nonatomic) IBOutlet UILabel *factoryAddrLabelView;
@property (weak, nonatomic) IBOutlet UILabel *factoryContactLabelView;

@property (weak, nonatomic) IBOutlet UIView *detailView;




@end
