//
//  HLTitleView.m
//  HLCollectionView
//
//  Created by heylau on 2017/4/5.
//  Copyright © 2017年 hey lau. All rights reserved.
//

#import "HLTitleView.h"
#import "HLPageStyle.h"
#import "HLContainView.h"


@interface HLTitleView ()<HLContainViewDelegate>

@property(strong,nonatomic) NSArray *titles;
@property(strong,nonatomic) HLPageStyle *style;
@property(strong,nonatomic) UIView *bottomLine;
@property(strong,nonatomic) UIView *coverView;
@property(strong,nonatomic) UIScrollView *scrollView;
@property(strong,nonatomic) NSMutableArray *titleLabels;
@property(assign,nonatomic) NSInteger currentIndex;
@property(assign,nonatomic) NSInteger tagetIndex;
@property(assign,nonatomic) const CGFloat * selectColorRGB;
@property(assign,nonatomic) const CGFloat * normalColorRGB;
@property(strong,nonatomic) NSMutableArray *detalRGB;
@end

@implementation HLTitleView
-(const CGFloat *)selectColorRGB
{
    
    if (!_selectColorRGB) {
        CGColorRef selectColor = _style.selectColor.CGColor;
         _selectColorRGB = CGColorGetComponents(selectColor);
    }
    return _selectColorRGB;
}

-(const CGFloat *)normalColorRGB
{
    if (!_normalColorRGB) {
        CGColorRef normalColorRGB = _style.normalColor.CGColor;
            _normalColorRGB = CGColorGetComponents(normalColorRGB);
        
    }
    return _normalColorRGB;
}
-(NSMutableArray *)detalRGB
{
    if (!_detalRGB) {
        _detalRGB = [NSMutableArray array];
        CGFloat detalR = self.selectColorRGB[0] * 255.0 - self.normalColorRGB[0]* 255.0;
        CGFloat detalG = self.selectColorRGB[1] * 255.0 - self.normalColorRGB[1]* 255.0;
        CGFloat detalB = self.selectColorRGB[2] * 255.0 - self.normalColorRGB[2]* 255.0;
        [_detalRGB addObjectsFromArray:@[@(detalR),@(detalG),@(detalB)]];
    }
    return _detalRGB;
}
-(NSInteger)currentIndex
{
    if (!_currentIndex) {
        _currentIndex = 0;
    }
    return _currentIndex;
}
-(NSInteger)tagetIndex
{
    if (!_tagetIndex) {
        _tagetIndex = 0;
    }
    return _tagetIndex;
}
-(NSMutableArray *)titleLabels
{
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}
-(UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = self.style.bottomLineColor;
        
    }
    
    return _bottomLine;
}
-(UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc]init];
        _coverView.backgroundColor = self.style.coverViewColor;
        _coverView.alpha = self.style.coverViewAlpha;
    }
    return _coverView;
}
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
-(id)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(HLPageStyle *)style
{
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.style = style;
        [self setupUI];
        
    }
    return self;
}


-(void)setupUI
{

    self.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.scrollView];
    [self setLabels];
    if (_style.isShowBottomLine) {
        [self setupBottomLine];
    }
    if (_style.isShowCover) {
        [self setupCoverView];
    }
}

-(void)setupBottomLine
{
    [self.scrollView addSubview:self.bottomLine];
    UILabel *label = self.titleLabels.firstObject;
    self.bottomLine.frame = label.frame;
    self.bottomLine.hl_height = _style.bottomLineHeight;
    self.bottomLine.hl_y = _style.titleHeight - _style.bottomLineHeight;
    
}
-(void)setupCoverView
{
    [self.scrollView insertSubview:self.coverView atIndex:0 ];
    UILabel *firstLabel = _titleLabels.firstObject;
    CGFloat coverW = firstLabel.hl_width;
    CGFloat coverH = _style.coverViewHeight;
    CGFloat coverX = firstLabel.hl_x;
    CGFloat coverY = (self.scrollView.hl_height - _style.coverViewHeight) * 0.5;
    if (_style.isScroll) {
        coverX -= _style.converViewMargin;
        coverW += _style.converViewMargin * 2;
        
    }else{
        coverW -= _style.coverViewLrEdge * 2;
        coverX += _style.coverViewLrEdge;
    }
    
    self.coverView.frame = CGRectMake(coverX, coverY, coverW, coverH);
    self.coverView.layer.cornerRadius = _style.coverViewRadius;
    self.coverView.layer.masksToBounds = YES;
}
-(void)setLabels
{
    for (int i = 0; i<self.titles.count; i++) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = self.titles[i];
        titleLabel.tag = i;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = i == 0 ? _style.selectColor : _style.normalColor;
        titleLabel.font = _style.titleFont;
        [self.scrollView addSubview:titleLabel];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleTap:)];
        [titleLabel addGestureRecognizer:tap];
        [self.titleLabels addObject:titleLabel];
        [titleLabel setUserInteractionEnabled:YES];
    }
        CGFloat labelW = self.hl_width / self.titleLabels.count;
        CGFloat labelH = _style.titleHeight;
        CGFloat labelX = 0;
        CGFloat labelY = 0;
    
        for (int i = 0; i<_titleLabels.count; i++) {
            UILabel *label = self.titleLabels[i];

            if (_style.isScroll) {
                if (i != 0) {
                    UILabel *beforeLabel = self.titleLabels[i - 1];
                    labelX = CGRectGetMaxX(beforeLabel.frame) + _style.titleMargin;
                }else{
                    labelX = _style.titleMargin * 0.5;
                }
                labelW = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:_style.titleFont,NSFontAttributeName, nil] context:nil].size.width;
            
               
            }else{
                labelX = labelW * i;
            }
            label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        }
        
    if (_style.isScroll) {
        UILabel *lastLabel = _titleLabels.lastObject;
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame) + _style.titleMargin * 0.5, _style.titleHeight);
    }
    
    if (_style.isScale) {
        UILabel *label = _titleLabels.firstObject;
        label.transform = CGAffineTransformMakeScale(_style.maxScale, _style.maxScale);
    }
        
    
}

