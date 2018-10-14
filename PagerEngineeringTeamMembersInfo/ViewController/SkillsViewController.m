//
//  SkillsViewController.m
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/12/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import "SkillsViewController.h"

@interface SkillsViewController ()

@property (strong, nonatomic) NSArray *skills;

@end

@implementation SkillsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kSkillsKey;

    self.skills = @[kObjectiveCText, kSwiftText, kJ2METext, kPythonText, kErlangText];
    
    for (NSString *skill in self.skillsSelected) {
        NSIndexPath *indexPath =
        [NSIndexPath indexPathForRow:[self.skills indexOfObject:skill]
                           inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath
                                    animated:NO
                              scrollPosition:UITableViewScrollPositionNone];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.skills count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseSkillsViewIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"reuseSkillsViewIdentifier"];
    }
    
    cell.textLabel.text = self.skills[indexPath.row];
    
    NSArray<NSIndexPath *> *selectedIndexPaths = [tableView indexPathsForSelectedRows];
    BOOL rowSelected = (selectedIndexPaths != nil
                        && [selectedIndexPaths containsObject:indexPath]);
    cell.accessoryType = rowSelected? UITableViewCellAccessoryCheckmark: UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    if (self.skillsSelected == nil) {
        self.skillsSelected = [[NSMutableArray alloc] init];
    }
    
    [self.skillsSelected addObject:self.skills[indexPath.row]];
    
    if ([self.delegate respondsToSelector:@selector(didSelectSkills:)]) {
        [self.delegate didSelectSkills:self.skillsSelected];
    }
}

- (void)tableView:(UITableView*)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    
    [self.skillsSelected removeObject:self.skills[indexPath.row]];
    
    if ([self.delegate respondsToSelector:@selector(didSelectSkills:)]) {
        [self.delegate didSelectSkills:self.skillsSelected];
    }
}

@end
