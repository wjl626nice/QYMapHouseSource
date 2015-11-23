//
//  QYAnnotationView.m
//  青云房产地图
//
//  Created by newqingyun on 15/11/14.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "QYAnnotationView.h"
#import "RequestModel.h"
#import "NSString+StringSize.h"
@implementation QYAnnotationView
//初始化QYAnnotationView
-(instancetype)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        //当为YES时，view被选中时会弹出气泡，annotation必须实现了title这个方法
        self.canShowCallout = NO;
    }
    return self;
}
//选中AnnotationView
-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.image = [self getAnnotationImageTitle:[@(_annotationData.count) stringValue] isSelcted:selected];
}
//设置AnnotationView的annotationData，以及设置它的image
-(void)setAnnotationData:(MapResult *)annotationData
{
    _annotationData = annotationData;
    
    if (annotationData.flag == 3) {
        self.image = [self getAnnotationImageTitle:[@(annotationData.count) stringValue] isSelcted:NO];
    }else{
        CGSize size = [annotationData.title sizeWithFont:[UIFont boldSystemFontOfSize:24] Size:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT)];
        CGFloat width = size.width;
        CGFloat viewWidth = sqrtf(width * width + 40 * 40);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  viewWidth, viewWidth)];
        
        CGFloat firstLabelX = (viewWidth - width) / 2.0;
        CGFloat firstLabelY = (viewWidth - 40) / 2.0;
        CGFloat firstLabelW = width;
        CGFloat firstLabelH = 20;
        UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(firstLabelX, firstLabelY, firstLabelW, firstLabelH)];
        firstLabel.text = annotationData.title;
        firstLabel.textAlignment = NSTextAlignmentCenter;
        firstLabel.textColor = [UIColor whiteColor];
        [view addSubview:firstLabel];
        
        CGFloat secondLabelX = (viewWidth - width) / 2.0;
        CGFloat secondLabelY = viewWidth / 2.0;
        CGFloat secondLabelW = width;
        CGFloat secondLabelH = 20;
        UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(secondLabelX, secondLabelY, secondLabelW, secondLabelH)];
        secondLabel.text = [@(annotationData.count) stringValue];
        secondLabel.textAlignment = NSTextAlignmentCenter;
        secondLabel.textColor = [UIColor whiteColor];
        [view addSubview:secondLabel];
        
        view.backgroundColor = [UIColor colorWithRed:81/255.0 green:156/255.0 blue:254/255.0 alpha:0.9];
        view.layer.cornerRadius = viewWidth / 2;
        view.userInteractionEnabled = YES;
        
        self.image = [self getImageFormView:view];
    }
}

//根据标题、选中状态返回annotationView的image
-(UIImage *)getAnnotationImageTitle:(NSString *)title isSelcted:(BOOL)selected
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 50)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.frame];
    [view addSubview:imageView];
    if (selected) {
        imageView.image = [UIImage imageNamed:@"selectedSign"];
    }else{
        imageView.image = [UIImage imageNamed:@"sign"];
    }
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, 70, 20)];
    label.text = [NSString stringWithFormat:@"%@套",title];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:24];
    [view addSubview:label];
    return [self getImageFormView:view];
}

-(UIImage *)getImageFormView:(UIView *)view
{
    //创建一个跟view相同大小的上下文
    UIGraphicsBeginImageContext(view.bounds.size);
    //把view中的layer绘制到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //返回一个基于当前上下文的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
