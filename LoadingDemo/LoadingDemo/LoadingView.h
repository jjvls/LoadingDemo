//
//  LoadingView.h
//  TestMultiAnimation
//
//  Created by jiejin on 16/4/11.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

/*!
 *  @author ajie, 16-04-12 09:04:03
 *
 *  初始化（单利）实例对象
 *
 *  @return LoadingView的对象
 */
+ (LoadingView *)shareObjectWithSuperView:(UIView *)superView;

/*!
 *  @author ajie, 16-04-12 09:04:10
 *
 *  开始动画
 */
- (void)start;

/*!
 *  @author ajie, 16-04-12 09:04:22
 *
 *  结束动画
 */
- (void)stop;


@end
