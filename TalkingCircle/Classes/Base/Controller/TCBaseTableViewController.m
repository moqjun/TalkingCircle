//
//  ADBaseTableViewController.m
//  PADRP
//
//  Created by zhaoYuan on 17/1/13.
//  Copyright © 2017年 容灾规划支持组. All rights reserved.
//

#import "TCBaseTableViewController.h"
#import "UIBarButtonItem+Extend.h"

@interface TCBaseTableViewController ()

@end

@implementation TCBaseTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.navigationController.viewControllers.count > 1)
    {
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImageNamed:@"navigationbar_back.png" target:self action:@selector(leftBarButtonItemAction:)];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBarButtonItemAction:(id)sender
{
    [self backBarButtonAction];
}

- (void)backBarButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIRectEdge)edgesForExtendedLayout
{
    return UIRectEdgeLeft | UIRectEdgeRight;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
