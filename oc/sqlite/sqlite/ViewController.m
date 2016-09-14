//
//  ViewController.m
//  sqlite
//
//  Created by jinou on 16/4/22.
//  Copyright © 2016年 jinou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSHomeDirectory()获取手机APP的沙盒路径
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/db01.db"];
    NSLog(@"%@",path);
    //创建并且打开数据库
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//创建
- (IBAction)btn1:(UIButton *)sender {
    
    
    NSString *createTable = @"create table if not exists stu(id integer primary key,age integer,name varchar(20));";
    [_db executeUpdate:createTable];
    
}

//插入
- (IBAction)btn2:(id)sender {
    
    [_db executeUpdate:@"insert into stu values(2,10,'mike');"];
    
}

//删除
- (IBAction)btn3:(id)sender {
    [_db executeUpdate:@"delete from stu where id = 1;"];
}
//查询
- (IBAction)btn4:(UIButton *)sender {
    
    FMResultSet* rsul =  [_db executeQuery:@"select * from stu;"];
    //遍历返回值
    while ([rsul next]) {
        NSInteger ID = [rsul intForColumn:@"id"];
        
        NSString *name = [rsul stringForColumn:@"name"];
        
        NSInteger age = [rsul intForColumn:@"age"];
        NSLog(@"%ld,%ld,%@",ID,age,name);
    }
}
@end
