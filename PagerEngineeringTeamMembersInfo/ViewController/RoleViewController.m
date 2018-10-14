//
//  RoleViewController.m
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/12/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import "RoleViewController.h"

@interface RoleViewController ()

@property (strong, nonatomic) NSDictionary *roleMap;
@property (strong, nonatomic) NSArray *roles;

@end

@implementation RoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kRoleKey;
    
    self.roleMap =
    [[NSUserDefaults standardUserDefaults] dictionaryForKey:kRoleMapKey];
    self.roles = [self.roleMap allValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.roles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseRoleViewIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseRoleViewIdentifier"];
    }
    
    cell.textLabel.text = self.roles[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    self.roleSelected = self.roles[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(didSelectRole:)]) {
        [self.delegate didSelectRole:self.roleSelected];
    }
}

- (void)tableView:(UITableView*)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.roleSelected length] > 0
        && [self.roles[indexPath.row] isEqualToString:self.roleSelected]) {
        [self.tableView selectRowAtIndexPath:indexPath
                                    animated:NO
                              scrollPosition:UITableViewScrollPositionNone];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
