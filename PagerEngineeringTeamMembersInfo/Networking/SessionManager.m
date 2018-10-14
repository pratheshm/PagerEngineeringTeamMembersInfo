//
//  SessionManager.m
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/8/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import "SessionManager.h"

@interface SessionManager ()

@property (nonatomic, strong) NSURLSession *defaultSession;

@end

@implementation SessionManager

#pragma mark - Initializers

- (id)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.defaultSession = [NSURLSession sessionWithConfiguration:configuration];
    }
    
    return self;
}

+ (instancetype) sharedInstance {
    static SessionManager *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - URLSession Utility Methods

- (void)GET:(NSString *)URLString
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError* error))failure {
    NSURL *url = [NSURL URLWithString:URLString];
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask =
    [self.defaultSession dataTaskWithURL:url
                       completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                           if (error) {
                               failure(dataTask, error);
                           } else {
                               NSError *error = nil;
                               
                               id responseObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                   options:kNilOptions
                                                                                     error:&error];
                               success(dataTask, responseObject);
                           }
                       }];
    
    [dataTask resume];
}

- (void)POST:(NSString *)URLString
    withJSON:(NSDictionary *)json
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError* error))failure {    
    NSURL *url = [NSURL URLWithString:URLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json
                                                       options:kNilOptions
                                                         error:nil];
    [request setHTTPBody:jsonData];
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask =
    [self.defaultSession dataTaskWithRequest:request
                             completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                 if (error) {
                                     failure(dataTask, error);
                                 } else {
                                     NSError *error = nil;
                                     
                                     id responseObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                         options:kNilOptions
                                                                                           error:&error];
                                     success(dataTask, responseObject);
                                 }
                             }];
    
    [dataTask resume];
}

- (void)GETData:(NSString *)URLString
        success:(void (^)(NSData *data, NSURLSessionDataTask *task, id responseObject))success
        failure:(void (^)(NSData *data, NSURLSessionDataTask *task, NSError* error))failure {
    NSURL *url = [NSURL URLWithString:URLString];
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask =
    [self.defaultSession dataTaskWithURL:url
                       completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                           if (error) {
                               failure(data, dataTask, error);
                           } else {
                               NSError *error = nil;
                               id responseObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                   options:kNilOptions
                                                                                     error:&error];
                               success(data, dataTask, responseObject);
                           }
                       }];
    
    [dataTask resume];
}

@end
