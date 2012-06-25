//
//  LogInViewController.m
//  PartyApp
//
//  Created by Spire Jankulovski on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LogInViewController.h"
#import "ASIFormDataRequest.h"
@interface LogInViewController ()

@end

@implementation LogInViewController
@synthesize user;
@synthesize pass;
@synthesize jsonData;
@synthesize logInAlertLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Log In", @"Log In");

    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    parser = [[SBJsonParser alloc] init];

    [logInAlertLabel setHidden:YES];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)sendPost{

    NSURL *url = [NSURL URLWithString:@"http://spireapp.lazarevski-zoran.com/index.php?action=login"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setPostValue:@"1" forKey:@"login"];
    [request setPostValue:user.text forKey:@"User"];
    [request setPostValue:pass.text forKey:@"Pass"];
    
    //[request setFile:@"/Users/spire/Desktop/sign-nobaby.png" forKey:@"Image"];
    [request setDelegate:self];
    //[request setUploadProgressDelegate:myProgressIndicator];
    [request startAsynchronous];
    //NSLog(@"Value: %f",[myProgressIndicator progress]);
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [logInAlertLabel setHidden:NO];
    [logInAlertLabel setText:@""];
        // Use when fetching text data
        NSString *responseString = [request responseString];
        
        jsonData = [parser objectWithString:responseString error:nil];
        
        NSString *errorInfo = (NSString *)[jsonData valueForKey:@"error"];
        NSString *successInfo = (NSString *)[jsonData valueForKey:@"success"];
        NSString *attempts = (NSString *)[jsonData valueForKey:@"attempts"];
    NSLog(@"JSIN %@",jsonData);
    if ([attempts intValue]<3) {
        if ([errorInfo intValue] == 1) {
            logInAlertLabel.text = @"Connection problems, please try later";
            
        }else if ([errorInfo intValue] == 2) {
            logInAlertLabel.text = @"Your username is locked in, contact support";
            
            //lead user to unlock page with question and answer
            
        }else if ([errorInfo intValue] == 3) {
            logInAlertLabel.text = @"Username and password don't match";
            
        }else if ([errorInfo intValue] == 7) {
            if ([user.text length] == 0) {
                logInAlertLabel.text = @"Please provide user and password";

            }else {
                logInAlertLabel.text = @"Username does not exist";

            }
            
        }else if(([errorInfo intValue] == 0) && ([successInfo intValue]==1)){
            //[self dismissModalViewControllerAnimated:YES];
                //[appDelegate loginDone];
                [appDelegate.tabBarController dismissModalViewControllerAnimated:YES];
        }
    }else if ([attempts intValue] >3){
        NSLog(@"proba 3 pati");
        [self recoverPass];
    }
        // Use when fetching binary data
        // NSData *responseData = [request responseData];
}

//NSURLConnection delegate method

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error);
}  
-(IBAction)signInView{
    
    signIn = [[SignInViewController alloc]initWithNibName:@"SignInViewController" bundle:nil];
    signIn.title = @"Sign In"; 
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:signIn animated:YES];
}
-(IBAction)recoverPass{
    
    recoverPass = [[ForgotPassViewController alloc]initWithNibName:@"ForgotPassViewController" bundle:nil];
    recoverPass.title = @"Recover Pass"; 
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:recoverPass animated:YES];
}
- (void)viewDidUnload
{
    [self setPass:nil];
    [self setUser:nil];
    [self setLogInAlertLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
