//
//  VSAdvertisementCell.m
//  star
//
//  Created by fuyiming on 14/11/6.
//  Copyright (c) 2014年 spetal. All rights reserved.
//


#import "CycleScrollViewCell.h"
#import "UIImageView+WebCache.h"

@interface CycleScrollViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@end

@implementation CycleScrollViewCell

- (void) setAdInfo:(id )adInfo {
    _adInfo = adInfo ;
    
    [self.iconView setImage:[UIImage imageNamed:@"placeholder"]];
    //[self.iconView loadSimpleImageURLString:adInfo.adPicUrl] ;
}


@end
