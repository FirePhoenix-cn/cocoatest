//
//  ViewController.m
//  operation
//
//  Created by jinou on 16/7/11.
//  Copyright © 2016年 qcy.jinou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(strong,nonatomic)NSOperationQueue *operation;//任务队列,其实是对线程的封装实现
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _operation = [[NSOperationQueue alloc] init];
    [_operation setMaxConcurrentOperationCount:5];//并发任务最大数量
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)btn1:(id)sender
{
    //创建一个任务
    NSInvocationOperation *iop = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(iop1) object:nil];
    [_operation addOperation:iop];
}
-(void)iop1
{
    
}
- (IBAction)btn2:(id)sender
{
    
}
@end
