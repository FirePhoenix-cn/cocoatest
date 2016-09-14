

#import "ModelObj.h"

@implementation ModelObj

-(instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.account = @"";
    self.somedata = @[].mutableCopy;
    return self;
}

-(void)updateData
{
    self.account = [[NSDate alloc] init].description;
}

@end
