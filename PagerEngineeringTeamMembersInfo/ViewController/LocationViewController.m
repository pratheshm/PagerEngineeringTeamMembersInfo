//
//  LocationViewController.m
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/12/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@property (strong, nonatomic) NSDictionary *locationMap;
@property (strong, nonatomic) NSMutableArray *locations;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kLocationKey;
    
    NSArray *locationCodes = [NSLocale ISOCountryCodes];
    self.locations = [[NSMutableArray alloc] initWithCapacity:[locationCodes count]];
    
    NSMutableDictionary *locationCodeMap =
    [NSMutableDictionary dictionaryWithCapacity:[locationCodes count]];
    
    for (NSString *code in locationCodes) {
        NSString *location =
        [[NSLocale currentLocale] localizedStringForCountryCode:code];
        if ([location length] > 0) {
            [locationCodeMap setObject:code forKey:location];
            [self.locations addObject:location];
        }
    }
    
    if ([[locationCodeMap allKeys] count] > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:locationCodeMap
                                                  forKey:kLocationMapKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
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
    return [self.locations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseLocationViewIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseLocationViewIdentifier"];
    }
    
    cell.textLabel.text = self.locations[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    self.locationSelected = self.locations[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(didSelectLocation:)]) {
        [self.delegate didSelectLocation:self.locationSelected];
    }
}

- (void)tableView:(UITableView*)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.locationSelected length] > 0
        && [self.locations[indexPath.row] isEqualToString:self.locationSelected]) {
        [self.tableView selectRowAtIndexPath:indexPath
                                    animated:NO
                              scrollPosition:UITableViewScrollPositionNone];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
