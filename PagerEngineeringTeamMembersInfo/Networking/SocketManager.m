//
//  SocketManager.m
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/10/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import "SocketManager.h"
#import "PSWebSocket.h"
#import "EngineeringTeamMemberParser.h"

@interface SocketManager() <PSWebSocketDelegate>

@property (nonatomic, strong) PSWebSocket *socket;

@end

@implementation SocketManager

- (void)fetchUsersState {
    // create the NSURLRequest that will be sent as the handshake
    NSURLRequest *request =
    [NSURLRequest requestWithURL:[NSURL URLWithString:kSocketServerUrl]];
    
    // create the socket and assign delegate
    self.socket = [PSWebSocket clientSocketWithRequest:request];
    self.socket.delegate = self;
    
    // open socket
    [self.socket open];
}

- (void)close {
    [self.socket close];
}

#pragma mark - PSWebSocketDelegate

- (void)webSocketDidOpen:(PSWebSocket *)webSocket {
    NSLog(@"The websocket handshake completed and is now open!");
    [webSocket send:@"Opened Socket!"];
}

- (void)webSocket:(PSWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"The websocket received a message: %@", message);
    if ([message length] > 0) {
        NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json =
        [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if([[json allKeys] count] > 0) {
            NSString *event = json[@"event"];
            id user = json[@"user"];
            NSString *state = json[@"state"];
            if ([event isEqualToString:@"state_change"]
                && [user length] > 0
                && [state length] > 0
                && [self.delegate respondsToSelector:@selector(didChangeState:forUser:)]) {
                [self.delegate didChangeState:state forUser:user];
            } else if ([event isEqualToString:@"user_new"]) {
                EngineeringTeamMember *member =
                [EngineeringTeamMemberParser memberFromJSON:user];
                if (member != nil
                    && [self.delegate respondsToSelector:@selector(didReceiveNewMember:)]) {
                    [self.delegate didReceiveNewMember:member];
                }
            }
        }
    }
}

- (void)webSocket:(PSWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"The websocket handshake/connection failed with an error: %@", error);
}

- (void)webSocket:(PSWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"The websocket closed with code: %@, reason: %@, wasClean: %@", @(code), reason, (wasClean) ? @"YES" : @"NO");
}

@end
