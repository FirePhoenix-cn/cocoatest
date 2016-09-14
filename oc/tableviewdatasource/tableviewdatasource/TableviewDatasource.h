//
//  TableviewDatasource.h
//  tableviewdatasource
//
//  Created by jinou on 16/9/14.
//  Copyright © 2016年 com.jinou.qcytestdemo. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^configCell)(NSIndexPath *indexPath, UITableViewCell *cell);

typedef void(^selectedCell)(NSIndexPath *indexPath);

@interface TableviewDatasource : NSObject<UITableViewDelegate,UITableViewDataSource>

+(instancetype)datasourceAndDelegateWithData:(NSMutableArray *)datalist cellConfig:(configCell)configcell cellSelected:(selectedCell)selectedcell;

@end
