//
//  UIImage+Resize.m
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

#pragma mark - 指定压缩率重设图片大小
- (UIImage *)resizeWith:(CGSize)maxSize compression:(float)quality {
    float maxWidth = maxSize.width;
    float maxHeight = maxSize.height;
    float maxRatio = maxWidth / maxHeight;
    
    float actualWidth = self.size.width;
    float actualHeight = self.size.height;
    float imgRatio = actualWidth / actualHeight;
    
    if (actualHeight > maxHeight || actualWidth > maxWidth) {
        if (imgRatio < maxRatio) {
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        } else if (imgRatio > maxRatio) {
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        } else {
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }

    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, quality);
    UIGraphicsEndImageContext();

    return [UIImage imageWithData:imageData];
}

- (UIImage *)scaleSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];        // 绘制改变大小的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext(); // 从当前context中创建一个改变大小后的图片
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
