//
//  HLContainView.h
//  HLCollectionView
//
//  Created by heylau on 2017/4/5.
//  Copyright © 2017年 hey lau. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLContainView;
@protocol HLContainViewDelegate <NSObject>
-(void)containViewDidEndScroll:(HLContainView*)containView DidScrollIndex:(NSInteger)index;
-(void)containView:(HLContainView *)containView sourceIndex:(NSInteger)sourceIndex tagetIndex:(NSInteger)targetIndex progress:(CGFloat)progress;
@end

@interface HLContainView : UIView
-(instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray*)childVcs parentVc:(UIViewController*)parentVc;
@property(weak,nonatomic) id<HLContainViewDelegate> delegate;
@end
