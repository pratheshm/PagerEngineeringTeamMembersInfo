//
//  EngineeringTeamMembersViewModelTests.m
//  PagerEngineeringTeamMembersInfoTests
//
//  Created by Muthu, Pradesh (Contractor) on 10/13/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EngineeringTeamMembersViewModel.h"

@interface EngineeringTeamMembersViewModelTests : XCTestCase

@property (nonatomic, strong) EngineeringTeamMembersViewModel *engineeringTeamMemberViewModel;

@end

@implementation EngineeringTeamMembersViewModelTests

- (void)setUp {
    [super setUp];
    
    self.engineeringTeamMemberViewModel = [[EngineeringTeamMembersViewModel alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.engineeringTeamMemberViewModel = nil;
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

- (void)testGetMembers {
    XCTestExpectation *expectation = [self expectationWithDescription:@"testAddMember"];
    
    [self.engineeringTeamMemberViewModel getMembers:^(BOOL success) {
        XCTAssertEqual(success, YES, @"Retrieve engineering team members");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:30.0
                                 handler:^(NSError *error) {
                                     if (error) {
                                         XCTFail(@"Expectation Failed with error: %@", error);
                                     }
                                 }];
}

@end
