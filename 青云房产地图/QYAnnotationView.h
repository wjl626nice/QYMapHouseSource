//
//  QYAnnotationView.h
//  青云房产地图
//
//  Created by newqingyun on 15/11/14.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKAnnotationView.h>
@class MapResult;
@interface QYAnnotationView : BMKAnnotationView
@property (nonatomic, strong)MapResult *annotationData;
@end
