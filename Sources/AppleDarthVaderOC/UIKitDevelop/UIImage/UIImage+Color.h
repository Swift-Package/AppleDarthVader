//
//  UIImage+Color.h
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Color)

#pragma mark - 生成纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

#pragma mark - 取图片某一像素的颜色
- (nullable UIColor *)colorAtPixel:(CGPoint)point;

#pragma mark - 获取灰度图
- (nullable UIImage *)convertToGrayImage;

@end

NS_ASSUME_NONNULL_END
