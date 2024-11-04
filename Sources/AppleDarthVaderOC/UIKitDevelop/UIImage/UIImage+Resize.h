//
//  UIImage+Resize.h
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Resize)

#pragma mark - 指定压缩率重设图片大小
- (UIImage *)resizeWith:(CGSize)maxSize compression:(float)quality;

- (UIImage *)scaleSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
