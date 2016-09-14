//
//  TestObj.h
//  FileDemo
//
//  Created by jinou on 16/9/9.
//  Copyright © 2016年 com.jinou.libBleLock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestObj : NSObject<NSCoding>

@property(strong,nonatomic) NSString *name;
@property(assign,nonatomic) NSInteger age;

@end
