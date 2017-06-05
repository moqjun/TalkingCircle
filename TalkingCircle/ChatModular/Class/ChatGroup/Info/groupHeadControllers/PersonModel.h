//
//  PersonModel.h
//  WeChatGroupInfo
//
//  Created by yueyunyang on 15/10/19.
//  Copyright © 2015年 hackxhj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PersonModel : NSObject

@property(nonatomic, copy) NSString *friendId;
@property(nonatomic,copy)  NSString *userName;
@property(nonatomic, strong) UIImage *txicon;

@property (nonatomic,assign) BOOL checked;

@property (nonatomic,assign) BOOL readOnly;
 
@end
