//
//  UIBarButtonItem+Extend.m
//  PADRP
//
//  Created by zhaoYuan on 17/1/13.
//  Copyright © 2017年 容灾规划支持组. All rights reserved.
//

#import "UIBarButtonItem+Extend.h"

@implementation UIBarButtonItem (Extend)

- (instancetype)initWithImageNamed:(NSString *)imageNamed target:(id)target action:(SEL)action
{
    UIImage *image = [UIImage imageNamed:imageNamed];
    if((self = [self initWithImage:image style:UIBarButtonItemStylePlain target:target action:action]))
    {
        
    }
    return self;
}

@end
