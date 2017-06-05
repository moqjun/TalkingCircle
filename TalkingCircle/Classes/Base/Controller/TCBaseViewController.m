//
//  ADBaseViewController.m
//  PADRP
//
//  Created by zhaoYuan on 17/1/13.
//  Copyright © 2017年 容灾规划支持组. All rights reserved.
//

#import "TCBaseViewController.h"
#import "UIBarButtonItem+Extend.h"

@interface TCBaseViewController ()

@end

@implementation TCBaseViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.navigationController.viewControllers.count > 1)
    {
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImageNamed:@"navigationbar_back.png" target:self action:@selector(leftBarButtonItemAction:)];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"e9e9e9"];
    // Do any additional setup after loading the view.
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
