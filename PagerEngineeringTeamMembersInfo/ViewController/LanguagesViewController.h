//
//  LanguagesViewController.h
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/12/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LanguagesViewControllerDelegate <NSObject>

@required
/**
 *  Delegate to return the languages selected from the list
 *
 *  @param languages - languages for the user
 *
 */
- (void)didSelectLanguages:(NSArray *)languages;

@end

@interface LanguagesViewController : UITableViewController

@property (weak, nonatomic) id<LanguagesViewControllerDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *languagesSelected;

@end
