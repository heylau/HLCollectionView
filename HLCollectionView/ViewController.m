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
#import "HLPageCollectionView.h"
#import "HLPageCollectionViewLayout.h"
#import "UIView+HLFrame.h"

@interface ViewController ()<HLPageCollectionViewDataSource>

@end
static NSString * const cellID = @"cellID";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self pageViewDemo];
    
    
    
    
    //MARK: - 自定义表情框
    [self pageCollectionViewDemo];
}

-(void)pageViewDemo
{
    self.automaticallyAdjustsScrollViewInsets = NO;

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
    CGRect pageViewFram =  CGRectMake(0, 0, self.view.hl_width, self.view.hl_height - 300);
    HLPageVIew *pageView = [[HLPageVIew alloc]initWithFrame:pageViewFram titles:titles style:style childVcs:childVcs parentVc:self];
    pageView.hl_y = 20;
    [self.view addSubview:pageView];
}

-(void)pageCollectionViewDemo
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *titles = @[@"哈哈",@"嘻哈",@"你好",@"我好"];
    CGRect pageFrame = CGRectMake(0, self.view.hl_height - 300, self.view.hl_width, 300);
    HLPageStyle *style = [[HLPageStyle alloc]init];
    style.isShowBottomLine = true;
    HLPageCollectionViewLayout *layout = [[HLPageCollectionViewLayout alloc]initWithStyle:style];
    layout.sectionInset = UIEdgeInsetsMake(10, 10,10 , 10);
    layout.itemMargin = 10;
    layout.lineMargin = 30;
    
    HLPageCollectionView *pageView = [[HLPageCollectionView alloc]initWithFrame:pageFrame titles:titles layout:layout style:style];
    
    pageView.dataSource = self;
    [pageView registerCellClass:[UICollectionViewCell class] reusableIndentifier:cellID];
    [self.view addSubview:pageView];
}
-(int)numberOfSectionInPageCollectionView:(HLPageCollectionView *)pageCollectionView
{
    return 4;
}

-(int)pageCollectionView:(HLPageCollectionView *)pageCollectionView numberOfItemInSection:(NSInteger)section
{
    return 30;
    
}

-(UICollectionViewCell *)pageCollectionView:(HLPageCollectionView *)pageCollectionView collectionView:(UICollectionView *)collectionView cellAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = HLRandomColor;
    
    return cell;
    
}

@end
