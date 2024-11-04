//
//  UIColor+HexColor.h
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HexColor)

#pragma mark - 从十六进制字符串获取颜色
+ (UIColor *)colorWithHexString:(NSString *)color;

#pragma mark - 从十六进制字符串获取颜色
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
