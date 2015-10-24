//
//  MainViewController.m
//  MultiSelectDemo
//
//  Created by zengqingfu on 15/10/24.
//  Copyright © 2015年 zengqingfu. All rights reserved.
//

#import "MainViewController.h"
#import "MS4NormalViewController.h"
#import "MS4EditingViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, 70, 150, 44);
    [button1 addTarget:self action:@selector(showEditingVC:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:@"编辑状态下多选" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.backgroundColor= [UIColor redColor];
    [self.view addSubview:button1];
    
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(20, 150, 150, 44);
    [button2 addTarget:self action:@selector(showNormalVC:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:@"正常状态下多选" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.backgroundColor= [UIColor redColor];
    [self.view addSubview:button2];
    
}

//编辑状态下多选
- (void)showEditingVC:(id)sender {
    MS4EditingViewController *msVC = [[MS4EditingViewController alloc] init];
    [self presentViewController:msVC animated:YES completion:nil];
}

//正常状态下多选
- (void)showNormalVC:(id)sender {
    MS4NormalViewController *msVC = [[MS4NormalViewController alloc] init];
    [self presentViewController:msVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
