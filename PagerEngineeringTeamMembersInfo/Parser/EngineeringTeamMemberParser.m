//
//  EngineeringTeamMemberParser.m
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/10/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import "EngineeringTeamMemberParser.h"

@implementation EngineeringTeamMemberParser

+ (EngineeringTeamMember *)memberFromJSON:(NSDictionary *)json {
    EngineeringTeamMember *member = [[EngineeringTeamMember alloc] init];
    NSString *memberImageUrl = json[kAvatarKey];
    if ([memberImageUrl length] > 0) {
        NSData *imageData =
        [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:memberImageUrl]];
        member.avatarData = imageData;
    }
    
    member.name = json[kNameKey];
    
    NSInteger roleCode = [json[kRoleKey] integerValue];
    NSDictionary *roleMap =
    [[NSUserDefaults standardUserDefaults] dictionaryForKey:kRoleMapKey];
    if([[roleMap allKeys] count] > 0) {
         member.role = [roleMap objectForKey:[NSString stringWithFormat:@"%ld", (long)roleCode]];
    }
   
    member.gender = json[kGenderKey];
    member.user = json[kGithubKey];
    
    NSMutableArray *languages = [[NSMutableArray alloc] init];
    NSArray *languageCodes = json[kLanguagesKey];
    for (NSString *code in languageCodes) {
        NSString *language =
        [[NSLocale currentLocale] localizedStringForLanguageCode:code];
        if ([language length] > 0) {
            [languages addObject:language];
        }
    }
    member.languages = languages;
    
    member.skills = json[kTagsKey];
    member.location = json[kLocationKey];

    return member;
}

@end
