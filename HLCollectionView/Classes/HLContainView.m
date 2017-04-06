//
//  HLContainView.m
//  HLCollectionView
//
//  Created by heylau on 2017/4/5.
//  Copyright © 2017年 hey lau. All rights reserved.
//

#import "HLContainView.h"
#import "HLTitleView.h"


@interface HLContainView () <UICollectionViewDelegate,UICollectionViewDataSource,HLTitleViewDelegate>
@property(strong,nonatomic) NSArray* childVcs;
@property(strong,nonatomic) UIViewController *parentVc;
@property(strong,nonatomic) UICollectionView *collectionView;
@property(assign,nonatomic) BOOL isForbidDelegate;
@property(assign,nonatomic) CGFloat beginOffset;

@end
@implementation HLContainView
static NSString * const cellID = @"collectionViewID";
-(BOOL)isForbidDelegate
{
    if (!_isForbidDelegate) {
        _isForbidDelegate = false;
    }
    return _isForbidDelegate;
}
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource  =self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = false;
    
    }
    return _collectionView;
}
-(instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray *)childVcs parentVc:(UIViewController*)parentVc
{
    if (self = [super initWithFrame:frame]) {
        self.childVcs = childVcs;
        self.parentVc = parentVc;
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    for (UIViewController *vc in self.childVcs) {
        [self.parentVc addChildViewController:vc];
    }
    
    [self addSubview:self.collectionView];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%zd",self.childVcs.count);

    return self.childVcs.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    UIViewController *vc = self.childVcs[indexPath.row];
    [cell.contentView addSubview:vc.view];
    
    return cell;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScroll];

}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self scrollViewDidEndScroll];
}
-(void)scrollViewDidEndScroll
{
    NSInteger index = self.collectionView.contentOffset.x / self.collectionView.hl_width;
    if ([self.delegate respondsToSelector:@selector(containViewDidEndScroll:DidScrollIndex:)]) {
        [self.delegate containViewDidEndScroll:self DidScrollIndex:index];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isForbidDelegate = false;
    self.beginOffset = scrollView.contentOffset.x;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat containOffset = scrollView.contentOffset.x;
    if (containOffset != _beginOffset && !_isForbidDelegate) {
        NSInteger sourceIndex = 0;
        NSInteger targetIndex = 0;
        CGFloat progress = 0;
        if (containOffset > _beginOffset) {//左滑
            sourceIndex = containOffset / self.collectionView.hl_width;
            targetIndex = sourceIndex + 1;
            if (targetIndex >= _childVcs.count) {
                targetIndex = _childVcs.count - 1;
            }
            
            progress = (containOffset - _beginOffset) / self.collectionView.hl_width;
            if (containOffset - _beginOffset == self.collectionView.hl_width)
            {
                targetIndex = sourceIndex;
             }
             }
        else{//右滑
            targetIndex = containOffset / self.collectionView.hl_width;
            sourceIndex = targetIndex + 1;
            progress = (_beginOffset - containOffset) / self.collectionView.hl_width;
        }
        
        if ([self.delegate respondsToSelector:@selector(containView:sourceIndex:tagetIndex:progress:)]) {
            [self.delegate containView:self sourceIndex:sourceIndex tagetIndex:targetIndex progress:progress];
        }
    }
}




-(void)titleView:(HLTitleView *)titleView targetIndex:(NSInteger)targetIndex
{
    self.isForbidDelegate = YES;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:targetIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

@end
