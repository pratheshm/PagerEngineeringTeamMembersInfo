//
//  SessionManagerTests.m
//  PagerEngineeringTeamMembersInfoTests
//
//  Created by Muthu, Pradesh (Contractor) on 10/13/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Constants.h"
#import "URLConstants.h"

@interface SessionManagerTests : XCTestCase

@property (nonatomic, strong) NSURLSession *defaultSession;

@end

@implementation SessionManagerTests

- (void)setUp {
    [super setUp];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.defaultSession = [NSURLSession sessionWithConfiguration:configuration];
}

- (void)tearDown {
    self.defaultSession = nil;
    [super tearDown];
}

- (void)testGetMembersCall {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Status code: 200"];
    
    NSURL *url = [NSURL URLWithString:kTeamRequestUrl];
    [[self.defaultSession dataTaskWithURL:url
                        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                            if (error) {
                                XCTFail(@"Error: %@", error.localizedDescription);
                            } else {
                                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                XCTAssertEqual([httpResponse statusCode], 200);
                                [expectation fulfill];
                            }
                        }] resume];
    [self waitForExpectationsWithTimeout:5.0
                                 handler:^(NSError *error) {
                                     if(error) {
                                         XCTFail(@"Expectation Failed with error: %@", error);
                                     }
                                 }];
}

- (void)testGetRolesCall {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Status code: 200"];
    
    NSURL *url = [NSURL URLWithString:kRolesMapRequestUrl];
    [[self.defaultSession dataTaskWithURL:url
                        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                            if (error) {
                                XCTFail(@"Error: %@", error.localizedDescription);
                            } else {
                                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                XCTAssertEqual([httpResponse statusCode], 200);
                                [expectation fulfill];
                            }
                        }] resume];
    [self waitForExpectationsWithTimeout:5.0
                                 handler:^(NSError *error) {
                                     if(error) {
                                         XCTFail(@"Expectation Failed with error: %@", error);
                                     }
                                 }];
}

- (void)testAddMemberCall {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Status code: 200"];
    
    NSURL *url = [NSURL URLWithString:kTeamRequestUrl];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSDictionary *jsonDict =
    @{
      kAvatarKey : @"http://www.dropbox.com/s/plqr5zqnjy4du03/emi.png?dl=1",
      kGenderKey : @"Male",
      kGithubKey : @"TestUser2",
      kLanguagesKey :@[@"ach", @"ady"],
      kLocationKey: @"ES",
      kNameKey : @"XCUserTest Two",
      kRoleKey: @4,
      kTagsKey : @[@"Swift", @"Objective-C"]
      };
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict
                                                       options:kNilOptions
                                                         error:nil];
    [request setHTTPBody:jsonData];
    
    [[self.defaultSession dataTaskWithRequest:request
                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                if (error) {
                                    XCTFail(@"Error: %@", error.localizedDescription);
                                } else {
                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                    XCTAssertEqual([httpResponse statusCode], 200);
                                    [expectation fulfill];
                                }
                            }] resume];
    
    [self waitForExpectationsWithTimeout:5.0
                                 handler:^(NSError *error) {
                                     if(error) {
                                         XCTFail(@"Expectation Failed with error: %@", error);
                                     }
                                 }];
    
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

@end
