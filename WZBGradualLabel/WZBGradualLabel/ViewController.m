//
//  ViewController.m
//  WZBGradualLabel
//
//  Created by 王振标 on 2016/11/20.
//  Copyright © 2016年 王振标. All rights reserved.
//

#import "ViewController.h"
#import "WZBGradualLabel.h"

#define WZBScreenHeight [UIScreen mainScreen].bounds.size.height
#define WZBScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 支持label居左、居中和居右显示
    for (NSInteger i = 0; i < 3; i++) {
        WZBGradualLabel *label = [WZBGradualLabel gradualLabelWithFrame:(CGRect){10, 50 * i + 50, WZBScreenWidth - 20, 40} title:@"1234567890" superview:self.view];
        label.font = [UIFont systemFontOfSize:15 + i * 3];
        label.textAlignment = i;
        label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    
    // 支持多行显示
    WZBGradualLabel *moreLineLabel = [WZBGradualLabel gradualLabelWithFrame:(CGRect){0, 0, 100, 70} title:@"123456789012345678901234567890" duration:2 gradualWidth:100 superview:self.view];
    moreLineLabel.numberOfLines = 3;
    moreLineLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    moreLineLabel.center = self.view.center;
    
    // 支持自定义渐变颜色值
    WZBGradualLabel *diffierentColorLabel = [WZBGradualLabel gradualLabelWithFrame:(CGRect){10, 450, WZBScreenWidth - 20, 40} title:@"123456789012345678901234567890" duration:2  superview:self.view];
    diffierentColorLabel.gradualColors = @[[UIColor redColor], [UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor], [UIColor cyanColor], [UIColor blueColor], [UIColor purpleColor]];
    diffierentColorLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
}


@end
