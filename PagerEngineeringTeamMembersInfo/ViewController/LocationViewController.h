//
//  LocationViewController.h
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/12/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LocationViewControllerDelegate <NSObject>

@required
/**
 *  Delegate to return the location selected from the list
 *
 *  @param location - location for the user
 *
 */
- (void)didSelectLocation:(NSString *)location;

@end

@interface LocationViewController : UITableViewController

@property (weak, nonatomic) id<LocationViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *locationSelected;

@end
