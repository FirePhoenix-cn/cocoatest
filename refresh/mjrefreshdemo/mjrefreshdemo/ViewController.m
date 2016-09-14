//
//  ViewController.m
//  mjrefreshdemo
//
//  Created by jinou on 16/9/13.
//  Copyright © 2016年 com.jinou.qcytestdemo. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh/MJRefresh.h"

static NSString *cellid = @"tabviewcell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tabview;
@end



@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tabview setDelegate:self];
    [self.tabview setDataSource:self];
    self.tabview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshdata)];
    self.tabview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getmoredata)];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tabview.mj_header beginRefreshing];
}

-(void)refreshdata
{
    [self performSelector:@selector(didrecievedata) withObject:nil afterDelay:3.0f];
}

-(void)getmoredata
{
    [self performSelector:@selector(ongetmoredata) withObject:nil afterDelay:3.0f];
}

-(void)didrecievedata
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tabview.mj_header endRefreshing];
    });
}

-(void)ongetmoredata
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tabview.mj_footer endRefreshing];
    });

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.textLabel.text = @"test data !!!";
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
