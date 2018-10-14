//
//  API.m
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/8/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import "API.h"
#import "SessionManager.h"
#import "EngineeringTeamMemberParser.h"

@implementation API

+ (void)getMembersWithCompletionHandler:(void (^)(NSURLSessionDataTask* task, NSArray<EngineeringTeamMember *> *members, NSError* error))completionHandler {
    [[SessionManager sharedInstance] GET:kTeamRequestUrl
                                 success:^(NSURLSessionDataTask *task, id responseObject) {
                                     if (responseObject !=  nil
                                         && [responseObject isKindOfClass:[NSArray class]]) {
                                         NSMutableArray<EngineeringTeamMember *> *members = [[NSMutableArray alloc] init];
                                         NSArray *memberList = (NSArray *)responseObject;
                                         for (NSDictionary *memberDict in memberList) {
                                             EngineeringTeamMember *member =
                                             [EngineeringTeamMemberParser memberFromJSON:memberDict];
                                             [members addObject:member];
                                         
                                             if (completionHandler != nil) {
                                                 completionHandler(task, members, nil);
                                             }
                                         }
                                     }
                                 } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                     if (completionHandler != nil) {
                                         completionHandler(task, nil, error);
                                     }
                                 }];
}

+ (void)getRoleMapWithCompletionHandler:(void (^)(NSURLSessionDataTask* task, NSDictionary *roleMap, NSError* error))completionHandler {
    [[SessionManager sharedInstance] GET:kRolesMapRequestUrl
                                 success:^(NSURLSessionDataTask *task, id responseObject) {
                                     if (responseObject !=  nil) {
                                         if (completionHandler != nil) {
                                             completionHandler(task, responseObject, nil);
                                         }
                                     }
                                 } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                     if (completionHandler != nil) {
                                         completionHandler(task, nil, error);
                                     }
                                 }];
}

+ (void)addMember:(AddTeamMember *)member
withCompletionHandler:(void(^)(NSURLSessionDataTask *task, id responseObject, NSError *error))completionHandler {
    [[SessionManager sharedInstance] POST:kTeamRequestUrl
                                 withJSON:[member json]
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                      if (responseObject !=  nil) {
                                          if (completionHandler != nil) {
                                              completionHandler(task, responseObject, nil);
                                          }
                                      }
                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      if (completionHandler != nil) {
                                          completionHandler(task, nil, error);
                                      }
                                  }];
}

+ (void)getImageWithUrl:(NSString *)url
   andCompletionHandler:(void (^)(NSURLSessionDataTask* task, NSData *data, NSError* error))completionHandler {
    [[SessionManager sharedInstance] GETData:url
                                     success:^(NSData *data, NSURLSessionDataTask *task, id responseObject) {
                                         if (completionHandler != nil) {
                                             completionHandler(task, data, nil);
                                         }
                                     } failure:^(NSData *data, NSURLSessionDataTask *task, NSError *error) {
                                         if (completionHandler != nil) {
                                             completionHandler(task, nil, error);
                                         }
                                     }];
}

@end
