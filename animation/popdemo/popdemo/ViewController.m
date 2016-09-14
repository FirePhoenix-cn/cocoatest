//
//  ViewController.m
//  popdemo
//
//  Created by jinou on 16/9/13.
//  Copyright © 2016年 com.jinou.qcytestdemo. All rights reserved.
//

#import "ViewController.h"
#import "pop/POP.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *label;
- (IBAction)click:(UIButton *)sender;
@property(strong, nonatomic) POPSpringAnimation *springanimation;

@property(strong, nonatomic) POPBasicAnimation *basicanimation;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _springanimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    _springanimation.toValue = [NSNumber numberWithFloat:100.0];
    _springanimation.springBounciness = 20.0f;
    _springanimation.beginTime = CACurrentMediaTime() + 1.0f;
    _springanimation.springSpeed = 10.0f;
    
    
    _basicanimation = [POPBasicAnimation animation];
    _basicanimation.duration = 60.0f;
    _basicanimation.property = [POPAnimatableProperty propertyWithName:@"count++" initializer:^(POPMutableAnimatableProperty *prop) {
        prop.readBlock = ^(id obj, CGFloat values[]){ values[0] = [[obj description] floatValue]; };
        prop.writeBlock = ^(id obj, const CGFloat values[])
        {
            [obj setText:[NSString stringWithFormat:@"%.2f",values[0]]];
        };
        prop.threshold = 1;
    }];
    _basicanimation.fromValue = @(0);
    _basicanimation.toValue = @(60);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)click:(UIButton *)sender
{
    //[_label.layer pop_addAnimation:_springanimation forKey:@"springanimation"];
    [_label pop_addAnimation:_basicanimation forKey:@"basicanimation"];
}
@end
