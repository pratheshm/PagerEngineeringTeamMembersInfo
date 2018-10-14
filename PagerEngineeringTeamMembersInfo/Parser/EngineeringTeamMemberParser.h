//
//  EngineeringTeamMemberParser.h
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/10/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EngineeringTeamMember.h"

@interface EngineeringTeamMemberParser : NSObject

/**
 * an api to retrieve a member object from valid Json
 *
 * @param json dictionary containing member data information.
 *
 * return member object
 */
+ (EngineeringTeamMember *)memberFromJSON:(nonnull NSDictionary *)json;

@end
