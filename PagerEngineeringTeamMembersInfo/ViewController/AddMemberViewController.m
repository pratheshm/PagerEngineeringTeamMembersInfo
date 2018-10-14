//
//  AddMemberViewController.m
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/11/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import "AddMemberViewController.h"
#import "RoleViewController.h"
#import "GenderViewController.h"
#import "LanguagesViewController.h"
#import "SkillsViewController.h"
#import "LocationViewController.h"
#import "ServiceErrorView.h"
#import "ProgressView.h"
#import "AddMemberViewModel.h"

static int const kNewMemberInfoOptionsCount = 5;

typedef enum : NSUInteger {
    Role = 0,
    Gender = 1,
    Languages = 2,
    Skills = 3,
    Location = 4
} MemberInfoType;

@interface AddMemberViewController () <
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate,
RoleViewControllerDelegate,
GenderViewControllerDelegate,
LanguagesViewControllerDelegate,
SkillsViewControllerDelegate,
LocationViewControllerDelegate,
ServiceErrorViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userTextField;

@property (strong, nonatomic) AddMemberViewModel *viewModel;

@property (nonatomic, strong) ServiceErrorView *serviceErrorView;
@property (nonatomic, strong) ProgressView *progressView;

/**
 *  Event for tap add member button
 *
 *  @param sender - add member button
 *
 */
- (IBAction)didPressAddMember:(id)sender;
/**
 *  Update name and user fields
 */
- (void)updateNameAndUser;

@end

@implementation AddMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationItem.title = kAddMemberScreenTitle;
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self
                                                  action:@selector(didPressAddMember:)];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    self.viewModel = [[AddMemberViewModel alloc] init];
    
    self.serviceErrorView = [[ServiceErrorView alloc] initWithFrame:self.view.frame];
    self.serviceErrorView.delegate = self;
    [self.view addSubview:self.serviceErrorView];
    [self.serviceErrorView setHidden:YES];
    
    self.progressView = [[ProgressView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.progressView];
    [self.progressView setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self updateNameAndUser];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kNewMemberInfoOptionsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"memberInfoCellIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"memberInfoCellIdentifier"];
    }
    
    if (indexPath.row == Role) {
        cell.textLabel.text = kRoleKey;
        cell.detailTextLabel.text = self.viewModel.addTeamMember.role;
    } else if (indexPath.row == Gender) {
        cell.textLabel.text = kGenderKey;
        cell.detailTextLabel.text = self.viewModel.addTeamMember.gender;
    } else if (indexPath.row == Languages) {
        cell.textLabel.text = kLanguagesKey;
        cell.detailTextLabel.text =
        [self.viewModel.addTeamMember.languages componentsJoinedByString:@", "];
    } else if (indexPath.row == Skills) {
        cell.textLabel.text = kSkillsKey;
        cell.detailTextLabel.text =
        [self.viewModel.addTeamMember.skills componentsJoinedByString:@", "];
    } else if (indexPath.row == Location) {
        cell.textLabel.text = kLocationKey;
        cell.detailTextLabel.text = self.viewModel.addTeamMember.location;
    }
    
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    if (indexPath.row == Role) {
        [self performSegueWithIdentifier:kPushRoleViewController
                                  sender:self.viewModel.addTeamMember.role];
    } else if (indexPath.row == Gender) {
        [self performSegueWithIdentifier:kPushGenderViewController
                                  sender:self.viewModel.addTeamMember.gender];
    } else if (indexPath.row == Languages) {
        [self performSegueWithIdentifier:kPushLanguagesViewController
                                  sender:self.viewModel.addTeamMember.languages];
    } else if (indexPath.row == Skills) {
        [self performSegueWithIdentifier:kPushSkillsViewController
                                  sender:self.viewModel.addTeamMember.skills];
    } else if (indexPath.row == Location) {
        [self performSegueWithIdentifier:kPushLocationViewController
                                  sender:self.viewModel.addTeamMember.location];
    }
}

#pragma mark - UITextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 0) {
        self.viewModel.addTeamMember.name = textField.text;
    } else if (textField.tag == 1) {
        self.viewModel.addTeamMember.user = textField.text;
    }
}

#pragma mark - RoleViewController Delegate

- (void)didSelectRole:(NSString *)role {
    self.viewModel.addTeamMember.role = role;
}

#pragma mark - GenderViewController Delegate

- (void)didSelectGender:(NSString *)gender {
    self.viewModel.addTeamMember.gender = gender;
}

#pragma mark - LanguagesViewController Delegate

- (void)didSelectLanguages:(NSArray *)languages {
    self.viewModel.addTeamMember.languages = languages;
}

#pragma mark - SkillsViewController Delegate

- (void)didSelectSkills:(NSArray *)skills {
    self.viewModel.addTeamMember.skills = skills;
}

#pragma mark - LocationViewController Delegate

- (void)didSelectLocation:(NSString *)location {
    self.viewModel.addTeamMember.location = location;
}

#pragma mark - ServiceErrorView Delegate

- (void)didRetry {
    [self.serviceErrorView setHidden:YES];
    [self didPressAddMember:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:kPushRoleViewController]) {
        RoleViewController *roleVC =
        (RoleViewController *)[segue destinationViewController];
        roleVC.delegate = self;
        roleVC.roleSelected = sender;
    } else if ([[segue identifier] isEqualToString:kPushGenderViewController]) {
        GenderViewController *genderVC =
        (GenderViewController *)[segue destinationViewController];
        genderVC.delegate = self;
        genderVC.genderSelected = sender;
    } else if ([[segue identifier] isEqualToString:kPushLanguagesViewController]) {
        LanguagesViewController *languagesVC =
        (LanguagesViewController *)[segue destinationViewController];
        languagesVC.delegate = self;
        languagesVC.languagesSelected = [sender mutableCopy];
    } else if ([[segue identifier] isEqualToString:kPushSkillsViewController]) {
        SkillsViewController *skillsVC =
        (SkillsViewController *)[segue destinationViewController];
        skillsVC.delegate = self;
        skillsVC.skillsSelected = [sender mutableCopy];
    } else if ([[segue identifier] isEqualToString:kPushLocationViewController]) {
        LocationViewController *locationVC =
        (LocationViewController *)[segue destinationViewController];
        locationVC.delegate = self;
        locationVC.locationSelected = sender;
    }
}

#pragma mark - Events

- (IBAction)didPressAddMember:(id)sender {
    if ([self.viewModel isMemberValid]) {
        __weak typeof(self) weakSelf = self;
        [self.viewModel addMember:^(BOOL success) {
            [weakSelf.progressView setHidden:YES];
            if (success) {
                [weakSelf.viewModel.addTeamMember clearData];
                [weakSelf updateNameAndUser];
                [weakSelf.tableView reloadData];
            } else {
                [weakSelf.serviceErrorView setHidden:NO];
            }
        }];
    } else {
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:kInfoAlertTitle
                                            message:kAllFieldsRequired
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel =
        [UIAlertAction actionWithTitle:kCancelButtonText
                                 style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction * action) {
                                   [alertController dismissViewControllerAnimated:YES
                                                                       completion:nil];
                               }];
        [alertController addAction:cancel];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - Private Methods

- (void)updateNameAndUser {
    self.nameTextField.text = self.viewModel.addTeamMember.name;
    self.userTextField.text = self.viewModel.addTeamMember.user;
}

@end
