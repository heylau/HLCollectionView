

//
//  HLPageCollectionViewLayout.m
//  HLCollectionView
//
//  Created by heylau on 2017/4/7.
//  Copyright © 2017年 hey lau. All rights reserved.
//

#import "HLPageCollectionViewLayout.h"
#import "HLPageStyle.h"
@interface HLPageCollectionViewLayout ()
@property(strong,nonatomic) HLPageStyle *style;
@property(strong,nonatomic) NSMutableArray *attributes;
@property(assign,nonatomic) CGFloat totalWidth;

@end
@implementation HLPageCollectionViewLayout
-(NSMutableArray *)attributes
{
    if (!_attributes) {
        _attributes = [NSMutableArray array];
    }
    return _attributes;
}
-(instancetype)initWithStyle:(HLPageStyle *)style
{
    if (self = [super init]) {
        self.style = style;
    }
    return  self;
}

-(void)prepareLayout
{
    NSLog(@"%@",NSStringFromUIEdgeInsets(self.sectionInset));

    NSInteger sections = self.collectionView.numberOfSections;
    CGFloat itemW = (self.collectionView.hl_width - self.sectionInset.left - self.sectionInset.right - (_style.layoutCols - 1) * self.itemMargin) / _style.layoutCols;
    CGFloat itemH = (self.collectionView.hl_height - self.sectionInset.top - self.sectionInset.bottom - self.lineMargin * (_style.layoutRows - 1)) / _style.layoutRows;
    NSInteger preViousNumberOfPage = 0;
    
    for (int section = 0; section<sections; section++) {
        NSInteger items = [self.collectionView numberOfItemsInSection:section];
        for (int item = 0; item<items; item++) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attributr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            NSInteger currentPage = item / (_style.layoutCols * _style.layoutRows);
            NSInteger currentIndex = item % (_style.layoutCols * _style.layoutRows);
            
            CGFloat x = (preViousNumberOfPage + currentPage) * self.collectionView.hl_width + self.sectionInset.left + (itemW + self.itemMargin) * (currentIndex % _style.layoutCols);
            CGFloat y = self.sectionInset.top + (itemH + self.lineMargin) * (currentIndex / _style.layoutCols);
            
            attributr.frame = CGRectMake(x, y, itemW, itemH);
            [self.attributes addObject:attributr];
        }
        
        preViousNumberOfPage += (items - 1) / (_style.layoutCols * _style.layoutRows) + 1;
    }
    
    self.totalWidth = preViousNumberOfPage * self.collectionView.hl_width;
    
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributes;
}

-(CGSize)collectionViewContentSize
{
    return CGSizeMake(self.totalWidth, 0);
}
@end
