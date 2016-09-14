//
//  ViewController.m
//  thread
//
//  Created by jinou on 16/7/11.
//  Copyright © 2016年 qcy.jinou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(strong,nonatomic)NSThread *tread1;
@property(strong,nonatomic)NSThread *tread2;
@property(strong,nonatomic)NSLock *lock;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _lock = [[NSLock alloc] init];
    //当有多个线程同时操作一个对象时，要进行加锁，操作完进行解锁；
    [_lock lock];
    //操作数据
    [_lock unlock];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)test1
{
    while (true)
    {
        NSLog(@"111");
    }
}
-(void)test0:(NSThread*)thread
{
    while (true)
    {
        NSLog(@"222");
    }
}
-(void)test2
{
    while (true)
    {
        NSLog(@"222");
    }

}
- (IBAction)test:(id)sender
{
    _tread1 = [[NSThread alloc] initWithTarget:self selector:@selector(test1) object:nil];
    [_tread1 start];
       //或者：
//    [NSThread detachNewThreadSelector:@selector(test0:) toTarget:self withObject:nil];
   
}

- (IBAction)test1:(id)sender
{
    _tread2 = [[NSThread alloc] initWithTarget:self selector:@selector(test2) object:nil];
    [_tread2 start];
}
@end
