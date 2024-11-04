//
//  NSString+Verification.m
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import "NSString+Verification.h"

@implementation NSString (Verification)

#pragma mark - 是否是空字符串或者是空白字符组成的字符串
- (BOOL)isBlank {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0;
}

#pragma mark - 是否是合法手机号
+ (BOOL)isValidateMobile:(NSString *)mobile {
    NSString *regex = @"^1(3[0-9]|4[57]|5[0-35-9]|66|8[0-9]|7[06-8])\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:mobile];
}

@end
