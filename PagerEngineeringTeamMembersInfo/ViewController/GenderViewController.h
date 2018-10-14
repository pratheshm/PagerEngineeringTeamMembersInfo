//
//  GenderViewController.h
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/12/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GenderViewControllerDelegate <NSObject>

@required
/**
 *  Delegate to return the gender selected from the list
 *
 *  @param gender - gender of the user
 *
 */
- (void)didSelectGender:(NSString *)gender;

@end

@interface GenderViewController : UITableViewController

@property (weak, nonatomic) id<GenderViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *genderSelected;

@end
