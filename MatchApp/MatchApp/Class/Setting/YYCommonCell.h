//
//  YYCommonCell.h
//  MatchApp
//
//  Created by mt on 14-12-17.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class YYCommonItem;

@interface YYCommonCell : UITableViewCell

//数据
@property(nonatomic,strong)YYCommonItem *item;

@property(nonatomic,strong)UISwitch *rightSwitch;
@property(nonatomic,strong)UIImageView *rightArrow;
@property(nonatomic,strong)UILabel *rightLabel;

//类方法，提供cell的初始化
+(instancetype)cellWithTablView:(UITableView *)tableView;

-(void)setindexPath :(NSIndexPath *)indexPath rowsInSection:(int)row;

@end

