//
//  ViewController.m
//  HLCollectionView
//
//  Created by heylau on 2017/4/5.
//  Copyright © 2017年 hey lau. All rights reserved.
//

#import "ViewController.h"
#import "HLPageVIew.h"
#import "HLTitleView.h"
#import "HLPageStyle.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *titles = @[@"哈哈",@"嘻哈",@"你好",@"我好",@"大家好",@"你好",@"我好",@"大家好",@"你好",@"我好",@"大家好"];
    
    NSMutableArray *childVcs = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        UIViewController *vc = [[UIViewController alloc]init];
        vc.view.backgroundColor = HLRandomColor;
        [childVcs addObject:vc];
    }
    HLPageStyle *style = [[HLPageStyle alloc]init];
    style.isScroll = YES;
    style.isShowBottomLine = YES;
    style.isScale = YES;
    style.isShowCover = YES;
    HLPageVIew *pageView = [[HLPageVIew alloc]initWithFrame:self.view.bounds titles:titles style:style childVcs:childVcs parentVc:self];
    pageView.hl_y = 20;
    [self.view addSubview:pageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
