//
//  NSString+QRCode.h
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (QRCode)

#pragma mark - 使用字符串生成二维码图片
- (UIImage *)generateQRCodeImageFor:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
