//
//  SkywalkerGCDTimer.h
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SkywalkerGCDTimer : NSObject

#pragma mark - 初始化计时器
+ (SkywalkerGCDTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats queue:(dispatch_queue_t)queue block:(void (^) (void))block;

#pragma mark - 无效化计时器
- (void)invalidate;

@end

NS_ASSUME_NONNULL_END
