//
//  ViewController.h
//  sqlite
//
//  Created by jinou on 16/4/22.
//  Copyright © 2016年 jinou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
@interface ViewController : UIViewController
{FMDatabase *_db;}
- (IBAction)btn1:(UIButton *)sender;

- (IBAction)btn2:(id)sender;
- (IBAction)btn3:(id)sender;
- (IBAction)btn4:(UIButton *)sender;

@end

