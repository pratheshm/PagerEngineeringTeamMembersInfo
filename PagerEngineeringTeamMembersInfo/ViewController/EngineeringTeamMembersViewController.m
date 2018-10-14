//
//  EngineeringTeamMembersViewController.m
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/8/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import "EngineeringTeamMembersViewController.h"
#import "MemberViewController.h"
#import "EngineeringTeamMemberCell.h"
#import "ServiceErrorView.h"
#import "ProgressView.h"
#import "NSLocale+Emoji.h"

static float const kEstimatedTableCellHeight = 205.0f;

@interface EngineeringTeamMembersViewController () <ServiceErrorViewDelegate>

@property (nonatomic, strong) ServiceErrorView *serviceErrorView;
@property (nonatomic, strong) ProgressView *progressView;

/**
 *  Show/hide service error
 *
 *  @param show - flag to show/hide service error
 *
 */
- (void)showServiceError:(BOOL)show;
/**
 *  Show/hide progress indicator
 *
 *  @param show - flag to show/hide progress indicator
 *
 */
- (void)showProgressIndicator:(BOOL)show;
/**
 *  Call get members api call
 */
- (void)getMembers;

@end

@implementation EngineeringTeamMembersViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView* backgroundView =
    [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
    [backgroundView setBackgroundColor:[UIColor lightGrayColor]];
    [self.tableView setBackgroundView:backgroundView];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = kEstimatedTableCellHeight;
    
    self.serviceErrorView = [[ServiceErrorView alloc] initWithFrame:self.view.frame];
    self.serviceErrorView.delegate = self;
    [self.view addSubview:self.serviceErrorView];
    [self showServiceError:NO];
    
    self.viewModel = [[EngineeringTeamMembersViewModel alloc] init];
    
    self.progressView = [[ProgressView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.progressView];
    [self showProgressIndicator:YES];
    
    [self getMembers];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    [self.viewModel addObserver:self
                     forKeyPath:@"memberIndex"
                        options:NSKeyValueObservingOptionNew
                        context:NULL];
    [self.viewModel addObserver:self
                     forKeyPath:@"membersCount"
                        options:NSKeyValueObservingOptionNew
                        context:NULL];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.viewModel removeObserver:self
                        forKeyPath:@"memberIndex"];
    [self.viewModel removeObserver:self
                        forKeyPath:@"membersCount"];
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
        if ([keyPath isEqualToString:@"memberIndex"]) {
            EngineeringTeamMembersViewModel *viewModel =
            (EngineeringTeamMembersViewModel *)object;
            NSInteger memberPosition = [viewModel.memberIndex integerValue];
            NSIndexPath *memberIndexPath = [NSIndexPath indexPathForRow:memberPosition
                                                              inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[memberIndexPath]
                                  withRowAnimation:UITableViewRowAnimationNone];
        } else if ([keyPath isEqualToString:@"membersCount"]) {
            [self.tableView reloadData];
        }
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"pushMemberViewController"]) {
        EngineeringTeamMemberCell *memberCell = (EngineeringTeamMemberCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:memberCell];
        
        MemberViewController *memberVÇ =
        (MemberViewController *)[segue destinationViewController];
        memberVÇ.member = self.viewModel.members[indexPath.row];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.members count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EngineeringTeamMemberCell *cell =
    (EngineeringTeamMemberCell *)[tableView dequeueReusableCellWithIdentifier:@"engineeringTeamMemberCellIdentifier"
                                                                 forIndexPath:indexPath];
    if (cell == nil) {
        NSArray *topLevelObjects =
        [[NSBundle mainBundle] loadNibNamed:@"EngineeringTeamMemberCell" owner:nil options:nil];
        cell = (EngineeringTeamMemberCell *)[topLevelObjects firstObject];
    }
    
    EngineeringTeamMember *member = self.viewModel.members[indexPath.row];
    cell.avatarView.image = [UIImage imageWithData:member.avatarData];
    cell.nameLabel.text = member.name;
    cell.roleLabel.text = member.role;
    cell.userLabel.text = member.user;
    
    if ([member.languages count] > 1) {
        cell.languagesTextLabel.text = [member.languages componentsJoinedByString:@", "];
    } else if ([member.languages count] == 1) {
        cell.languagesTextLabel.text = member.languages[0];
    } else {
        cell.languagesTextLabel.text = @"";
    }
    
    if ([member.skills count] > 1) {
        cell.skillTextLabel.text = [member.skills componentsJoinedByString:@", "];
    } else if ([member.skills count] == 1) {
        cell.skillTextLabel.text = member.skills[0];
    } else {
        cell.skillTextLabel.text = @"";
    }
    
    if ([member.location length] > 0) {
        cell.emojiFlagLabel.text =
        [NSLocale emojiFlagForISOCountryCode:[member.location uppercaseString]];
    } else {
        cell.emojiFlagLabel.text = @"";
    }
    
    if ([member.state length] > 0) {
        cell.stateLabel.text = member.state;
    } else {
        cell.stateLabel.text = kNotAvailableStatus;
    }
    
    return cell;
}

#pragma mark - ServiceErrorView Delegate

- (void)didRetry {
    [self showServiceError:NO];
    [self getMembers];
}

#pragma mark - Private methods

- (void)showServiceError:(BOOL)show {
    [self.serviceErrorView setHidden:!show];
    [self.tableView setScrollEnabled:!show];
}

- (void)showProgressIndicator:(BOOL)show {
    [self.progressView setHidden:!show];
    [self.tableView setScrollEnabled:!show];
}

- (void)getMembers {
    __weak typeof(self) weakSelf = self;
    [self.viewModel getMembers:^(BOOL success) {
        [weakSelf showProgressIndicator:NO];
        if (success) {
            [weakSelf.tableView reloadData];
            [weakSelf.viewModel updateUsersState];
        } else {
            [weakSelf showServiceError:YES];
        }
    }];
}

@end
