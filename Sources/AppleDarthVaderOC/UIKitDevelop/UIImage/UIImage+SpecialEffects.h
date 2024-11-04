//
//  UIImage+SpecialEffects.h
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SpecialEffects)

#pragma mark - 为UIImage对象设置透明度
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
