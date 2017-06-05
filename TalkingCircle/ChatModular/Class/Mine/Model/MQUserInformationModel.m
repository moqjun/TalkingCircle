//
//  MQUserInformationModel.m
//  TalkingCircle
//
//  Created by iMac on 2017/4/22.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQUserInformationModel.h"

@implementation MQUserInformationModel

-(instancetype) initWithDictionary:(NSDictionary *) dict
{
    self =[super init];
    if (self)
    {
        [self setValuesForKeysWithDictionary:dict];
        if (self.email == nil)
        {
            _email = @"";
        }
        
        if(_address == nil)
        {
            _address = @"";
        }
        
        if(_area_id == nil)
        {
            _area_id = @"";
        }
        
        if (_nickname == nil)
        {
            _nickname = @"";
        }
        
        if (_real_name == nil)
        {
            _real_name = @"";
        }
        if (_money == nil) {
            _money = @"";
        }
    }
    return self;
}

+(instancetype) userInfoWithDictionary:(NSDictionary *) dict
{
    return [[self alloc] initWithDictionary:dict];
}

-(NSDictionary *) dictionaryWithInit
{
    NSArray *keys = @[@"nickname",@"real_name",@"email",@"area_id",@"address",@"money"];
    
    return [self dictionaryWithValuesForKeys:keys];
}

+(NSDictionary *) dictionaryWithUserModel:(MQUserInformationModel *) userModel
{
    return [userModel dictionaryWithInit];
}

@end
