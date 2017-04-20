//
//  RootTableViewController.m
//  SQliteDemo
//
//  Created by 张近坪 on 2016/9/22.
//  Copyright © 2016年 张近坪. All rights reserved.
//

#import "RootTableViewController.h"
#import "SQLiteManager.h"
#import "Person.h"
#import "PersonTableViewCell.h"

@interface RootTableViewController ()
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    SQLiteManager *sql = [SQLiteManager sharedSQLiteManager];
    
    if ([sql creatDB]) {
        self.dataSource = [[sql findAllPerson]mutableCopy];
        [self.tableView reloadData];
        NSLog(@"数据库创建成果");
    } else {
        NSLog(@"数据库创建失败");
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

#pragma mark - Table View Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[PersonTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    Person *person = _dataSource[indexPath.row];
    cell.nameLabel.text = person.name;
    cell.phoneLabel.text = person.phone;
    cell.headerImageView.image = person.headerImage;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Person *person = _dataSource[indexPath.row];
        SQLiteManager *sql = [SQLiteManager sharedSQLiteManager];
        if ([sql deletePersonWithName:person.name]) {
            [self.dataSource removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

@end
