//
//  MS4EditingViewController.m
//  MultiSelectDemo
//
//  Created by zengqingfu on 15/10/24.
//  Copyright © 2015年 zengqingfu. All rights reserved.
//

#import "MS4EditingViewController.h"

@interface MS4EditingViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *myTableView;//tableView
@property (nonatomic, strong)NSMutableArray *dataArr;//数据源

@end

@implementation MS4EditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"------------演示在编辑状态下多选---------------");
    //初始化数据源
    self.dataArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 80; i++) {
        NSString *str = [NSString stringWithFormat:@"第%ld个数据", i];
        [_dataArr addObject:str];
    }
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    
    //是时候tableView
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, bounds.size.width, bounds.size.height - 80) style:UITableViewStylePlain];
    [self.view addSubview:_myTableView];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    //允许编辑的时候多选
    self.myTableView.allowsMultipleSelectionDuringEditing = YES;
    
    //右上角的编辑/完成按钮
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(bounds.size.width - 80, 20, 60, 40);
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [editButton setTitle:@"完成" forState:UIControlStateSelected];
    [editButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editButton];
}

//开始或者结束编辑
- (void)editButtonAction:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        NSArray *selectArr = [_myTableView indexPathsForSelectedRows];//一定要在setEditing:NO之前调用，否则无数据
        for (NSIndexPath *indexPath in selectArr) {
            NSLog(@"选中了%ld行", indexPath.row);
        }
        [self.myTableView setEditing:NO animated:YES];
    } else {
        sender.selected = YES;
        [self.myTableView setEditing:YES animated:YES];
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
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}


//选中行的时候
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.isEditing == YES) {
        
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

//反选行的时候
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.isEditing == YES) {
        
    } else {
        
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
