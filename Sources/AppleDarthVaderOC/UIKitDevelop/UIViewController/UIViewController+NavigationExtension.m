//
//  UIViewController+NavigationExtension.m
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import "UIViewController+NavigationExtension.h"

@implementation UIViewController (NavigationExtension)

- (void)popTo:(NSString *)viewControllerClassName {
    NSArray *controllers = self.navigationController.viewControllers;
    for (int i = 0; i < controllers.count; i++) {
         if ([controllers[i] isKindOfClass:NSClassFromString(viewControllerClassName)]) {
             [self.navigationController popToViewController:controllers[i] animated:YES];
             break;
          }
    }
}

@end
