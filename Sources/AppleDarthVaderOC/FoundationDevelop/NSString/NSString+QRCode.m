//
//  NSString+QRCode.m
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import "NSString+QRCode.h"

@implementation NSString (QRCode)

#pragma mark - 使用字符串生成二维码图片
- (UIImage *)generateQRCodeImageFor:(CGSize)size {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    [filter setValue:[self dataUsingEncoding:NSUTF8StringEncoding] forKey:@"InputMessage"];
    CIImage *outPutImage = [filter outputImage];
    CGRect extent = CGRectIntegral(outPutImage.extent);
    CGFloat scale = MIN(size.width / CGRectGetWidth(extent), size.height / CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outPutImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    UIImage *qrCodeImg = [UIImage imageWithCGImage:scaledImage];
    UIGraphicsBeginImageContextWithOptions(qrCodeImg.size, NO, [[UIScreen mainScreen] scale]);
    [qrCodeImg drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 中间还可以添加Logo图标
    // UIImage *logoImg = [UIImage imageNamed:@"general_logo_ums"];
    // [logoImg drawInRect:CGRectMake(size.width * 0.38, size.height * 0.38, size.width * 0.24, size.height * 0.24)];
    
    UIImage *finalQRCodeImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalQRCodeImg;
}

@end
