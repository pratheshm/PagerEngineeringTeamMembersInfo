//
//  EngineeringTeamMemberCell.h
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/8/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EngineeringTeamMemberCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *languagesTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *skillTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *emojiFlagLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@end
