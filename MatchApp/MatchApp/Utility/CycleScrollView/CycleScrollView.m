//
//  VSAdvertisementView.m
//  star
//
//  Created by fuyiming on 14/11/6.
//  Copyright (c) 2014年 spetal. All rights reserved.
//


// 每一组最大的行数
#define VSMAdTotalRowsInSection (10000 * self.adList.count)
#define VSMAdDefaultRow (NSUInteger)(VSMAdTotalRowsInSection * 0.5)

#import "CycleScrollView.h"
#import "CycleScrollViewCell.h"
#import "CyclePageControl.h"
#import "Constants.h"

@interface CycleScrollView()  <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) CyclePageControl *pageControl;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation CycleScrollView

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        UICollectionView *collectionView =
        [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        collectionView.delegate = self ;
        collectionView.dataSource = self ;
        collectionView.pagingEnabled = YES ;
        collectionView.showsHorizontalScrollIndicator = NO ;
        collectionView.showsVerticalScrollIndicator = NO ;
        [collectionView registerNib:[UINib nibWithNibName:@"CycleScrollViewCell" bundle:nil] forCellWithReuseIdentifier:@"CycleCell"];
        collectionView.backgroundColor = [UIColor clearColor] ;
        [self addSubview:collectionView];
        self.collectionView = collectionView ;
        
        CyclePageControl *pageControl = [[CyclePageControl alloc] init];
        pageControl.center = CGPointMake(self.center.x, self.bounds.size.height - 10) ;
        [pageControl setCurrentPage: 0] ;
        pageControl.userInteractionEnabled = NO ;
        [pageControl setDefersCurrentPageDisplay: NO] ;
        [pageControl setType: DDPageControlTypeOnFullOffFull] ;
        [pageControl setOnColor: kAppleBlueColor] ;
        [pageControl setOffColor: [UIColor whiteColor]] ;
        [pageControl setIndicatorDiameter: 10.0f] ;
        [pageControl setIndicatorSpace: 5.0f] ;
        [self addSubview:pageControl];
        self.pageControl = pageControl ;
        
        [self addTimer];
    }
    
    return self ;
}

- (void) removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextAdvertisement) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)nextAdvertisement {
    if (self.adList.count > 0) {
        NSIndexPath *visiablePath = [[self.collectionView indexPathsForVisibleItems] firstObject];
        
        NSUInteger visiableItem = visiablePath.item;
        if ((visiablePath.item % self.adList.count)  == 0) { // 第0张图片
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:VSMAdDefaultRow inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            visiableItem = VSMAdDefaultRow;
        }
           
        NSUInteger nextItem = visiableItem + 1;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

- (void)setAdList:(NSArray *)adList {
    _adList = adList;
    
    if (adList.count > 0) {
        // 总页数
        self.pageControl.numberOfPages = self.adList.count;
        // 刷新数据
        [self.collectionView reloadData];
        // 默认组
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:VSMAdDefaultRow inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return VSMAdTotalRowsInSection;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"CycleCell";
    CycleScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.adInfo = self.adList[indexPath.item % self.adList.count];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *visiablePath = [[collectionView indexPathsForVisibleItems] firstObject];
    self.pageControl.currentPage = visiablePath.item % self.adList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectionView.frame.size ;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    ////TODO
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self addTimer];
}

@end
