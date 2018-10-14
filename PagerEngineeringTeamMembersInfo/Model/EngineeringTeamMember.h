//
//  EngineeringTeamMember.h
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/8/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EngineeringTeamMember : NSObject

@property (nonatomic,strong) NSData *avatarData;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *role;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSString *user;
@property (nonatomic,strong) NSArray *languages;
@property (nonatomic,strong) NSArray *skills;
@property (nonatomic,strong) NSString *location;
@property (nonatomic,strong) NSString *state;

@end
