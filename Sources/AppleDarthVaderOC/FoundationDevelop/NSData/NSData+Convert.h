//
//  NSData+Convert.h
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Convert)

#pragma mark - Data表示的Int值
- (int)decimalValue;

#pragma mark - Data表示的浮点值
- (float)floatValue;

#pragma mark - NSData转换为十六进制的全小写NSString
- (NSString *)lowercaseHexString;

@end

NS_ASSUME_NONNULL_END
