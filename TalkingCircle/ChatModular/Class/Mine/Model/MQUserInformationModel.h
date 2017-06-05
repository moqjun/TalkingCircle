//
//  MQUserInformationModel.h
//  TalkingCircle
//
//  Created by iMac on 2017/4/22.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQUserInformationModel : NSObject

@property (nonatomic,strong) NSString *nickname;
@property (nonatomic,strong) NSString *real_name;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *area_id;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *money;




-(instancetype) initWithDictionary:(NSDictionary *) dict;

+(instancetype) userInfoWithDictionary:(NSDictionary *) dict;

-(NSDictionary *) dictionaryWithInit;

+(NSDictionary *) dictionaryWithUserModel:(MQUserInformationModel *) userModel;

@end
