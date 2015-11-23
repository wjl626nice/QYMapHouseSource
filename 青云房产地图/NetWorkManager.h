//
//  NetWorkManager.h
//  新亚注册登录
//
//  Created by 青云-wjl on 15/11/13.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AFNetWorkManagerDelegate <NSObject>
@optional
-(void)didRequestCommandcode:(NSInteger)code result:(NSMutableDictionary *)resultDic success:(BOOL)isSuccess;
-(void)didRequestForSuperVCommandcode:(NSInteger)code result:(NSMutableDictionary *)resultDic success:(BOOL)isSuccess;

@end




#import "AFNetworking.h"
#import "RequestModel.h"
@interface NetWorkManager : NSObject<AFNetWorkManagerDelegate>
{
    AFHTTPRequestOperation *operation;
}

@property (nonatomic, assign)  id <AFNetWorkManagerDelegate> delegate;

+(instancetype)shareNetWorkManager;

-(void)getMessageCheckCode:(CheckCode *)cCode;//获取短信验证码 125

-(void)toRegister:(Register *)re;

-(void)toLogin:(Login *)lo;

-(void)loginWithCheckCode:(LoginWithCheckCode *)login;

//获取地图房源
-(void)getMapHouseSource:(MapHouseSource *)mapHouseSource;
@end
