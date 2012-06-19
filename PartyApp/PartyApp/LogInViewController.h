//
//  LogInViewController.h
//  PartyApp
//
//  Created by Spire Jankulovski on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SignInViewController.h"
#import "ForgotPassViewController.h"
#import "SBJson.h"
@interface LogInViewController : UIViewController <UITextFieldDelegate>

{
    AppDelegate *appDelegate;
    SignInViewController *signIn;
    ForgotPassViewController *recoverPass;
    IBOutlet UIButton *loginButton;    
    SBJsonParser *parser;
}
@property (strong, nonatomic) NSMutableArray *jsonData;
@property (nonatomic, retain) IBOutlet UILabel *logInAlertLabel;
@property (nonatomic, retain) IBOutlet UITextField *user;
@property (nonatomic, retain) IBOutlet UITextField *pass;
-(IBAction)sendPost;
-(IBAction)signInView;
-(IBAction)recoverPass;
@end
