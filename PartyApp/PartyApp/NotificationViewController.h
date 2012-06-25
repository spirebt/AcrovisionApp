//
//  NotificationViewController.h
//  PartyApp
//
//  Created by Spire Jankulovski on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LogInViewController,AppDelegate;

@interface NotificationViewController : UITableViewController
{
    LogInViewController *logInController;
    AppDelegate *appDelegate;
    NSMutableArray *jsonData;
    
}
@property (strong, nonatomic) NSMutableArray *jsonData;
@property (nonatomic, retain) NSMutableArray *contentsList;

@end