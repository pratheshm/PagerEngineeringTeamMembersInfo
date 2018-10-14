//
//  AddMemberViewModel.h
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/12/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddTeamMember.h"

typedef void(^completionHandler)(BOOL success);

@interface AddMemberViewModel : NSObject

@property (nonatomic, readwrite) AddTeamMember *addTeamMember;

/**
 *  Api to add a new member
 */
- (void)addMember:(completionHandler _Nonnull)completionHandler;
/**
 *  Api to identify a member if it is valid or not
 *
 *  @return if member is valid or not
 */
- (BOOL)isMemberValid;

@end
