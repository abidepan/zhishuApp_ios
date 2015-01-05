//
//  ITScanRectView.m
//  MatchApp
//
//  Created by fuyiming on 15/1/5.
//  Copyright (c) 2015年 itrace. All rights reserved.
//

#import "ITScanRectView.h"

@implementation ITScanRectView
{

    double _lineLong;
    double _lineWidth;
    UIColor * _lineColor;
}

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        _lineLong = 20;
        _lineWidth = 4;
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);//线条颜色
    
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _lineWidth);
    
    CGContextMoveToPoint(context, _lineWidth/2,_lineLong);
    CGContextAddLineToPoint(context, _lineWidth/2,_lineWidth/2);
    CGContextAddLineToPoint(context, _lineLong,_lineWidth/2);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, self.frame.size.width - _lineLong,_lineWidth/2);
    CGContextAddLineToPoint(context, self.frame.size.width - _lineWidth/2,_lineWidth/2);
    CGContextAddLineToPoint(context, self.frame.size.width - _lineWidth/2,_lineLong);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, self.frame.size.width - _lineWidth/2, self.frame.size.height -_lineLong);
    CGContextAddLineToPoint(context, self.frame.size.width - _lineWidth/2, self.frame.size.height- _lineWidth/2);
    CGContextAddLineToPoint(context, self.frame.size.width - _lineLong,self.frame.size.height- _lineWidth/2);
    CGContextStrokePath(context);
    
    
    CGContextMoveToPoint(context, _lineLong, self.frame.size.height- _lineWidth/2);
    CGContextAddLineToPoint(context, _lineWidth/2, self.frame.size.height- _lineWidth/2);
    CGContextAddLineToPoint(context, _lineWidth/2,self.frame.size.height- _lineLong);
    CGContextStrokePath(context);
    
}

@end
