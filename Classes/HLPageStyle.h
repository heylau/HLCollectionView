//
//  HLPageStyle.h
//  HLCollectionView
//
//  Created by heylau on 2017/4/5.
//  Copyright © 2017年 hey lau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HLPageStyle : NSObject


//标题高度
@property(assign,nonatomic) CGFloat titleHeight;

//标题默认颜色
@property(strong,nonatomic) UIColor *normalColor;

//标题选中颜色
@property(strong,nonatomic) UIColor *selectColor;

//标题文字大小
@property(strong,nonatomic) UIFont *titleFont;

//标题滑动可用
@property(assign,nonatomic) BOOL isScroll;

//标题文字间距
@property(assign,nonatomic) CGFloat titleMargin;

//标题底部线条
@property(assign,nonatomic) BOOL isShowBottomLine;

//标题底部线条颜色
@property(strong,nonatomic) UIColor *bottomLineColor;

//标题底部线条高度
@property(assign,nonatomic) CGFloat bottomLineHeight;

//标题文字缩放
@property(assign,nonatomic) BOOL isScale;

//标题文字最大缩放
@property(assign,nonatomic) CGFloat maxScale;

//标题遮盖颜色
@property(strong,nonatomic) UIColor *coverViewColor;

//标题遮盖透明度
@property(assign,nonatomic) CGFloat coverViewAlpha;

//标题遮盖
@property(assign,nonatomic) BOOL isShowCover;

//标题遮盖高度
@property(assign,nonatomic) CGFloat coverViewHeight;

//标题遮盖圆角
@property(assign,nonatomic) CGFloat coverViewRadius;

//标题遮盖间距(滑动模式下)
@property(assign,nonatomic) CGFloat converViewMargin;

//标题遮盖左右边距(不可滑动模式下)
@property(assign,nonatomic) CGFloat coverViewLrEdge;

//pageView高度
@property(assign,nonatomic) CGFloat pageControlHeight;

//title显示位置
@property(assign,nonatomic) BOOL isTitleInTop;

//自定义表情框的列数
@property(assign,nonatomic) NSInteger layoutCols;

//自定义表情框的行数
@property(assign,nonatomic) NSInteger layoutRows;




@end
