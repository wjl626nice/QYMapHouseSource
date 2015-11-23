//
//  ViewController.m
//  青云房产地图
//
//  Created by newqingyun on 15/11/14.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "NetWorkManager.h"
#import "RequestModel.h"
#import "QYMapPointAnnotation.h"
#import "QYAnnotationView.h"
@interface ViewController ()<BMKMapViewDelegate,AFNetWorkManagerDelegate>
@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) QYAnnotationView *didSelectedAnnotationView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapView = [[BMKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_mapView];
    
    //设置地图显示的中心的经纬度
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(25.046818849581, 102.71197718839)];
    //设定是否总让选中的annotaion置于最前面
    _mapView.isSelectedAnnotationViewFront = YES;
    _mapView.zoomLevel = 12;
    
    // Do any additional setup after loading the view, typically from a nib.
}
//发起网络请求，获取房源信息
-(void)getHouseSourceNumber
{
    MapHouseSource *mapSource = [[MapHouseSource alloc] init];
    mapSource.commandcode = 122;
    mapSource.cityName = @"昆明";
    mapSource.zoomLevel = _mapView.zoomLevel;
    //取屏幕左上角、右下角点对应的经纬度
    CLLocationCoordinate2D minMapCoordinate = [_mapView convertPoint:CGPointMake(_mapView.frame.origin.x, _mapView.frame.origin.y) toCoordinateFromView:_mapView];
    CLLocationCoordinate2D maxMapCoordinate = [_mapView convertPoint:CGPointMake(_mapView.frame.origin.x + _mapView.frame.size.width, _mapView.frame.origin.y + _mapView.frame.size.height) toCoordinateFromView:_mapView];
    
    mapSource.minLat = maxMapCoordinate.latitude;
    mapSource.minLng = minMapCoordinate.longitude;
    mapSource.maxLat = minMapCoordinate.latitude;
    mapSource.maxLng = maxMapCoordinate.longitude;
    
    [NetWorkManager shareNetWorkManager].delegate = self;
    [[NetWorkManager shareNetWorkManager] getMapHouseSource:mapSource];
    
}

#pragma mark -网络请求数据返回
-(void)didRequestCommandcode:(NSInteger)code result:(NSMutableDictionary *)resultDic success:(BOOL)isSuccess
{
    NSLog(@"%@",resultDic);
    NSArray *array = resultDic[@"RESPONSE_BODY"][@"list"];
    
    NSMutableArray *models = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        MapResult *result = [MapResult resultWithDictionary:dict];
        QYMapPointAnnotation *pointAnnotation = [[QYMapPointAnnotation alloc] init];
        pointAnnotation.result = result;
        [models addObject:pointAnnotation];
    }
    //移除之前添加的annotation
    [_mapView removeAnnotations:_mapView.annotations];
    //添加新的annotation
    [_mapView addAnnotations:models];
    
}

#pragma mark -地图委托
//地图初始化完成
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    [self getHouseSourceNumber];
}
//根据anntation生成对应的View
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    QYMapPointAnnotation *pointAnnotation = (QYMapPointAnnotation *)annotation;
    static NSString *identifier = @"annotation";
    QYAnnotationView *annotationView = (QYAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        annotationView = [[QYAnnotationView alloc] initWithAnnotation:pointAnnotation reuseIdentifier:identifier];
    }
    annotationView.annotationData = pointAnnotation.result;
    return annotationView;
}

//当选中一个annotation views时，调用此接口
-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    QYAnnotationView *annotaionView = (QYAnnotationView *)view;
    if (annotaionView.annotationData.flag == 0) {
        //设置地图的中心点为当前点击的annotaionView的经纬度
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake([annotaionView.annotationData.lat doubleValue], [annotaionView.annotationData.lng doubleValue])];
        _mapView.zoomLevel = 12;
    }else if (annotaionView.annotationData.flag == 1){
        //设置地图的中心点为当前点击的annotaionView的经纬度
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake([annotaionView.annotationData.lat doubleValue], [annotaionView.annotationData.lng doubleValue])];
        _mapView.zoomLevel = 16;
    }else if (annotaionView.annotationData.flag == 3){
        NSLog(@"%@",annotaionView.annotationData.mid);
        [annotaionView setSelected:YES animated:YES];
        _didSelectedAnnotationView = annotaionView;
    }
}
//当取消选中一个annotation views时，调用此接口
-(void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    QYAnnotationView *annotationView = (QYAnnotationView *)view;
    [annotationView setSelected:NO animated:YES];
}
//点中底图空白处会回调此接口
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    [_didSelectedAnnotationView setSelected:NO animated:YES];
}

//地图区域改变完成后会调用此接口
-(void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self getHouseSourceNumber];
}

#pragma mark 其他

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _mapView.delegate = self;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _mapView.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
