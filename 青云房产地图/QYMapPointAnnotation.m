//
//  QYMapPointAnnotation.m
//  青云房产地图
//
//  Created by newqingyun on 15/11/14.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "QYMapPointAnnotation.h"
#import "RequestModel.h"
@implementation QYMapPointAnnotation

-(void)setResult:(MapResult *)result
{
    _result = result;
    //设置pointAnnotation的经纬度
    self.coordinate = CLLocationCoordinate2DMake([result.lat doubleValue], [result.lng doubleValue]);
}

@end
