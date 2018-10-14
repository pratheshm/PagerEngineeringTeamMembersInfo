//
//  SocketManager.h
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/10/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EngineeringTeamMember.h"

@protocol SocketManagerDelegate <NSObject>

@required
/**
 *  Delegate that update the state change for the member
 *
 *  @param state - state of the member
 *  @param user - member name
 *
 */
- (void)didChangeState:(NSString *)state
               forUser:(NSString *)user;
/**
 *  Delegate that returns new member
 *
 *  @param member - new member
 *
 */
- (void)didReceiveNewMember:(EngineeringTeamMember *)member;

@end

@interface SocketManager : NSObject

@property (weak, nonatomic) id<SocketManagerDelegate> delegate;

/**
 *  Api to fetch the members state
 */
- (void)fetchUsersState;
/**
 *  Close the socket connection
 */
- (void)close;

@end
