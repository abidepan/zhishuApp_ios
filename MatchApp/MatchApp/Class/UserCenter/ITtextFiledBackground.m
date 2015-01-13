//
//  ITtextFiledBackgroud.m
//  MatchApp
//
//  Created by mt on 15-1-12.
//  Copyright (c) 2015年 itrace. All rights reserved.
//

#import "ITtextFiledBackground.h"

@implementation ITtextFiledBackground

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect {
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,0.1);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 10, 50);
    CGContextAddLineToPoint(context,self.frame.size.width - 10, 50);
    CGContextClosePath(context);
    [[UIColor grayColor] setStroke];
    CGContextStrokePath(context);
    
}

@end
