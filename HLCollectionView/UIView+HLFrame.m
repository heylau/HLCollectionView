//
//  UIView+HLFrame.m
//  Got Job
//
//  Created by heylau on 17/2/8.
//  Copyright © 2017年 hey lau. All rights reserved.
//

#import "UIView+HLFrame.h"

@implementation UIView (HLFrame)


-(void)setHl_centerX:(CGFloat)hl_centerX
{
    CGPoint center = self.center;
    center.x = hl_centerX;
    self.center = center;
}

-(CGFloat)hl_centerX
{
    return self.center.x;
}


- (void)setHl_centetY:(CGFloat)hl_centetY
{
    CGPoint center = self.center;
    center.y = hl_centetY;
    self.center = center;
}

- (CGFloat)hl_centetY
{
    return self.center.y;
}


- (void)setHl_x:(CGFloat)hl_x
{
    CGRect frame = self.frame;
    frame.origin.x = hl_x;
    self.frame = frame;
}
- (CGFloat)hl_x
{
    return self.frame.origin.x;
}

- (void)setHl_y:(CGFloat)hl_y
{
    CGRect frame = self.frame;
    frame.origin.y = hl_y;
    self.frame = frame;
}
- (CGFloat)hl_y
{
    return self.frame.origin.y;
}

- (void)setHl_width:(CGFloat)hl_width
{
    CGRect frame = self.frame;
    frame.size.width = hl_width;
    self.frame = frame;
}
- (CGFloat)hl_width
{
    return self.frame.size.width;
}

- (void)setHl_height:(CGFloat)hl_height
{
    CGRect frame = self.frame;
    frame.size.height = hl_height;
    self.frame = frame;
}

- (CGFloat)hl_height
{
    return self.frame.size.height;
}
@end
