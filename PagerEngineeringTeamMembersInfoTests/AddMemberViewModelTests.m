//
//  AddMemberViewModelTests.m
//  PagerEngineeringTeamMembersInfoTests
//
//  Created by Muthu, Pradesh (Contractor) on 10/13/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AddMemberViewModel.h"

@interface AddMemberViewModelTests : XCTestCase

@property (nonatomic, strong) AddMemberViewModel *addMemberViewModel;

@end

@implementation AddMemberViewModelTests

- (void)setUp {
    [super setUp];
    
    self.addMemberViewModel = [[AddMemberViewModel alloc] init];
    
    AddTeamMember *addTeamMember = [[AddTeamMember alloc] init];
    addTeamMember.name = @"XCTestUser One";
    addTeamMember.avatarUrl = @"http://www.dropbox.com/s/plqr5zqnjy4du03/emi.png?dl=1";
    addTeamMember.user = @"testuserone";
    addTeamMember.role = @"Senior Software Engineer";
    addTeamMember.gender = @"Male";
    addTeamMember.languages = @[@"English", @"Tamil"];
    addTeamMember.skills = @[@"J2ME", @"Python"];
    addTeamMember.location = @"Australia";
    self.addMemberViewModel.addTeamMember = addTeamMember;
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

- (void)testIfMemberIsValid {
    XCTAssertEqual([self.addMemberViewModel isMemberValid], YES);
}

@end
