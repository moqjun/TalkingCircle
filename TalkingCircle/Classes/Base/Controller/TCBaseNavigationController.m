//
//  BMBaseNavigationController.m
//  Bemetoy
//
//  Created by kennyhuang on 16/3/31.
//  Copyright © 2016年 BM. All rights reserved.
//

#import "TCBaseNavigationController.h"

@interface TCBaseNavigationController ()

@end

@implementation TCBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}

@end
