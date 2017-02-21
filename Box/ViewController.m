//
//  ViewController.m
//  Box
//
//  Created by Nicholas on 17/2/13.
//  Copyright © 2017年 Mr.zhang. All rights reserved.
//

#import "ViewController.h"
#import "MMComBoxView.h"
#define AllProNamelist  @[@"请选择",@"安徽省",@"北京",@"重庆",@"福建省",@"甘肃省",@"广东省",@"广西壮族自治区",@"贵州省",@"海南省",@"河北省",@"河南省",@"黑龙江省",@"湖北省",@"湖南省",@"吉林省",@"江苏省",@"江西省",@"辽宁省",@"内蒙古自治区",@"宁夏回族自治区",@"青海省",@"山东省",@"山西省",@"陕西省",@"上海",@"四川省",@"天津",@"西藏自治区",@"新疆维吾尔自治区",@"云南省",@"浙江省"]
@interface ViewController ()<MMComBoxViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    MMComBoxView *box = [[MMComBoxView alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    box.backgroundColor = [UIColor whiteColor];
    box.arrowImgName = @"down_dark";
    box.titlesList = [NSMutableArray arrayWithArray:AllProNamelist];
    box.delegate = self;
    box.supView = self.view;
    [box defaultSettings];
    [self.view addSubview:box];
    
    /**
     *如果地址是网络请求 
     将请求回来的数组赋值给box的titlesList;
     刷新box
     [box reloadData]
     *
     */
}
- (void)comBoxView:(MMComBoxView *)combox selectAtIndex:(NSInteger)index
{
    
}


@end
