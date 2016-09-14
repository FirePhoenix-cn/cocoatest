


/**
 不能import任何controller和view
 */
#import <Foundation/Foundation.h>

@interface ModelObj : NSObject

@property(nonatomic ,strong) NSString *account;

@property(nonatomic, strong) NSMutableArray *somedata;

-(void)updateData;

@end
