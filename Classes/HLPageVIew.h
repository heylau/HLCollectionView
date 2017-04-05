//
//  HLPageVIew.h
//  HLCollectionView
//
//  Created by heylau on 2017/4/5.
//  Copyright © 2017年 hey lau. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HLPageStyle;
@interface HLPageVIew : UIView
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles style:(HLPageStyle*)style childVcs:(NSArray*)childVcs parentVc:(UIViewController *)parentVc;
@end
