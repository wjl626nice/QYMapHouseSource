//
//  NSString+StringSize.m
//  TableCellHeight4LabelML
//
//  Created by qingyun on 15/7/2.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "NSString+StringSize.h"

@implementation NSString (StringSize)

-(CGSize)sizeWithFont:(UIFont *)font Size:(CGSize)size{
    //根据系统版本确定使用哪个api
    CGSize resultSize;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        
        //段落样式
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineBreakMode = NSLineBreakByWordWrapping;
        
        //字体大小，换行模式
        NSDictionary *attributes = @{NSFontAttributeName : font, NSParagraphStyleAttributeName : style};
        
        resultSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }else{
        //计算文字显示需要的区域
        resultSize = [self sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    }

    return resultSize;
}

@end
