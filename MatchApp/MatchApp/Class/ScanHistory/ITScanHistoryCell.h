//
//  ITScanHistoryCell.h
//  MatchApp
//
//  Created by fuyiming on 14/12/13.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITScanHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *infoImgView;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@end
