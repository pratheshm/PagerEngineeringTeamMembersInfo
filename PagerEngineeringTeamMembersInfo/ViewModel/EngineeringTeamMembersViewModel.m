//
//  EngineeringTeamMembersViewModel.m
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/8/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import "EngineeringTeamMembersViewModel.h"
#import "API.h"
#import "SocketManager.h"

@interface EngineeringTeamMembersViewModel() <SocketManagerDelegate>

@property (nonatomic, readwrite) NSDictionary *roleMap;
@property (nonatomic, readwrite) NSMutableArray<EngineeringTeamMember *> *members;
@property (nonatomic, readwrite) NSNumber *memberIndex;
@property (nonatomic, readwrite) NSNumber *membersCount;

@property (nonatomic, strong) SocketManager *socketManager;

/**
 *  Api that returns the role map(rolecode, role)
 *
 *  @param completionHandler - block to return the role map(rolecode, role)
 *
 */
- (void)getRoleMap:(void (^)(NSDictionary *roleMap, NSError* error))completionHandler;

@end

@implementation EngineeringTeamMembersViewModel

- (id)init {
    self = [super init];
    if (self) {
        self.members = [[NSMutableArray alloc] init];
        
        self.socketManager = [[SocketManager alloc] init];
        self.socketManager.delegate = self;
        
        self.memberIndex = [NSNumber numberWithInteger:0];
        self.membersCount = [NSNumber numberWithInteger:0];
    }
    return self;
}


- (void)getMembers:(completionHandler _Nonnull)completionHandler {
    __weak typeof(self) weakSelf = self;
    [self getRoleMap:^(NSDictionary *roleMap, NSError *error) {
        if (error != nil) {
            completionHandler(NO);
        } else {
            if ([[roleMap allKeys] count] > 0) {
                [[NSUserDefaults standardUserDefaults] setObject:roleMap
                                                          forKey:kRoleMapKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            [API getMembersWithCompletionHandler:^(NSURLSessionDataTask *task, NSArray<EngineeringTeamMember *> *members, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error != nil) {
                        completionHandler(NO);
                    } else {
                        [weakSelf.members addObjectsFromArray:members];
                        weakSelf.membersCount = [NSNumber numberWithInteger:members.count];
                        completionHandler(YES);
                    }
                });
            }];
        }
    }];
}

- (void)updateUsersState {
    [self.socketManager fetchUsersState];
}

- (void)getRoleMap:(void (^)(NSDictionary *roleMap, NSError* error))completionHandler {
    __weak typeof(self) weakSelf = self;
    [API getRoleMapWithCompletionHandler:^(NSURLSessionDataTask *task, NSDictionary *roleMap, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error != nil) {
                completionHandler(nil, error);
            } else {
                weakSelf.roleMap = roleMap;
                completionHandler(roleMap, nil);
            }
        });
    }];
}

#pragma mark - SocketManagerDelegate

- (void)didChangeState:(NSString *)state
               forUser:(NSString *)user {
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"SELF.user matches[c] %@", user];
    NSArray *memberArray =
    [self.members filteredArrayUsingPredicate:predicate];
    if ([memberArray count] > 0) {
        EngineeringTeamMember *member = memberArray[0];
        member.state = state;
        
        NSInteger indexOfMember = [self.members indexOfObject:member];
        self.memberIndex = [NSNumber numberWithInteger:indexOfMember];
    }
}

- (void)didReceiveNewMember:(EngineeringTeamMember *)member {
    if (member != nil) {
        [self.members addObject:member];
        self.membersCount = [NSNumber numberWithInteger:self.members.count];
    }
}

@end
