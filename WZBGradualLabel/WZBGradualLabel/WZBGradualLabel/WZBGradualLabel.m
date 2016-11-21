//
//  WZBGradualLabel.m
//  渐变动画label
//
//  Created by 鲁迅 on 16/5/9.
//  Copyright © 2016年 王振标. All rights reserved.
//

#import "WZBGradualLabel.h"

@interface WZBGradualLabel ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) CGFloat gradualWidth;

@end

@implementation WZBGradualLabel

+ (instancetype)gradualLabelWithFrame:(CGRect)frame title:(NSString *)title duration:(NSTimeInterval)duration gradualWidth:(CGFloat)gradualWidth superview:(UIView *)superview {
    return [[self alloc] initWithFrame:frame title:title duration:duration gradualWidth:gradualWidth superview:superview];
}

+ (instancetype)gradualLabelWithFrame:(CGRect)frame title:(NSString *)title superview:(UIView *)superview {
    return [self gradualLabelWithFrame:frame title:title duration:2 gradualWidth:frame.size.width superview:superview];
}
+ (instancetype)gradualLabelWithFrame:(CGRect)frame title:(NSString *)title duration:(NSTimeInterval)duration superview:(UIView *)superview {
    return [self gradualLabelWithFrame:frame title:title duration:duration gradualWidth:frame.size.width superview:superview];
}
+ (instancetype)gradualLabelWithFrame:(CGRect)frame title:(NSString *)title gradualWidth:(CGFloat)gradualWidth superview:(UIView *)superview {
    return [self gradualLabelWithFrame:frame title:title duration:2 gradualWidth:gradualWidth superview:superview];
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title duration:(NSTimeInterval)duration gradualWidth:(CGFloat)gradualWidth superview:(UIView *)superview {
    if (self = [super initWithFrame:frame]) {
        
        self.duration = duration;
        self.gradualWidth = gradualWidth;
        [superview addSubview:self];
        
        // 创建 label 并显示文字,将其添加到 view 上.
        self.label = [[UILabel alloc] init];
        self.label.frame = self.bounds;
        self.text = title;
        self.clipsToBounds = YES;
        self.label.text = title;
        
        // 创建渐变层
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.colors = @[(id)[UIColor blackColor].CGColor,(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor, (id)[UIColor blueColor].CGColor, (id)[UIColor blackColor].CGColor];
        self.gradientLayer.startPoint = CGPointMake(0, 0.5);
        self.gradientLayer.endPoint = CGPointMake(1, 0.5);
        
        self.leftView = [[UIView alloc] initWithFrame:self.bounds];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(changX) userInfo:nil repeats:YES];
        
        // kvo监听属性
        for (NSString *property in self.propertys) {
            [self addObserver:self forKeyPath:property options:NSKeyValueObservingOptionNew context:nil];
        }
    }
    return self;
}

- (void)setGradualColors:(NSArray *)gradualColors {
    _gradualColors = gradualColors;
    NSMutableArray *colors = [NSMutableArray array];
    for (UIColor *color in gradualColors) {
        [colors addObject:(id)color.CGColor];
    }
    self.gradientLayer.colors = colors;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"]) {
        self.label.text = self.text;
    } else if ([keyPath isEqualToString:@"font"]) {
        self.label.font = self.font;
    } else if ([keyPath isEqualToString:@"textAlignment"]) {
        self.label.textAlignment = self.textAlignment;
    } else if ([keyPath isEqualToString:@"attributedText"]) {
        self.label.attributedText = self.attributedText;
    } else if ([keyPath isEqualToString:@"frame"]) {
        self.label.frame = (CGRect){self.label.frame.origin, self.frame.size};
    } else if ([keyPath isEqualToString:@"numberOfLines"]) {
        self.label.numberOfLines = self.numberOfLines;
    }
}

// 改变上层view和label的x值
- (void)changX {
    __block CGRect frame1 = self.leftView.frame;
    __block CGRect frame2 = self.label.frame;
    frame1.origin.x = -self.gradualWidth;
    frame2.origin.x = self.gradualWidth;
    self.leftView.frame = frame1;
    self.label.frame = frame2;
    [UIView animateWithDuration:self.duration animations:^{
        frame1.origin.x = self.bounds.size.width;
        self.leftView.frame = frame1;
        frame2.origin.x = -self.bounds.size.width;
        self.label.frame = frame2;
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect frame = self.leftView.frame;
    frame.size.width = self.gradualWidth;
    frame.origin.x = -self.gradualWidth;
    self.leftView.frame = frame;
    [self addSubview:self.leftView];
    self.leftView.clipsToBounds = YES;
    CGRect frame1 = self.label.frame;
    frame1.origin.x = self.gradualWidth;
    self.label.frame = frame1;
    [self.leftView.layer addSublayer:self.gradientLayer];
    [self.leftView addSubview:self.label];
    self.gradientLayer.frame = self.leftView.bounds;
    self.leftView.clipsToBounds = YES;
    self.gradientLayer.mask = self.label.layer;
    [self changX];
}

// 销毁定时器和移除观察者
- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
    for (NSString *property in self.propertys) {
        [self removeObserver:self forKeyPath:property];
    }
}

// 要监听的属性
- (NSArray *)propertys {
    return @[@"text", @"font", @"textAlignment", @"attributedText", @"frame", @"numberOfLines"];
}

@end
