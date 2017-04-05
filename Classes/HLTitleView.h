//
//  HLTitleView.h
//  HLCollectionView
//
//  Created by heylau on 2017/4/5.
//  Copyright © 2017年 hey lau. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLPageStyle;
@class HLTitleView;
@protocol HLTitleViewDelegate <NSObject>

-(void)titleView:(HLTitleView *)titleView targetIndex:(NSInteger)targetIndex;

@end
@interface HLTitleView : UIView
-(id)initWithFrame:(CGRect)frame titles:(NSArray*)titles style:(HLPageStyle*)style;
@property(weak,nonatomic) id<HLTitleViewDelegate> delegate;
@end
