//
//  YYCommonGroup.h
//  MatchApp
//
//  Created by mt on 14-12-17.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYCommonGroup : NSObject

/**
 用一个模型来描述每组的信息：组头、组尾、这组的所有行模型
 */

@property(nonatomic,copy)NSString *groupheader;
@property(nonatomic,copy)NSString *grougfooter;

//这组的所有行模型
@property(nonatomic,strong)NSArray *items;

+(instancetype)group;

@end
