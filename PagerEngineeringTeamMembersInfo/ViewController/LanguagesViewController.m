//
//  LanguagesViewController.m
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/12/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import "LanguagesViewController.h"

@interface LanguagesViewController ()

@property (strong, nonatomic) NSMutableArray *languages;

@end

@implementation LanguagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kLanguagesKey;
    
    NSArray *languageCodes = [NSLocale ISOLanguageCodes];
    self.languages = [[NSMutableArray alloc] initWithCapacity:[languageCodes count]];
    
    NSMutableDictionary *languageCodeMap =
    [NSMutableDictionary dictionaryWithCapacity:[languageCodes count]];

    for (NSString *code in languageCodes) {
        NSString *language =
        [[NSLocale currentLocale] localizedStringForLanguageCode:code];
        if ([language length] > 0) {
            [languageCodeMap setObject:code forKey:language];
            [self.languages addObject:language];
        }
    }
    
    if ([[languageCodeMap allKeys] count] > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:languageCodeMap
                                                  forKey:kLanguageMapKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    for (NSString *language in self.languagesSelected) {
        NSIndexPath *indexPath =
        [NSIndexPath indexPathForRow:[self.languages indexOfObject:language]
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
    return [self.languages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseLanguagesViewIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"reuseLanguagesViewIdentifier"];
    }
    
    cell.textLabel.text = self.languages[indexPath.row];
    
    NSArray<NSIndexPath *> *selectedIndexPaths = [tableView indexPathsForSelectedRows];
    BOOL rowSelected = (selectedIndexPaths != nil
                        && [selectedIndexPaths containsObject:indexPath]);
    cell.accessoryType = rowSelected? UITableViewCellAccessoryCheckmark: UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    if (self.languagesSelected == nil) {
        self.languagesSelected = [[NSMutableArray alloc] init];
    }
    
    [self.languagesSelected addObject:self.languages[indexPath.row]];

    if ([self.delegate respondsToSelector:@selector(didSelectLanguages:)]) {
        [self.delegate didSelectLanguages:self.languagesSelected];
    }
}

- (void)tableView:(UITableView*)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    
    [self.languagesSelected removeObject:self.languages[indexPath.row]];
    
    if ([self.delegate respondsToSelector:@selector(didSelectLanguages:)]) {
        [self.delegate didSelectLanguages:self.languagesSelected];
    }
}

@end
