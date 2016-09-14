//
//  ViewController.m
//  network
//
//  Created by jinou on 16/4/26.
//  Copyright © 2016年 jinou. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
@interface ViewController ()

@property(strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _sessionManager = [AFHTTPSessionManager manager];
    // 超时时间
    _sessionManager.requestSerializer.timeoutInterval = 5;
    
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    
    _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
    
}


-(void)AFGetData{

    //参数介绍
    //网络地址
    //传送的参数
    //进度条
    //成功后
    //失败后
    
    // 将请求参数放在请求的字典里
    NSDictionary *param = @{@"phoneNumber":@"13612345678", @"password":@"f379eaf3c831b04de153469d1bec345e"};
    
    [_sessionManager POST:@"http://pm.yunhan-china.com/index.php/api_common/login"
       parameters:param
         progress:^(NSProgress * _Nonnull uploadProgress) {
             // 这里可以获取到目前数据请求的进度
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             // 请求成功
             if(responseObject)
             {
                 NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                 NSLog(@"%@",dict);
             } else
             {
                 NSLog(@"没有数据");
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
             // 请求失败  
        NSLog(@"请求失败");
    }];
    

    [_sessionManager GET:@"http://pm.yunhan-china.com/index.php/Api_sale/sales_get" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        if(responseObject){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dict);
        } else {
            NSLog(@"没有数据");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"请求失败");
    }];
}

- (void)downLoadWithUrlString:(NSString *)urlString
{
    // 1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2.设置请求的URL地址
    NSURL *url = [NSURL URLWithString:urlString];
    // 3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 4.下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // 下载进度
        NSLog(@"当前下载进度为:%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 下载地址
        NSLog(@"默认下载地址%@",targetPath);
        // 设置下载路径,通过沙盒获取缓存地址,最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL fileURLWithPath:filePath]; // 返回的是文件存放在本地沙盒的地址
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // 下载完成调用的方法
        NSLog(@"%@---%@", response, filePath);
    }];
    // 5.启动下载任务
    [task resume];
}

- (void)uploadWithUser:(NSString *)userId UrlString:(NSString *)urlString upImg:(UIImage *)upImg
{
    // 创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 参数
    NSDictionary *param = @{@"user_id":userId};
    [manager POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /******** 1.上传已经获取到的img *******/
        // 把图片转换成data
        NSData *data = UIImagePNGRepresentation(upImg);
        // 拼接数据到请求题中
        [formData appendPartWithFileData:data name:@"file" fileName:@"123.png" mimeType:@"image/png"];
        /******** 2.通过路径上传沙盒或系统相册里的图片 *****/
        //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 打印上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
}


- (void)AFMonitor{
    //网络链接方式监测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"网络连接未知！");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"网络未连接！");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"网络连接wifi！");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"网络连接移动网络！");
                break;
                
            default:
                break;
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
