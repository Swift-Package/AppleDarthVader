//
//  NSStringTests.m
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

#import <XCTest/XCTest.h>
@import AppleDarthVaderOC;

@interface NSStringTests : XCTestCase

@end

@implementation NSStringTests

- (void)testExample {
    XCTAssertEqual([NSString stringWithFormat:@"FF"].hexData.decimalValue, 255);
    
    XCTAssertEqual(@"".isBlank, YES);
    XCTAssertEqual(@" ".isBlank, YES);
    XCTAssertEqual(@"  ".isBlank, YES);
    XCTAssertEqual(@" \n\n ".isBlank, YES);
    XCTAssertEqual(@" c ".isBlank, NO);
}

@end
