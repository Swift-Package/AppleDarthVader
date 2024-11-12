//
//  NSString+Convert.h
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Convert)

#pragma mark - 十六进制的NSString为转换NSData不限制字符串字符总个数为双数单数字符串自动在最前面补0
- (NSData *)hexData;

#pragma mark - 转换成MD5字符串不可逆
- (NSString *)md5String;

#pragma mark - 转换成Base64编码格式
- (NSString *)base64String;

#pragma mark - Base64编码格式还原
- (NSString *)base64ToOriginal;

#pragma mark - 将JSON字符串转换成NSDictionary
- (nullable NSDictionary *)jsonToDictionary;

#pragma mark - 将Data转换成JSON字符串
+ (NSString *)jsonStringFromData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
