//
//  ViewController.m
//  chartdemo
//
//  Created by jinou on 16/9/13.
//  Copyright © 2016年 com.jinou.qcytestdemo. All rights reserved.
//

#import "ViewController.h"
#import "ZFChart.h"

@interface ViewController ()<ZFGenericChartDataSource,ZFBarChartDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self drawbarchart];
}

//📊
-(void)drawbarchart
{
    ZFBarChart *barchart = [[ZFBarChart alloc] initWithFrame:CGRectMake(0.0, 20.0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    barchart.dataSource = self;
    barchart.delegate = self;
    barchart.topicLabel.text = @"test title";
    barchart.unit = @"人";
    [barchart strokePath];
    [self.view addSubview:barchart];
}

/**
 @required 必须实现的方法
 
 //返回value数据
 //当只有1组数据时，NSArray存储 @[@"1", @"2", @"3", @"4"]
 当有多组数据时，NSArray存储 @[@[@"123", @"300", @"490", @"380", @"167", @"235"], @[@"256", @"283", @"236", @"240", @"183", @"200"], @[@"256", @"256", @"256", @"256", @"256", @"256"]]
 //barChart: 代表有6组，每组有3个item
 //lineChart: 代表有6组，每组有3个item（另一种理解就是有3条线，每条线上有6个点）
 */

-(NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart
{
    return @[@[@"1",@"8",@"3",@"3.5",@"2"],@[@"3",@"2",@"3",@"4",@"3"]];
}

/**
 @optional 可选实现的方法
 
 //返回名称数组(NSArray必须存储NSString类型)
 */

 - (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart
{
    return @[@"一年级", @"二年级", @"三年级", @"四年级", @"五年级"];
}


 /**
 @optional 可选实现的方法
 //返回颜色数组(NSArray必须存储UIColor类型, 若不设置，默认随机)
 //barChart: 若每组有3个item,则返回3个颜色
 //lineChart：若有3条线，则返回3个颜色
 
 - (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart{
 return @[ZFSkyBlue, ZFOrange, ZFMagenta];
 }
 
 
 //y轴(普通图表) 或 x轴(横向图表) 数值显示的最大值(若不设置，默认返回数据源最大值)
 
 - (CGFloat)axisLineMaxValueInGenericChart:(ZFGenericChart *)chart;
 
 //y轴(普通图表) 或 x轴(横向图表) 数值显示的最小值(若不设置，默认返回数据源最小值)
 //(PS:当 isResetAxisLineMinValue 为NO时，此方法无效)(When isResetAxisLineMinValue is NO, the method is invalid)
 
 - (CGFloat)axisLineMinValueInGenericChart:(ZFGenericChart *)chart;
 
 
 //y轴(普通图表) 或 x轴(横向图表) 数值显示的段数(若不设置,默认5段)
 
 - (NSInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart;
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
