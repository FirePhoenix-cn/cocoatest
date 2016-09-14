//
//  ViewController.m
//  FileDemo
//
//  Created by jinou on 16/9/9.
//  Copyright © 2016年 com.jinou.libBleLock. All rights reserved.
//

#import "ViewController.h"
#import "TestObj.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 获取Documents目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 获取tmp目录
    NSString *tmpPath = NSTemporaryDirectory();
    
    // 获取Library目录
    NSString *libPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    
    // 获取Library/Caches目录
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    // 获取Library/Preferences目录
    NSString *prePath = [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
    //通常情况下，Preferences由系统维护，我们很少去操作TA
    
    // 获取应用程序包的路径
    NSString *path = [NSBundle mainBundle].resourcePath;
    
    // 字符串写入沙盒
    // 在Documents下面创建一个文本路径，假设文本名称为objc.txt
    NSString *txtPath = [docPath stringByAppendingPathComponent:@"objc.txt"]; // 此时仅存在路径，文件并没有真实存在
    NSString *string = @"Objective-C";
    
    // 字符串写入时执行的方法
    [string writeToFile:txtPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"txtPath is %@", txtPath);
    
    // 字符串读取的方法
    NSString *resultStr = [NSString stringWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"resultStr is %@", resultStr);
    
    
    // 数组写入文件
    // 创建一个存储数组的文件路径
    NSString *filePath = [docPath stringByAppendingPathComponent:@"language.txt"];
    NSArray *array = @[@"C语言", @"JAVA",@"Objective-C", @"Swift", @"PHP", @"C++", @"C#"];
    // 数组写入文件执行的方法
    [array writeToFile:filePath atomically:YES];
    NSLog(@"filePath is %@", filePath);
    
    // 从文件中读取数据数组的方法
    NSArray *resultArr = [NSArray arrayWithContentsOfFile:filePath];
    
    // 字典写入文件
    // 创建一个存储字典的文件路径
    NSString *fileDicPath = [docPath stringByAppendingPathComponent:@"love.txt"];
    NSDictionary *dic = @{@"职业":@"程序员", @"梦想":@"代码无BUG"};
    
    // 字典写入时执行的方法
    [dic writeToFile:fileDicPath atomically:YES];
    NSLog(@"fileDicPath is %@", fileDicPath);
    
    // 从文件中读取数据字典的方法
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:fileDicPath];
    NSLog(@"%@", resultDic[@"梦想"]);
    
    
    // NSData写入文件
    // 创建一个存放NSData数据的路径
    NSString *fileDataPath = [docPath stringByAppendingPathComponent:@"meinv"];
    
    // 得到一个UIImage对象
    UIImage *image = [UIImage imageNamed:@"meinv.jpg"];
    
    // 将UIImage对象转换成NSData对象
    NSData *data = UIImageJPEGRepresentation(image, 0);
    [data writeToFile:fileDataPath atomically:YES];
    NSLog(@"fileDataPath is %@", fileDataPath);
    
    // 从文件读取存储的NSData数据
    NSData *resultData = [NSData dataWithContentsOfFile:fileDataPath];
    // 将得到的NSData数据转换成原有的图片对象
    UIImage *resultImage = [UIImage imageWithData:resultData];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = resultImage;
    [self.view addSubview:imageView];
    
    
    // 获取创建文件夹的路径
    NSString *dirPath = [cachePath stringByAppendingPathComponent:@"testDirectroy"];
    
    // 创建文件管理对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 创建文件夹
    [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSLog(@"%@", dirPath);
    
    
    // 创建一个文件路径
    NSString *filePath1 = [docPath stringByAppendingPathComponent:@"objc.txt"];
    
    // 创建文件
    [fileManager createFileAtPath:filePath1 contents:[@"Objective-C" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    
    // 获取某个文件或者某个文件夹的大小
    NSDictionary *dic1 = [fileManager attributesOfItemAtPath:filePath1 error:nil];
    NSNumber *number = [dic1 objectForKey:NSFileSize];
    NSInteger size = number.intValue;
    
    // 创建文件夹
    NSString *pathPath = [docPath stringByAppendingPathComponent:@"path"];
    
    // 创建文件
    NSString *path1 = [pathPath stringByAppendingPathComponent:@"test.txt"];
    
    NSString *dirPath1 = [cachePath stringByAppendingPathComponent:@"testDirectroy"];
    
    NSString *desPath = [dirPath1 stringByAppendingPathComponent:@"test.txt"];
    
    // 移动文件
    [fileManager moveItemAtPath:path1 toPath:desPath error:nil]; // 移动文件的核心代码
    
    
    /**
     *  练习要求：从一个文件中指定的位置开始追加内容
     提示:
     1、在documents目录下创建一个test.txt文件,文件中的内容为"abcdefg"
     2、从文件偏移量为3那个位置开始追加内容"1234"
     */
    
    // 创建文件路径
    NSString *filePath2 = [docPath stringByAppendingPathComponent:@"test.txt"];
    
    [fileManager createFileAtPath:filePath2 contents:[@"abcdefg" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    
    // 创建文件对接对象
    NSFileHandle *handle = [NSFileHandle fileHandleForUpdatingAtPath:filePath]; // 文件对接对象此时针对文件既可以读取又可以写入
    
    // 将偏移量挪到3的位置
    [handle seekToFileOffset:3];
    
    // 写入数据
    [handle writeData:[@"1234" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 执行完操作之后不要忘记关闭文件
    [handle closeFile];
    
    
    [self messfileoper];
}

-(void)messfileoper
{
    /*
     复杂对象指的是在Foundation框架内不存在的数据类，如自定以的Person类，像这种自定义的类是无法在程序内部通过writeToFile：这个方法写入到文件内
     既然复杂对象无法使用内部方法进行数据持久化，那么只能通过将复杂对象转换成NSData，然后在通过上面的方法写入文件，而这种转换的步骤就被称为归档，从文件中读取NSData数据，将NSData转换为复杂对象，这个步骤就是反归档
     
     复杂对象写入文件的过程（复杂对象->归档->NSData->writeToFile）
     从文件中读取出复杂对象过程（读取文件->NSData->反归档->复杂对象）
     
     首先，复杂对象所属的类要遵守<NSCoding>
     其次，实现协议中的两个方法：
     -(void)encodeWithCoder:(NSCoder *)aCoder; 序列化
     -(id)initWithCoder:(NSCoder *)aDecoder; 反序列化
     */
    TestObj *testobj = [[TestObj alloc] init];
    testobj.name = @"1234";
    testobj.age = 12;
    NSLog(@"testobj:%@",testobj.name);
    // 准备一个NSMutableData, 用于保存归档后的对象
    NSMutableData *data = [NSMutableData data];
    // 创建归档工具
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    // 归档
    [archiver encodeObject:testobj forKey:@"to1"];
    // 结束
    [archiver finishEncoding];
    // 拼音写入沙盒路径
    NSString *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [caches stringByAppendingPathComponent:@"testobj"];
    // 写入沙盒
    [data writeToFile:filePath atomically:YES];
    
    // 反归档
    // 从filePath文件路径读取
    NSData *data1 = [NSData dataWithContentsOfFile:filePath];
    // 反归档工具
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data1];
    // 反归档成对象
    TestObj *testobj1 = [unArchiver decodeObjectForKey:@"to1"];
    NSLog(@"testobj1:%@",testobj1.name);
    // 反归档结束
    [unArchiver finishDecoding];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
