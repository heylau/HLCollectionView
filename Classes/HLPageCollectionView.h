//
//  HLPageCollectionView.h
//  HLCollectionView
//
//  Created by heylau on 2017/4/7.
//  Copyright © 2017年 hey lau. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLPageCollectionView;
@protocol HLPageCollectionViewDataSource <NSObject>
-(int)numberOfSectionInPageCollectionView:(HLPageCollectionView*)pageCollectionView;


-(int)pageCollectionView:(HLPageCollectionView*)pageCollectionView numberOfItemInSection:(NSInteger)section;


-(UICollectionViewCell*)pageCollectionView:(HLPageCollectionView*)pageCollectionView collectionView:(UICollectionView*)collectionView cellAtIndexPath:(NSIndexPath*)indexPath;
@end

@class HLPageCollectionViewLayout,HLPageStyle;


@interface HLPageCollectionView : UIView


-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles layout:(HLPageCollectionViewLayout*)layout style:(HLPageStyle *)style;


@property(weak,nonatomic) id<HLPageCollectionViewDataSource> dataSource;


-(void)registerCellClass:(Class)cellClass reusableIndentifier:(NSString*)reusableIndentifier;
-(void)registerCellNib:(UINib*)cellNib reusableIndentifier:(NSString*)reusableIndentifier;
-(void)reloadData;

@end
