//
//  LogInViewController.h
//  PartyApp
//
//  Created by Spire Jankulovski on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface LogInViewController : UIViewController
{
    AppDelegate *appDelegate;
    IBOutlet UIButton *loginButton;
}
-(IBAction)tryToLogIn;
@end
