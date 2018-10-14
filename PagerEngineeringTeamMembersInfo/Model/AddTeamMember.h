//
//  AddTeamMember.h
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/12/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddTeamMember : NSObject

@property (nonatomic,strong) NSString *avatarUrl;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *role;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSString *user;
@property (nonatomic,strong) NSArray *languages;
@property (nonatomic,strong) NSArray *skills;
@property (nonatomic,strong) NSString *location;

/**
 *  Convert member object in to json dictionary.
 *
 *  @return emoji flag
 */
- (NSDictionary *)json;

/**
 *  Clear all the member property values.
 */
- (void)clearData;

@end
