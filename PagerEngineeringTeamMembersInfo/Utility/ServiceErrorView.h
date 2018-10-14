//
//  ServiceErrorView.h
//  PagerEngineeringTeamMembersInfo
//
//  Created by Muthu, Pradesh (Contractor) on 10/9/18.
//  Copyright © 2018 Muthu, Pradesh (Contractor). All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ServiceErrorViewDelegate <NSObject>

@required
/**
 * delegate to retry the call.
 */
- (void)didRetry;

@end

@interface ServiceErrorView : UIView

@property (nonatomic, weak) IBOutlet id<ServiceErrorViewDelegate> delegate;

@end
