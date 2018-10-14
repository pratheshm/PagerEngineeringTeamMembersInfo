//
//  NSLocaleEmoji.m
//  PagerEngineeringTeamMembersInfoTests
//
//  Created by Muthu, Pradesh (Contractor) on 10/13/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSLocale+Emoji.h"

@interface NSLocaleEmojiTests : XCTestCase

@end

@implementation NSLocaleEmojiTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testEmojiInfoForCountryCodeUS {
    NSString *emojiFlag = [NSLocale emojiFlagForISOCountryCode:@"US"];
    XCTAssertTrue([emojiFlag isEqual:@"🇺🇸"], @"Emoji comparision for the country code should be passed");
}

@end
