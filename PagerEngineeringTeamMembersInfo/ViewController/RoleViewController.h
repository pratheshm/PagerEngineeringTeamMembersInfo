//
//  RoleViewController.h
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/12/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RoleViewControllerDelegate <NSObject>

@required
/**
 *  Delegate to return the role selected from the list
 *
 *  @param role - role for the user
 *
 */
- (void)didSelectRole:(NSString *)role;

@end

@interface RoleViewController : UITableViewController

@property (weak, nonatomic) id<RoleViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *roleSelected;

@end
