//
//  ViewController.m
//  gcddemo
//
//  Created by jinou on 16/8/15.
//  Copyright © 2016年 com.jinou.phoenixlock. All rights reserved.
//

#import "ViewController.h"

const char *label = "mainqueue"; //队列名

@interface ViewController ()
{
    NSInteger data;
}
#if OS_OBJECT_USE_OBJC
@property(strong, nonatomic) dispatch_queue_t mainqueue;//创建一个队列
#else
@property(assign, nonatomic) dispatch_queue_t mainqueue;//创建一个队列
#endif

@end


/*
 *队列，线程，任务，进程
 *队列遵循先添加就先执行的法则
 *只有异步具有创建新线程的能力，只有并行有同时执行多任务的可能，一条线程同一时间只能执行一个任务
 *主线程建议用同步的方式
 *任务的添加可以嵌套
 *
 *异步+并行:会产生多个线程来执行异步执行（多个任务可以同时执行的唯一方式）
 *同步+并行:任务会在当前线程依次执行（不会创建线程，一半会堵塞当前线程（通常会是主线程））
 *异步+串行:如果跟主队列不会创建新线程任务会依次执行，如果跟自定义队列则会创建新线程任务会依次执行
 *同步+并行:没有新线程任务依次执行
 *
 */
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    dispatch_time_t timedelay = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);//表示3秒延时
    //_mainqueue = dispatch_queue_create(label, DISPATCH_QUEUE_CONCURRENT);//创建了一个并行队列
    _mainqueue = dispatch_queue_create(label, DISPATCH_QUEUE_SERIAL);//创建了一个串行队列
    dispatch_after(timedelay, _mainqueue, ^{//延时后加入队列，非精准延时执行
        NSLog(@"6");
    });
}

//dispatch_group_async可以实现监听一组任务是否完成，完成后得到通知执行其他的操作。这个方法很有用，比如你执行三个下载任务，当三个任务都下载完成后你才通知界面说完成的了。
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);//并行队列 开启多条线程（第一个参数指的是优先级，第二个参数暂时无意义）
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:6];
        NSLog(@"group1 [NSThread sleepForTimeInterval:6];");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"group2 [NSThread sleepForTimeInterval:3];");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"group3 [NSThread sleepForTimeInterval:1];");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{//dispatch_get_main_queue是串行队列
        NSLog(@"main thread.");
    });
    
    //线程同步，解决资源重复占用问题
    dispatch_async(queue, ^{
        
        data = 200;
    });
    @synchronized (self)
    {
        data = 100;
    }
    
    NSLog(@"%li",(long)data);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
