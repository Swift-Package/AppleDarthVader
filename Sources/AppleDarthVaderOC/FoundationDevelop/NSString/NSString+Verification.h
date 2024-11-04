//
//  NSString+Verification.h
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Verification)

#pragma mark - 是否是空字符串或者是空白字符组成的字符串
- (BOOL)isBlank;

#pragma mark - 是否是合法手机号
+ (BOOL)isValidateMobile:(NSString *)mobile;

@end

NS_ASSUME_NONNULL_END
