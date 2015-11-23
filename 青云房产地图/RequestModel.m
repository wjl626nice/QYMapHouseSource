//
//  RequestModel.m
//  新亚注册登录
//
//  Created by 青云-wjl on 15/11/13.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "RequestModel.h"

@implementation RequestModel

@end

@implementation CheckCode

@end

@implementation Register

@end

@implementation Login

@end

@implementation LoginWithCheckCode

@end

@implementation MapHouseSource

@end

@implementation MapResult

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)resultWithDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}

@end