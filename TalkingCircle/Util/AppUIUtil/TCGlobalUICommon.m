//
//  TCGlobalUICommon.m
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/22.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "TCGlobalUICommon.h"

@implementation TCGlobalUICommon


void TCAlert(NSString* message) {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TC.alert.title", nil)
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"TC.alert.confirm.button", nil)
                                          otherButtonTitles:nil];
    [alert show];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
void TCAlertNoTitle(NSString* message) {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"TC.alert.confirm.button", nil)
                                          otherButtonTitles:nil];
    [alert show];
}

@end
