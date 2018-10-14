//
//  ServiceErrorView.m
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/9/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import "ServiceErrorView.h"

@implementation ServiceErrorView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadViewFromNib];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadViewFromNib];
    }
    return self;
}

- (void)loadViewFromNib {
    UIView *contentView =
    [[[NSBundle mainBundle] loadNibNamed:kServiceErrorViewNibName
                                   owner:self
                                 options:nil] firstObject];
    contentView.frame = self.bounds;
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:contentView];
}

/**
 *  Action for retry
 *
 *  @param sender - retry button
 *
 */
- (IBAction)didTapRetryButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didRetry)]) {
        [self.delegate didRetry];
    }
}

@end
