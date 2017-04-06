//
//  HLPageCollectionView.m
//  HLCollectionView
//
//  Created by heylau on 2017/4/7.
//  Copyright © 2017年 hey lau. All rights reserved.
//

#import "HLPageCollectionView.h"
#import "HLPageCollectionViewLayout.h"
#import "HLPageStyle.h"
#import "HLTitleView.h"
@interface HLPageCollectionView() <HLTitleViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(strong,nonatomic) NSArray *titles;
@property(strong,nonatomic) HLPageStyle *style;
@property(strong,nonatomic) HLPageCollectionViewLayout *layout;
@property(strong,nonatomic) HLTitleView *titleView;
@property(strong,nonatomic) UICollectionView *collectionView;
@property(strong,nonatomic) UIPageControl *pageControl;
@property(assign,nonatomic) NSIndexPath *currentIndex;

@end
@implementation HLPageCollectionView

-(HLPageCollectionViewLayout *)layout
{
    if (!_layout) {
        _layout = [[HLPageCollectionViewLayout alloc]initWithStyle:self.style];
    }
    return _layout;
}
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles layout:(HLPageCollectionViewLayout *)layout style:(HLPageStyle *)style
{
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.layout = layout;
        self.style = style;
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    CGFloat titleY = _style.isTitleInTop ? 0 : self.hl_height - _style.titleHeight;
    CGRect titleFrame = CGRectMake(0, titleY, self.hl_width, _style.titleHeight);
    
    HLTitleView *titleView = [[HLTitleView alloc]initWithFrame:titleFrame titles:self.titles style:self.style];
    titleView.backgroundColor = HLRandomColor;
    titleView.delegate = self;
    self.titleView = titleView;
    [self addSubview:titleView];
    
    CGFloat collectionY = _style.isTitleInTop ? _style.titleHeight : 0;
    CGRect collectionFrame = CGRectMake(0, collectionY, self.hl_width, self.hl_height - _style.titleHeight - _style.pageControlHeight);
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:collectionFrame collectionViewLayout:self.layout];
    collectionView.backgroundColor = HLRandomColor;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView = collectionView;
    [self addSubview:collectionView];
    
    CGRect pageFrame = CGRectMake(0, CGRectGetMaxY(collectionView.frame), self.hl_width, _style.pageControlHeight);
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:pageFrame];
    pageControl.backgroundColor = [UIColor lightGrayColor];
    self.pageControl = pageControl;

    
    
    [self addSubview:pageControl];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return [self.dataSource numberOfSectionInPageCollectionView:self];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    self.pageControl.numberOfPages = ([self.dataSource pageCollectionView:self numberOfItemInSection:0] - 1) / (_style.layoutRows * _style.layoutCols) + 1;

     return [self.dataSource pageCollectionView:self numberOfItemInSection:section];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    

    return [self.dataSource pageCollectionView:self collectionView:collectionView cellAtIndexPath:indexPath];
}

-(void)registerCellClass:(Class)cellClass reusableIndentifier:(NSString *)reusableIndentifier
{
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:reusableIndentifier];
}
-(void)registerCellNib:(UINib *)cellNib reusableIndentifier:(NSString *)reusableIndentifier
{
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:reusableIndentifier];
}
-(void)reloadData
{
    [self.collectionView reloadData];
}

-(void)titleView:(HLTitleView *)titleView targetIndex:(NSInteger)targetIndex
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:targetIndex];
    NSInteger itemNum = [self.dataSource pageCollectionView:self numberOfItemInSection:targetIndex];
    self.pageControl.numberOfPages = (itemNum - 1) / (_style.layoutRows * _style.layoutCols) + 1;
    self.pageControl.currentPage = 0;
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    CGPoint temp = self.collectionView.contentOffset;
    temp.x -= self.layout.sectionInset.left;
    self.collectionView.contentOffset = temp;
    
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self scrollViewEndScroll];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewEndScroll];

}

-(void)scrollViewEndScroll{
    NSLog(@"%lf",self.layout.sectionInset.left);

    CGPoint point = CGPointMake(self.layout.sectionInset.left + 1 + self.collectionView.contentOffset.x, self.layout.sectionInset.top + 1);
    NSIndexPath *indexPath =  [self.collectionView indexPathForItemAtPoint:point];
    if (indexPath.section != self.currentIndex.section) {
        NSInteger itemCount = [self.dataSource pageCollectionView:self numberOfItemInSection:indexPath.section];
        self.pageControl.numberOfPages = (itemCount - 1) / (_style.layoutRows * _style.layoutCols) + 1;
        self.currentIndex = indexPath;
    }
    
    self.pageControl.currentPage = indexPath.item / (_style.layoutCols * _style.layoutRows);
    [self.titleView setCurrentWithIndex:indexPath.section];
}
@end
