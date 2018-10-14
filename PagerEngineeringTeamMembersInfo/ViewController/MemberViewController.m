//
//  MemberViewController.m
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/10/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import "MemberViewController.h"
#import "NSLocale+Emoji.h"

@interface MemberViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *languagesTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *skillTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *emojiFlagLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = kDetailsScreenTitle;
    
    self.avatarView.image = [UIImage imageWithData:self.member.avatarData];
    self.nameLabel.text = self.member.name;
    self.roleLabel.text = self.member.role;
    self.userLabel.text = self.member.user;
    
    if ([self.member.languages count] > 1) {
        self.languagesTextLabel.text = [self.member.languages componentsJoinedByString:@", "];
    } else if ([self.member.languages count] == 1) {
        self.languagesTextLabel.text = self.member.languages[0];
    } else {
        self.languagesTextLabel.text = @"";
    }
    
    if ([self.member.skills count] > 1) {
        self.skillTextLabel.text = [self.member.skills componentsJoinedByString:@", "];
    } else if ([self.member.skills count] == 1) {
        self.skillTextLabel.text = self.member.skills[0];
    } else {
        self.skillTextLabel.text = @"";
    }
    
    if ([self.member.location length] > 0) {
        self.emojiFlagLabel.text =
        [NSLocale emojiFlagForISOCountryCode:[self.member.location uppercaseString]];
    } else {
        self.emojiFlagLabel.text = @"";
    }
    
    if ([self.member.state length] > 0) {
        self.stateLabel.text = self.member.state;
    } else {
        self.stateLabel.text = kNotAvailableStatus;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.member addObserver:self
                  forKeyPath:@"state"
                     options:NSKeyValueObservingOptionNew
                     context:NULL];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.member removeObserver:self
                     forKeyPath:@"state"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Observe Property Changes

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    if (object != nil) {
        if ([keyPath isEqualToString:@"state"]) {
            if ([self.member.state length] > 0) {
                self.stateLabel.text = self.member.state;
            } else {
                self.stateLabel.text = kNotAvailableStatus;
            }
        }
    }
}

@end
