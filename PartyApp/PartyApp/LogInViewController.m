//
//  LogInViewController.m
//  PartyApp
//
//  Created by Spire Jankulovski on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    NSLog(@"LogInViewController");
    
    

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)tryToLogIn{
    NSLog(@"LogInViewController - pressed Button");

    [appDelegate loginDone];

    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
