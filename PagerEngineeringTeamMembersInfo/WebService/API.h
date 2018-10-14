//
//  API.h
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/8/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EngineeringTeamMember.h"
#import "AddTeamMember.h"

@interface API : NSObject

/**
 * an api to get engineering team members list
 *
 * @param completionHandler block retutning the members list
 *
 */
+ (void)getMembersWithCompletionHandler:(void (^)(NSURLSessionDataTask* task, NSArray<EngineeringTeamMember *> *members, NSError* error))completionHandler;
/**
 * an api to get engineering team role and their corresponding codes
 *
 * @param completionHandler block returning the role map(code, role) information
 *
 */
+ (void)getRoleMapWithCompletionHandler:(void (^)(NSURLSessionDataTask* task, NSDictionary *roleDict, NSError* error))completionHandler;
/**
 * an api to add a new member to the existing team member list
 *
 * @param member new member object.
 * @param completionHandler block returning the status/response object of the added member
 *
 */
+ (void)addMember:(AddTeamMember *)member withCompletionHandler:(void(^)(NSURLSessionDataTask *task, id responseObject, NSError *error))completionHandler;
/**
 * an api to retrieve an image with url.
 *
 * @param name url of an image.
 * @param completionHandler block returning the status/response object for the requested image
 *
 */
+ (void)getImageWithUrl:(NSString *)name
   andCompletionHandler:(void (^)(NSURLSessionDataTask* task, NSData *data, NSError* error))completionHandler;

@end
