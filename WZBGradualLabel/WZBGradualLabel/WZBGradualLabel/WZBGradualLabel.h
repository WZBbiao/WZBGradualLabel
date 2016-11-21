//
//  WZBGradualLabel.h
//  渐变动画label
//
//  Created by 鲁迅 on 16/5/9.
//  Copyright © 2016年 王振标. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZBGradualLabel : UILabel

/* 渐变颜色色值，有默认值 **/
@property (nonatomic, strong) NSArray *gradualColors;
/*
 * frame:label的frame
 * title:text
 * duration:时间间隔
 * gradualWidth:渐变颜色的宽
 * superView:label的父控件
 **/
+ (instancetype)gradualLabelWithFrame:(CGRect)frame title:(NSString *)title duration:(NSTimeInterval)duration gradualWidth:(CGFloat)gradualWidth superview:(UIView *)superview;
/*
 * frame:label的frame
 * title:text
 * superView:label的父控件
 **/
+ (instancetype)gradualLabelWithFrame:(CGRect)frame title:(NSString *)title superview:(UIView *)superview;
/*
 * frame:label的frame
 * title:text
 * duration:时间间隔
 * superView:label的父控件
 **/
+ (instancetype)gradualLabelWithFrame:(CGRect)frame title:(NSString *)title duration:(NSTimeInterval)duration superview:(UIView *)superview;
/*
 * frame:label的frame
 * title:text
 * gradualWidth:渐变颜色的宽
 * superView:label的父控件
 **/
+ (instancetype)gradualLabelWithFrame:(CGRect)frame title:(NSString *)title gradualWidth:(CGFloat)gradualWidth superview:(UIView *)superview;
@end
