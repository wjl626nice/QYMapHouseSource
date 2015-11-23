//
//  RequestModel.h
//  新亚注册登录
//
//  Created by 青云-wjl on 15/11/13.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestModel : NSObject

@end

@interface CheckCode : NSObject
@property(nonatomic)NSInteger checkCode_commandcode;
@property(nonatomic)NSInteger checkCode_code;//请求类别 1 用户注册 , 2 取回密码
@property(nonatomic,strong)NSString *checkCode_username;

@end

@interface Register : NSObject
@property(nonatomic)NSInteger register_commandcode;
@property(nonatomic,strong)NSString *register_username;//手机号码
@property(nonatomic,strong)NSString *register_password;//密码
@property(nonatomic,strong)NSString *register_checkCode;//短信验证码

@end

@interface Login : NSObject
@property(nonatomic)NSInteger login_commandcode;
@property(nonatomic,strong)NSString *login_username;//手机号码
@property(nonatomic,strong)NSString *login_password;//密码

@end

@interface LoginWithCheckCode : NSObject
@property(nonatomic)NSInteger login_commandcode;
@property(nonatomic,strong)NSString *login_username;//手机号码
@property(nonatomic,strong)NSString *login_password;//密码
@property(nonatomic,strong)NSString *login_checkCode;//短信验证码

@end

//二手房地图房源+数量
@interface MapHouseSource : NSObject

@property(nonatomic)NSInteger commandcode;
@property(nonatomic)double minLat;
@property(nonatomic)double maxLat;
@property(nonatomic)double minLng;
@property(nonatomic)double maxLng;
@property(nonatomic)float zoomLevel;
@property(nonatomic,strong)NSString *cityName;

@end

@interface MapResult : NSObject
@property (nonatomic)NSInteger count;
@property (nonatomic)NSInteger flag;
@property (nonatomic, strong)NSString *lat;
@property (nonatomic, strong)NSString *lng;
@property (nonatomic, strong)NSString *mid;
@property (nonatomic, strong)NSString *title;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)resultWithDictionary:(NSDictionary *)dict;
@end
