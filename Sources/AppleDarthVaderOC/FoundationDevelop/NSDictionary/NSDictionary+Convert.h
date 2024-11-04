//
//  NSDictionary+Convert.h
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Convert)

#pragma mark - 字典转换成的字符串
- (nullable NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END
