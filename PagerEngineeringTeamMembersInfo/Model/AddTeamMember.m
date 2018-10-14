//
//  AddTeamMember.m
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/12/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import "AddTeamMember.h"

@implementation AddTeamMember

- (NSDictionary *)json {
    NSMutableDictionary *jsonDict = nil;
    if (self != nil) {
        jsonDict = [[NSMutableDictionary alloc] init];
        
        if ([self.name length] > 0) {
            [jsonDict setObject:self.name forKey:kNameKey];
        }
        
        [jsonDict setObject:@"http://www.dropbox.com/s/plqr5zqnjy4du03/emi.png?dl=1"
                     forKey:kAvatarKey];
        
        if ([self.user length] > 0) {
            [jsonDict setObject:self.user forKey:kGithubKey];
        }
        
        if ([self.role length] > 0) {
            NSDictionary *roleMap =
            [[NSUserDefaults standardUserDefaults] dictionaryForKey:kRoleMapKey];
            for (NSString *roleMapCode in [roleMap allKeys]) {
                NSString *roleMapValue = roleMap[roleMapCode];
                if ([self.role isEqualToString:roleMapValue]) {
                    NSInteger roleMapCodeValue = [roleMapCode integerValue];
                    NSNumber *roleMapNumber = [NSNumber numberWithInteger:roleMapCodeValue];
                    [jsonDict setObject:roleMapNumber forKey:kRoleKey];
                }
            }
        }
        
        if ([self.gender length] > 0) {
            [jsonDict setObject:self.gender forKey:kGenderKey];
        }
        
        if ([self.languages count] > 0) {
            NSDictionary *languageMap =
            [[NSUserDefaults standardUserDefaults] dictionaryForKey:kLanguageMapKey];
            NSMutableArray *languageCodes =
            [[NSMutableArray alloc] initWithCapacity:[self.languages count]];
            for (NSString *language in self.languages) {
                NSString *code = languageMap[language];
                [languageCodes addObject:code];
            }
            
            if ([languageCodes count] > 0) {
                [jsonDict setObject:languageCodes forKey:kLanguagesKey];
            }
        }
        
        if ([self.skills count] > 0) {
            [jsonDict setObject:self.skills forKey:kTagsKey];
        }
        
        if ([self.location length] > 0) {
            NSDictionary *locationMap =
            [[NSUserDefaults standardUserDefaults] dictionaryForKey:kLocationMapKey];
            if ([[locationMap allKeys] count] > 0) {
                [jsonDict setObject:locationMap[self.location] forKey:kLocationKey];
            }
        }
    }
    
    return jsonDict;
}

- (void)clearData {
    self.name = nil;
    self.user = nil;
    self.role = nil;
    self.gender = nil;
    self.languages = nil;
    self.skills = nil;
    self.location = nil;
}

@end
