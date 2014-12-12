//
//  ITLoadingView.m
//  MatchApp
//
//  Created by fuyiming on 14/12/10.
//  Copyright (c) 2014年 itrace. All rights reserved.
//

#import "ITLoadingView.h"
#import "MBProgressHUD.h"

@implementation ITLoadingView


-(id)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        
    }
    return self;
}

-(void)initLoadingContent{

    _progressHUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
}

@end