-(void)titleTap:(UITapGestureRecognizer*)tap{
    UILabel *targetLabel = tap.view;
    if (targetLabel.tag != _currentIndex) {
       
        if ([self.delegate respondsToSelector:@selector(titleView:targetIndex:)]) {
            [self.delegate titleView:self targetIndex:targetLabel.tag];
        }
        [self dealLabel:targetLabel];
    }
    
    
}

-(void)adjustLabelPosition
{
    if (_style.isScroll) {
        UILabel *targetLabel = self.titleLabels[_currentIndex];
        CGFloat offset = targetLabel.hl_centerX - _scrollView.hl_width * 0.5;
        if (offset < 0) {
            offset = 0;
        }
        
        CGFloat maxOffsetX = _scrollView.contentSize.width - _scrollView.hl_width;
        if (offset > maxOffsetX) {
            offset = maxOffsetX;
        }
        
        [self.scrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    }
}

-(void)dealLabel:(UILabel *)targetLabel
{
    UILabel *currentLabel = self.titleLabels[_currentIndex];
    currentLabel.textColor = _style.normalColor;
    targetLabel.textColor = _style.selectColor;
    self.currentIndex = targetLabel.tag;
    [self adjustLabelPosition];
    
    if (_style.isShowBottomLine) {
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomLine.hl_x = targetLabel.hl_x;
            self.bottomLine.hl_width = targetLabel.hl_width;
        }];
    }
    
    if (_style.isScale) {
        [UIView animateWithDuration:0.25 animations:^{
            currentLabel.transform = CGAffineTransformIdentity;
            targetLabel.transform = CGAffineTransformMakeScale(_style.maxScale, _style.maxScale);
        }];
        
        if (_style.isShowCover) {
            [UIView animateWithDuration:0.25 animations:^{
                self.coverView.hl_x = self.style.isScroll ? targetLabel.hl_x - self.style.converViewMargin : targetLabel.hl_x + self.style.coverViewLrEdge;
                
                self.coverView.hl_width = self.style.isScroll ? (targetLabel.hl_width + self.style.converViewMargin * 2) : targetLabel.hl_width - self.style.coverViewLrEdge * 2;
            }];
        }
    }
}

-(void)containViewDidEndScroll:(HLContainView *)containView DidScrollIndex:(NSInteger)index
{
    self.currentIndex = index;
    
    [self adjustLabelPosition];
}

-(void)containView:(HLContainView *)containView sourceIndex:(NSInteger)sourceIndex tagetIndex:(NSInteger)targetIndex progress:(CGFloat)progress
{
    if (progress == 1) {
        self.tagetIndex = targetIndex;
    }
    NSLog(@"%lf",progress);

    UILabel *sourceLabel = _titleLabels[sourceIndex];
    UILabel *targetLable = _titleLabels[targetIndex];

    sourceLabel.textColor = HLColor(self.selectColorRGB[0]* 255.0 - [self.detalRGB[0]doubleValue] * progress, self.selectColorRGB[1]* 255.0 - [self.detalRGB[1]doubleValue] * progress, self.selectColorRGB[2]* 255.0 - [self.detalRGB[2]doubleValue] * progress);
    targetLable.textColor = HLColor(self.normalColorRGB[0] * 255.0 + [self.detalRGB[0]doubleValue] * progress, self.normalColorRGB[1] * 255.0 + [self.detalRGB[1]doubleValue] * progress, self.normalColorRGB[2] * 255.0 + [self.detalRGB[2]doubleValue] * progress);
    
    CGFloat detalWidth = targetLable.hl_width - sourceLabel.hl_width;
    CGFloat detalX  = targetLable.hl_x - sourceLabel.hl_x;
    if (_style.isShowBottomLine) {
        self.bottomLine.hl_width = detalWidth * progress + sourceLabel.hl_width;
        self.bottomLine.hl_x = detalX * progress + sourceLabel.hl_x;
    }
    if (_style.isScale) {
        CGFloat detalScale = _style.maxScale - 1;
        sourceLabel.transform = CGAffineTransformMakeScale(_style.maxScale - detalScale * progress, _style.maxScale - detalScale * progress);
        targetLable.transform = CGAffineTransformMakeScale(1 + detalScale * progress, 1 + detalScale * progress);
    }
    
    if (_style.isShowBottomLine) {
        self.coverView.hl_x = _style.isScroll ? (sourceLabel.hl_x - _style.converViewMargin + detalX * progress) : (sourceLabel.hl_x + _style.coverViewLrEdge + detalX * progress);
        self.coverView.hl_width = _style.isScroll ? (sourceLabel.hl_width + _style.converViewMargin * 2 + detalWidth * progress) : (sourceLabel.hl_width - _style.coverViewLrEdge * 2 + detalWidth * progress);
    }
}

-(void)setCurrentWithIndex:(NSInteger)index
{
   
        UILabel *targetLabel = self.titleLabels[index];
        [self dealLabel:targetLabel];
    
}

@end
