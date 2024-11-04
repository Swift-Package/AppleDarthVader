//
//  UIViewController+NavigationExtension.h
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (NavigationExtension)

- (void)popTo:(NSString *)viewControllerClassName;

@end

NS_ASSUME_NONNULL_END
