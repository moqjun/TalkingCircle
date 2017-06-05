//
//  TCAesCryptTool.h
//  TalkingCircle
//
//  Created by 赵远 on 17/5/2.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCAesCryptTool : NSObject

+ (NSData*)aesEncodeWithKey:(NSString*)key encodeString:(NSString*)encodeString;

+ (NSData*)aesDecodeWithKey:(NSString*)key decodeData:(NSData*)decodeData;

@end
