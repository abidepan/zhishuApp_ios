//
//  YYCommonCell.m
//  MatchApp
//
//  Created by mt on 14-12-17.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "YYCommonCell.h"
#import "YYCommonArrowItem.h"
#import "YYCommonSwitchItem.h"


@implementation YYCommonCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

#pragma mark-懒加载
-(UIImageView *)rightArrow{
    if (_rightArrow == nil) {
        _rightArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"grayarrowright"]];
    }
    return _rightArrow;
}

- (UISwitch *)rightSwitch{
    if (_rightSwitch == nil) {
        _rightSwitch = [[UISwitch alloc]init];
    }
    return _rightSwitch;
}

- (UILabel *)rightLabel{
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc]init];
    }
    return _rightLabel;
}


// 初始化类方法
+ (instancetype)cellWithTablView:(UITableView *)tableView {
    
    static NSString *ID = @"ID";
    YYCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YYCommonCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//  //设置标题和子标题的文字
//  self.textLabel.font=[UIFont boldSystemFontOfSize:15];
//  self.detailTextLabel.font=[UIFont systemFontOfSize:12];
//  // 清除cell的颜色
//  self.backgroundColor=[UIColor clearColor];
        
    }
    return self;
}

- (void)setItem:(YYCommonItem *)item {
    
    _item = item;
    // 设置基本数据
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;

    if ([item isKindOfClass:[YYCommonArrowItem class]])
    {   //如果是箭头
        self.accessoryView = self.rightArrow;
    }
    else if ([item isKindOfClass:[YYCommonSwitchItem class]])
    {
        //如果是开关
        self.accessoryView = self.rightSwitch;
    }
    else
    {
        //  取消右边的内容
        self.accessoryView = nil;
    }
}

- (void)setindexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows {
    
    // 设置每个section背景
    
//    //强制转换，imageview没必要创建多次
//    UIImageView *bgv=(UIImageView *)self.backgroundView;
//    UIImageView *sgv=(UIImageView *)self.selectedBackgroundView;
//    
//    if (rows==1) {//一组中只有一个cell
//        bgv.image=[UIImage imageNamed:@"common_card_background"];
//        sgv.image=[UIImage imageNamed:@"common_card_background_highlighted"];
//    }else if(indexPath.row==0) //首个cell
//    {
//        bgv.image=[UIImage imageNamed:@"common_card_top_background"];
//        sgv.image=[UIImage imageNamed:@"common_card_top_background_highlighted"];
//    }else if(indexPath.row==rows-1)//最后一个cell
//    {
//        bgv.image=[UIImage imageNamed:@"common_card_bottom_background"];
//        sgv.image=[UIImage imageNamed:@"common_card_bottom_background_highlighted"];
//    }else//中间的cell
//    {
//        bgv.image=[UIImage imageNamed:@"common_card_middle_background"];
//        sgv.image=[UIImage imageNamed:@"common_card_middle_background_highlighted"];
//    }
    
}

@end
