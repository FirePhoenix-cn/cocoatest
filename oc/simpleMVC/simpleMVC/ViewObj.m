//
//  ViewObj.m
//  simpleMVC
//
//  Created by jinou on 16/9/14.
//  Copyright © 2016年 com.jinou.qcytestdemo. All rights reserved.
//

#import "ViewObj.h"

@implementation ViewObj

-(void)awakeFromNib
{
    [super awakeFromNib];
}

+(instancetype)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ViewObj" owner:nil options:nil] lastObject];
}

@end
