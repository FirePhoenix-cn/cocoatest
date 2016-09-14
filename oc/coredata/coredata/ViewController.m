//
//  ViewController.m
//  coredata
//
//  Created by jinou on 16/7/11.
//  Copyright © 2016年 qcy.jinou. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Classes.h"
#import "Student.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)insert
{
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    //1. 获得context
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    //2. 找到实体结构,并生成一个实体对象
    /*
     NSEntityDescription实体描述，也就是表的结构
     参数1：表名字
     参数2:实例化的对象由谁来管理，就是context
     */
    Student *stu = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:context];
    
    Classes *class1 = [NSEntityDescription insertNewObjectForEntityForName:@"Classes" inManagedObjectContext:context];
    
    
    
    //3. 设置实体属性值
    [stu setValue:[NSNumber numberWithInt:1] forKey:@"s_id"];
    [stu setValue:@"jerehedu" forKey:@"s_name"];
    [stu setValue:class1 forKey:@"s_class"];
    
    //[class1 setValue:[NSNumber numberWithInt:1] forKey:@"c_id"];
    //[class1 setValue:@"一班" forKey:@"c_name"];
    
    [class1 addC_studentObject:stu];
    
    //4. 调用context,保存实体,如果没有成功，返回错误信息
    NSError *error;
    if ([context save:&error]) {
        NSLog(@"save ok");
    }
    else
    {
        NSLog(@"%@",error);
    }
}

- (void)selectAll {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSEntityDescription *classes = [NSEntityDescription entityForName:@"Classes" inManagedObjectContext:context];
    
    //构造查询对象
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:classes];
    
    //执行查询，返回结果集
    NSArray *resultAry = [context executeFetchRequest:request error:nil];
    
    //遍历结果集
    for (NSManagedObject *entity in resultAry) {
        NSLog(@"id=%i name=%@ student=%@",[[entity valueForKey:@"c_id"] intValue],[entity valueForKey:@"c_name"],[[entity valueForKey:@"c_student"] valueForKey:@"s_name"]);
    }
}


- (void)update
{
    //    更新 (从数据库找到-->更新)
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSEntityDescription *stu = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context];
    
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:stu];
    
    //构造查询条件，相当于where子句
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"s_id=%i",1];
    
    //把查询条件放进去
    [request setPredicate:predicate];
    
    //执行查询
    NSArray *studentAry = [context executeFetchRequest:request error:nil];
    if (studentAry.count>0)
    {
        //更新里面的值
        NSManagedObject *obj = studentAry[0];
        [obj setValue:@"apple" forKey:@"s_name"];
    }
    [context save:nil];
    
    //显示
    [self selectAll];
}


- (void)delete
{
    //删除 先找到，然后删除
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSEntityDescription *stu = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context];
    
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:stu];
    
    //构造查询条件，相当于where子句
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"s_id=%i",1];
    
    //把查询条件放进去
    [request setPredicate:predicate];
    //执行查询
    NSManagedObject *obj = [[context executeFetchRequest:request error:nil] lastObject];
    //删除
    if (obj)
    {
        [context deleteObject:obj];
        [context save:nil];
    }
    
    [self selectAll];
}

- (IBAction)insert:(id)sender
{
    [self insert];
}

- (IBAction)selectall:(id)sender
{
    [self selectAll];
}

- (IBAction)update:(id)sender
{
    [self update];
}

- (IBAction)delete:(id)sender
{
    [self delete];
}
@end
