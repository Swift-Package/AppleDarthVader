//
//  NSData+Convert.m
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import "NSData+Convert.h"

@implementation NSData (Convert)

#pragma mark - Data表示的Int值
- (int)decimalValue {
    unsigned result = 0;
    NSScanner *scanner = [NSScanner scannerWithString:self.lowercaseHexString];
    [scanner scanHexInt:&result];
    return result;
}

#pragma mark - Data表示的浮点值
- (float)floatValue {
    int32_t value;
    [self getBytes:&value length:self.length];
    float result;
    memcpy(&result, &value, sizeof(value));
    
    return result;
}

#pragma mark - NSData转换为十六进制的全小写NSString
- (NSString *)lowercaseHexString {
    Byte *bytes = (Byte *)self.bytes;
    // 下面是Byte转换为16进制
    NSString *hexStr = @"";
    for (int i = 0; i < self.length; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x", bytes[i] & 0xff];// 十六进制数
        
        if (newHexStr.length == 1) {
            hexStr = [NSString stringWithFormat:@"%@0%@", hexStr, newHexStr];
        } else {
            hexStr = [NSString stringWithFormat:@"%@%@", hexStr, newHexStr];
        }
    }
    return hexStr;
}

@end
