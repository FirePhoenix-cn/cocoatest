//
//  ViewController.m
//  tableviewdatasource
//
//  Created by jinou on 16/9/14.
//  Copyright © 2016年 com.jinou.qcytestdemo. All rights reserved.
//

#import "ViewController.h"
#import "TableviewDatasource.h"

@interface TableviewController : UITableViewController

@property(strong, nonatomic) TableviewDatasource *tableviewdatasource;

@property(strong ,nonatomic) NSMutableArray *datasrc;

@property(copy, nonatomic) configCell configcell;

@property(copy, nonatomic) selectedCell selectedcell;

@end


@implementation TableviewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.configcell = ^(NSIndexPath *indexPath, UITableViewCell *cell)
    {
        cell.textLabel.text = @"asd";
    };
    self.selectedcell = ^(NSIndexPath *indexPath)
    {
        NSLog(@"ASD");
    };
    
    self.datasrc = [NSMutableArray arrayWithArray:@[@"12",@"12",@"12"]];
    self.tableviewdatasource = [TableviewDatasource datasourceAndDelegateWithData:self.datasrc cellConfig:self.configcell cellSelected:self.selectedcell];
    self.tableView.dataSource = self.tableviewdatasource;
    self.tableView.delegate = self.tableviewdatasource;
}

@end

/**
 *************************************************************
 */
@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TableviewController *tbvcontroller = [[TableviewController alloc] init];
    
    tbvcontroller.tableView = self.tableview;
    
    [self addChildViewController:tbvcontroller];
    [tbvcontroller didMoveToParentViewController:self];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
