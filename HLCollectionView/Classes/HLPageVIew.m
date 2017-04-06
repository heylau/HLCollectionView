//
//  HLPageVIew.m
//  HLCollectionView
//
//  Created by heylau on 2017/4/5.
//  Copyright © 2017年 hey lau. All rights reserved.
//

#import "HLPageVIew.h"
#import "HLPageStyle.h"
#import "HLTitleView.h"
#import "HLContainView.h"



@interface HLPageVIew()
@property(strong,nonatomic) NSArray* titles;
@property(strong,nonatomic) NSArray* childVcs;
@property(strong,nonatomic)  HLPageStyle *style;
@property(strong,nonatomic) UIViewController *parentVc;

@end
@implementation HLPageVIew
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(HLPageStyle *)style childVcs:(NSArray *)childVcs parentVc:(UIViewController *)parentVc
{
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.style = style ;
        self.childVcs = childVcs;
        self.parentVc = parentVc;
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    CGRect titleFrame = CGRectMake(0, 0, self.hl_width, _style.titleHeight);
    HLTitleView *titleView = [[HLTitleView alloc]initWithFrame:titleFrame titles:_titles style:_style];
    [self addSubview:titleView];
    
    CGRect containFrame = CGRectMake(0, CGRectGetMaxY(titleFrame), self.hl_width, self.hl_height - _style.titleHeight);
    HLContainView *containView = [[HLContainView alloc]initWithFrame:containFrame childVcs:self.childVcs parentVc:self.parentVc];
    
    [self addSubview:containView];
    
    containView.delegate = titleView;
    titleView.delegate = containView;
    
}
@end
