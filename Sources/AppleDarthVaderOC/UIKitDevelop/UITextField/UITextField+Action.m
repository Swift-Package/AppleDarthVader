//
//  UITextField+Action.m
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import "UITextField+Action.h"

@implementation UITextField (Action)

#pragma mark - 重写该方法决定是否响应动作
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (self.tag == UITextFieldPerformActionTypeNone) {
        return NO;
    } else {
        if (action == @selector(paste:)) {
            // 剪贴板内容不为空时返回粘贴
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            if (pasteboard.string) {
                return YES;
            }
        } else if (action == @selector(selectAll:)) {
            // 内容不为空且内容未全选时返回全选
            if ([self.text isEqualToString:@""] == NO && [[self textInRange:self.selectedTextRange] isEqualToString:self.text] == NO) {
                return YES;
            }
        } else if (action == @selector(cut:) || action == @selector(copy:)) {
            // 有选中内容时返回剪切和拷贝
            if (self.selectedTextRange.isEmpty == NO) {
                return YES;
            }
        }
    }
    
    return NO;
}

@end
