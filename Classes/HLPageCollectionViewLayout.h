//
//  HLPageCollectionViewLayout.h
//  HLCollectionView
//
//  Created by heylau on 2017/4/7.
//  Copyright © 2017年 hey lau. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLPageStyle;
@interface HLPageCollectionViewLayout : UICollectionViewLayout
-(instancetype)initWithStyle:(HLPageStyle*)style;
@property(assign,nonatomic) UIEdgeInsets sectionInset;
@property(assign,nonatomic) CGFloat itemMargin;
@property(assign,nonatomic) CGFloat lineMargin;


@end
