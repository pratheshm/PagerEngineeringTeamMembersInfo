//
//  NSLocale+Emoji.h
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/10/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSLocale (Emoji)

/**
 *  Convert country code to its corresponding emoji flag.
 *
 *  @param countryCode - code of a country
 *
 *  @return emoji flag
 */
+ (NSString *)emojiFlagForISOCountryCode:(NSString *)countryCode;

@end
