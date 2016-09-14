//
//  AppDelegate.h
//  coredata
//
//  Created by jinou on 16/7/11.
//  Copyright © 2016年 qcy.jinou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;

/*
//将多个数据模型管理文件进行合并
+ (nullable NSManagedObjectModel *)mergedModelFromBundles:(nullable NSArray<NSBundle *> *)bundles;
//将多个数据模型管理类对象进行合并
+ (nullable NSManagedObjectModel *)modelByMergingModels:(nullable NSArray<NSManagedObjectModel *> *)models;
//存放数据中所有实体模型的字典 字典中是实体名和实体描述对象
@property (readonly, copy) NSDictionary< NSString *, NSEntityDescription *> *entitiesByName;
//存放数据中所有实体描述对象
@property (strong) NSArray<NSEntityDescription *> *entities;
//返回所有可用的配置名称
@property (readonly, strong) NSArray<NSString *> *configurations;
//获取关联某个配置的所有实体
- (nullable NSArray<NSEntityDescription *> *)entitiesForConfiguration:(nullable NSString *)configuration;
//为某个实体关联配置
- (void)setEntities:(NSArray<NSEntityDescription *> *)entities forConfiguration:(NSString *)configuration;
//创建请求模板
- (void)setFetchRequestTemplate:(nullable NSFetchRequest *)fetchRequestTemplate forName:(NSString *)name;
//获取请求模板
- (nullable NSFetchRequest *)fetchRequestTemplateForName:(NSString *)name;
 */
@end

