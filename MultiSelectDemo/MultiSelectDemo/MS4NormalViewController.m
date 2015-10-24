//
//  MS4NormalViewController.m
//  MultiSelectDemo
//
//  Created by zengqingfu on 15/10/24.
//  Copyright © 2015年 zengqingfu. All rights reserved.
//

#import "MS4NormalViewController.h"

@interface MS4NormalViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *myTableView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation MS4NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 80; i++) {
        NSString *str = [NSString stringWithFormat:@"第%ld个数据", i];
        [_dataArr addObject:str];
    }
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    NSLog(@"%@", NSStringFromCGRect(bounds));
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, bounds.size.width, bounds.size.height - 80) style:UITableViewStylePlain];
    
    self.myTableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_myTableView];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.allowsMultipleSelection = YES;

    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake(bounds.size.width - 80, 20, 60, 40);
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];
}

- (void)confirmButtonAction:(UIButton *)sender {
    NSArray *selectArr = [_myTableView indexPathsForSelectedRows];
    for (NSIndexPath *indexPath in selectArr) {
        NSLog(@"选中了%ld行", indexPath.row);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ids = @"CELL_ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ids];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ids];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    
    NSArray *selectRows =  [_myTableView indexPathsForSelectedRows];
    if ([selectRows containsObject:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.isEditing == YES) {
        
    } else {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.isEditing == YES) {
        
    } else {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
}

//-----------------全选代码--------
- (void)tableView:(UITableView *)tableView allCellSelected:(BOOL)selected{
    NSInteger sections = tableView.numberOfSections;
    for (NSInteger section = 0; section < sections; section++) {
        NSInteger rows =  [tableView numberOfRowsInSection:section];
        for (NSInteger row = 0; row < rows; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            if (selected) {
                [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            } else {
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
