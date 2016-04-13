//
//  LoadingView.m
//  TestMultiAnimation
//
//  Created by jiejin on 16/4/11.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView()

@property (nonatomic, strong) NSMutableArray *locationArray;
@property (nonatomic, strong) NSMutableArray *animationViewsArray;

@end

@implementation LoadingView

+ (LoadingView *)shareObjectWithSuperView:(UIView *)superView{

   static LoadingView *loading = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        loading = [[LoadingView alloc] initWithFrame:superView.bounds];
       
        [loading addAnimationViews];
        
        [superView addSubview:loading];
    });
    
    return loading;
}

- (void)addAnimationViews{

    self.locationArray = [NSMutableArray array];
    self.animationViewsArray = [NSMutableArray array];
    
    NSArray *colorArray = @[[UIColor blueColor],[UIColor redColor],[UIColor purpleColor],[UIColor yellowColor],[UIColor blueColor],[UIColor blackColor],[UIColor grayColor],[UIColor orangeColor]];
    
    CGFloat centerX = self.center.x;
    CGFloat centerY = self.center.y;
    
    CGFloat delta = 2 * M_PI / 8;
    
    CGFloat x = centerX + 50 * cos(delta * 7);
    CGFloat y = centerY + 50 * sin(delta * 7);
    
    [self.locationArray addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
    
    for (int i =0; i<8; i++) {
        CGFloat x = centerX + 50 * cos(delta*i);
        CGFloat y = centerY + 50 * sin(delta*i);
        [self.locationArray addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        view.center = self.center;
        view.backgroundColor = colorArray[i];
        view.layer.cornerRadius = 5;
        view.layer.transform = CATransform3DMakeScale(0, 0, 0);
        view.layer.masksToBounds = YES;
        [self addSubview:view];
        
        [self.animationViewsArray addObject:view];
    }
}

- (CAAnimationGroup *)createGroupAnimationWithDelay:(CFTimeInterval)time withIndex:(NSInteger)index;
{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:self.center];
    moveAnimation.toValue = self.locationArray[index];
    moveAnimation.duration = 0.75;
    moveAnimation.autoreverses = YES;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @(0);
    scaleAnimation.toValue = @(1);
    scaleAnimation.duration = 0.75;
    scaleAnimation.autoreverses = YES;
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[moveAnimation,scaleAnimation];
    group.autoreverses = YES;
    group.duration = 0.75;
    group.repeatCount = HUGE_VALF;
    group.beginTime = CACurrentMediaTime() + time;
    
    return group;
}

- (void)start{

    self.hidden = NO;
    
    for (int i = 0;i<self.animationViewsArray.count; i++) {
        UIView *view = self.animationViewsArray[i];
        [view.layer addAnimation:[self createGroupAnimationWithDelay:i * 0.1 withIndex:i] forKey:@"group"];
    }

}

- (void)stop{

    self.hidden = YES;
    
    for (int i = 0;i<self.animationViewsArray.count; i++) {
        UIView *view = self.animationViewsArray[i];
        [view.layer removeAllAnimations];
    }
    
}

@end
