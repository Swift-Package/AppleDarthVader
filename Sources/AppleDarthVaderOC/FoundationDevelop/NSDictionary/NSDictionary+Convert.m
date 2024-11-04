//
//  NSDictionary+Convert.m
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import "NSDictionary+Convert.h"

@implementation NSDictionary (Convert)

#pragma mark - 字典转换成的字符串
- (nullable NSString *)jsonString {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

@end
