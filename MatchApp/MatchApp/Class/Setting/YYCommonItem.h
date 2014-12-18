//
//  YYCommonItem.h
//  MatchApp
//
//  Created by mt on 14-12-17.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYCommonItem : NSObject

@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subtitle;

//点击这行cell,需要跳转到哪个控制器
@property(nonatomic,assign)Class destVcClass;

/**封装点击这行cell想做的事情*/
/**注意：block一定要使用copy*/
@property(nonatomic,copy) void (^operation)();

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+(instancetype)itemWithTitle:(NSString *)title;

@end
