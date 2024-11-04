//
//  UINavigationController+Navigation.h
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (Navigation)

- (void)popToTarget:(NSString *)viewControllerClassName;

- (void)popToFirstTarget:(NSString *)viewControllerClassName;

- (void)filterTargetViewControllers:(NSArray<Class> *)classList;

@end

NS_ASSUME_NONNULL_END
