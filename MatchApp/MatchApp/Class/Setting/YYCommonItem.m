//
//  YYCommonItem.m
//  MatchApp
//
//  Created by mt on 14-12-17.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "YYCommonItem.h"

@implementation YYCommonItem

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    YYCommonItem *item = [[self alloc]init];
    item.title = title;
    item.icon = icon;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title icon:nil];
}

@end
