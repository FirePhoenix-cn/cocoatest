//
//  TableviewDatasource.m
//  tableviewdatasource
//
//  Created by jinou on 16/9/14.
//  Copyright © 2016年 com.jinou.qcytestdemo. All rights reserved.
//

#import "TableviewDatasource.h"

static NSString *cellid = @"cell";


@interface TableviewDatasource()

@property(strong, nonatomic) NSMutableArray *datasource;
@property(copy, nonatomic) configCell configCell;
@property(copy, nonatomic) selectedCell selectedCell;
@end


@implementation TableviewDatasource


-(instancetype)initDatasourceAndDelegateWithData:(NSMutableArray *)datalist cellConfig:(configCell)configcell cellSelected:(selectedCell)selectedcell
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self.datasource = datalist;
    self.configCell = configcell;
    self.selectedCell = selectedcell;
    return self;
}

+(instancetype)datasourceAndDelegateWithData:(NSMutableArray *)datalist cellConfig:(configCell)configcell cellSelected:(selectedCell)selectedcell
{
    TableviewDatasource *datasource = [[self alloc] initDatasourceAndDelegateWithData:datalist cellConfig:configcell cellSelected:selectedcell];
    return datasource;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.datasource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    self.configCell(indexPath, cell);
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedCell(indexPath);
}

@end
