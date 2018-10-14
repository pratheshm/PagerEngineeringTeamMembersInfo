//
//  AddMemberViewModel.m
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/12/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import "AddMemberViewModel.h"
#import "API.h"

@implementation AddMemberViewModel

- (id)init {
    self = [super init];
    if (self) {
        self.addTeamMember = [[AddTeamMember alloc] init];
    }
    return self;
}

- (void)addMember:(completionHandler _Nonnull)completionHandler {
    [API addMember:self.addTeamMember withCompletionHandler:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error != nil) {
                completionHandler(NO);
            } else {
                completionHandler(YES);
            }
        });
    }];
}

- (BOOL)isMemberValid {
    return ([self.addTeamMember.name length] > 0
            && [self.addTeamMember.user length] > 0
            && [self.addTeamMember.role length] > 0
            && [self.addTeamMember.gender length] > 0
            && [self.addTeamMember.languages count] > 0
            && [self.addTeamMember.skills count] > 0
            && [self.addTeamMember.location length] > 0);
}

@end
