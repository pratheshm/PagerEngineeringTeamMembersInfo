//
//  SessionManager.h
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/8/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SessionManager : NSObject

@property (nonatomic, readonly) NSURLSession *defaultSession;

/**
 * create shared instance of weather forecast session manager
 *
 * @return sharedInstance shared instance of weather forecast session manager
 *
 */
+ (instancetype)sharedInstance;

/**
 * get call that retrieves the url session data task
 *
 * @param URLString an url string
 * @param success block that returns the success response object
 * @param failure block that returns the failure error object
 *
 */
- (void)GET:(NSString *)URLString
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError* error))failure;
/**
 * post call that posts the url session data and data task
 *
 * @param URLString an url string
 * @param json request body
 * @param success block that returns the success response object
 * @param failure block that returns the failure error object
 *
 */
- (void)POST:(NSString *)URLString
    withJSON:(NSDictionary *)json
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError* error))failure;
/**
 * get call that retrieves the url session data and data task
 *
 * @param URLString an url string
 * @param success block that returns the success response object
 * @param failure block that returns the failure error object
 *
 */
- (void)GETData:(NSString *)URLString
        success:(void (^)(NSData *data, NSURLSessionDataTask *task, id responseObject))success
        failure:(void (^)(NSData *data, NSURLSessionDataTask *task, NSError* error))failure;

@end
