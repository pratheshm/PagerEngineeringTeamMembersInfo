//
//  SkillsViewController.h
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/12/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SkillsViewControllerDelegate <NSObject>

@required
/**
 *  Delegate to return the skills selected from the list
 *
 *  @param skills - skills of the user
 *
 */
- (void)didSelectSkills:(NSArray *)skills;

@end

@interface SkillsViewController : UITableViewController

@property (weak, nonatomic) id<SkillsViewControllerDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *skillsSelected;

@end
