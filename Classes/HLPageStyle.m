//
//  HLPageStyle.m
//  HLCollectionView
//
//  Created by heylau on 2017/4/5.
//  Copyright © 2017年 hey lau. All rights reserved.
//

#import "HLPageStyle.h"
#import "UIView+HLFrame.h"
#define HLColor(r,g,b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]
#define HLRandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]

@implementation HLPageStyle
-(instancetype)init
{
    self.titleHeight = 44;
    self.normalColor = HLColor(255, 255, 255);
    self.selectColor = HLColor(255, 160, 0);
    self.titleFont = [UIFont systemFontOfSize:14];
    self.isScroll = NO;
    self.titleMargin = 20;
    self.isShowBottomLine = YES;
    self.bottomLineHeight = 2;
    self.bottomLineColor = HLColor(255, 160, 0);
    self.isScale =  NO;
    self.maxScale = 1.2;
    self.coverViewColor = [UIColor blackColor];
    self.coverViewAlpha = 0.3;
    self.isShowCover = NO;
    self.coverViewHeight = 25;
    self.coverViewRadius = 12.5;
    self.converViewMargin = 8;
    self.coverViewLrEdge = 10;
    self.isTitleInTop = YES;
    self.pageControlHeight = 20;
    self.layoutCols = 4;
    self.layoutRows = 2;
    return self;
}
@end
