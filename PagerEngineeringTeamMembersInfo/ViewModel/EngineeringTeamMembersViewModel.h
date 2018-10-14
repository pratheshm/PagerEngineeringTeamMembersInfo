//
//  EngineeringTeamMembersViewModel.h
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/8/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EngineeringTeamMember.h"

typedef void(^completionHandler)(BOOL success);

@interface EngineeringTeamMembersViewModel : NSObject

@property (nonatomic, readonly) NSMutableArray<EngineeringTeamMember *> *members;
@property (nonatomic, readonly) NSNumber *memberIndex;
@property (nonatomic, readonly) NSNumber *membersCount;

/**
 *  Retrieve the members list
 *
 *  @param completionHandler - block that returns members list
 *
 */
- (void)getMembers:(completionHandler _Nonnull)completionHandler;
/**
 *  Update users state whenever state change is found
 */
- (void)updateUsersState;

@end
