//
//  QYMapPointAnnotation.h
//  青云房产地图
//
//  Created by newqingyun on 15/11/14.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
@class MapResult;
@interface QYMapPointAnnotation : BMKPointAnnotation

@property (nonatomic, strong)MapResult *result;

@end
