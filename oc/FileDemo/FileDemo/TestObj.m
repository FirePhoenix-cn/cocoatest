//
//  TestObj.m
//  FileDemo
//
//  Created by jinou on 16/9/9.
//  Copyright © 2016年 com.jinou.libBleLock. All rights reserved.
//

#import "TestObj.h"

@implementation TestObj

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    return self;
}

@end
