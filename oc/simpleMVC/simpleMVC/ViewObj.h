

/**
 不能import任何controller和model
 */

#import <UIKit/UIKit.h>

@protocol ViewObjDelegate <NSObject>

@optional

@end

@interface ViewObj : UIView

@property (assign, nonatomic) id<ViewObjDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *account;

@property (strong, nonatomic) IBOutlet UILabel *showdata;

+(instancetype)loadFromNib;

@end
