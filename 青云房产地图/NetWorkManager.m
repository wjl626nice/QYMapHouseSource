//
//  NetWorkManager.m
//  新亚注册登录
//
//  Created by 青云-wjl on 15/11/13.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "NetWorkManager.h"

@implementation NetWorkManager
#define NetWorkAddress @"http://www.fungpu.com/houseapp/apprq.do"
+(instancetype)shareNetWorkManager
{
    static NetWorkManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[self alloc] init];
        }
    });
    return manager;
}



//获取短信验证码 125
-(void)getMessageCheckCode:(CheckCode *)cCode{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *parameterString=[NSString stringWithFormat:@"{\"commandcode\":%ld,\"REQUEST_BODY\":{\"username\":\"%@\",\"code\":%ld}}",(long)cCode.checkCode_commandcode,cCode.checkCode_username,(long)cCode.checkCode_code];
    NSDictionary *loginParameters =@{@"HEAD_INFO":parameterString};
    NSLog(@"%@",parameterString);
    operation=[manager POST:NetWorkAddress parameters:loginParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:responseObject];
        if ([self.delegate respondsToSelector:@selector(didRequestCommandcode:result:success:)]){
            [self.delegate didRequestCommandcode:cCode.checkCode_commandcode result:dic success:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error：%@",error);
        if ([self.delegate respondsToSelector:@selector(didRequestCommandcode:result:success:)]){
            [self.delegate didRequestCommandcode:cCode.checkCode_commandcode result:nil success:NO];
        }
    }];
}


//注册 110
-(void)toRegister:(Register *)re{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *parameterString=[NSString stringWithFormat:@"{\"commandcode\":%ld,\"REQUEST_BODY\":{\"username\":\"%@\",\"code\":\"%@\",\"password\":\"%@\"}}",re.register_commandcode,re.register_username,re.register_checkCode,re.register_password];
    NSDictionary *loginParameters =@{@"HEAD_INFO":parameterString};
    NSLog(@"%@",parameterString);
    operation=[manager POST:NetWorkAddress parameters:loginParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:responseObject];
        if ([self.delegate respondsToSelector:@selector(didRequestCommandcode:result:success:)]){
            [self.delegate didRequestCommandcode:re.register_commandcode result:dic success:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(didRequestCommandcode:result:success:)]){
            [self.delegate didRequestCommandcode:re.register_commandcode result:nil success:NO];
        }
    }];
}


//登录 111
-(void)toLogin:(Login *)lo{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *parameterString=[NSString stringWithFormat:@"{\"commandcode\":%ld,\"REQUEST_BODY\":{\"username\":\"%@\",\"password\":\"%@\"}}",lo.login_commandcode,lo.login_username,lo.login_password];
    NSDictionary *loginParameters =@{@"HEAD_INFO":parameterString};
    NSLog(@"%@",loginParameters);
    operation=[manager POST:NetWorkAddress parameters:loginParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:responseObject];
        if ([self.delegate respondsToSelector:@selector(didRequestCommandcode:result:success:)]){
            [self.delegate didRequestCommandcode:lo.login_commandcode result:dic success:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(didRequestCommandcode:result:success:)]){
            [self.delegate didRequestCommandcode:lo.login_commandcode result:nil success:NO];
        }
    }];
}

//用验证码登录，并修改密码 126
-(void)loginWithCheckCode:(LoginWithCheckCode *)login{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *parameterString=[NSString stringWithFormat:@"{\"commandcode\":%ld,\"REQUEST_BODY\":{\"username\":\"%@\",\"code\":\"%@\",\"newpassword\":\"%@\"}}",login.login_commandcode,login.login_username,login.login_checkCode,login.login_password];
    NSDictionary *loginParameters =@{@"HEAD_INFO":parameterString};
    NSLog(@"%@",parameterString);
    operation=[manager POST:NetWorkAddress parameters:loginParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:responseObject];
        if ([self.delegate respondsToSelector:@selector(didRequestCommandcode:result:success:)]){
            [self.delegate didRequestCommandcode:login.login_commandcode result:dic success:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([self.delegate respondsToSelector:@selector(didRequestCommandcode:result:success:)]){
            [self.delegate didRequestCommandcode:login.login_commandcode result:nil success:NO];
        }
    }];
}

//根据地图房源信息 122
-(void)getMapHouseSource:(MapHouseSource *)mapHouseSource{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *parameterString=[NSString stringWithFormat:@"{\"commandcode\":%ld,\"REQUEST_BODY\":{\"city\":\"%@\",\"minlat\":%lf,\"maxlat\":%lf,\"minlng\":%lf,\"maxlng\":%lf,\"zoomLevel\":%f}}",mapHouseSource.commandcode,mapHouseSource.cityName,mapHouseSource.minLat,mapHouseSource.maxLat,mapHouseSource.minLng,mapHouseSource.maxLng,mapHouseSource.zoomLevel];
    NSLog(@"118、112parameterString：%@",parameterString);
    NSDictionary *loginParameters =@{@"HEAD_INFO":parameterString};

    operation=[manager POST:NetWorkAddress parameters:loginParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:responseObject];
        if ([self.delegate respondsToSelector:@selector(didRequestCommandcode:result:success:)]){
            [self.delegate didRequestCommandcode:mapHouseSource.commandcode result:dic success:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(didRequestCommandcode:result:success:)]){
            [self.delegate didRequestCommandcode:mapHouseSource.commandcode result:nil success:NO];
        }
    }];
}

@end
