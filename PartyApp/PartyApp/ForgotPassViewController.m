//
//  ForgotPassViewController.m
//  PartyApp
//
//  Created by Spire Jankulovski on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ForgotPassViewController.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "EditProfileViewController.h"
@interface ForgotPassViewController ()

@end

@implementation ForgotPassViewController
@synthesize jsonData;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [answer setHidden:YES];
    [submitAnswer setHidden:YES];
    infoLabel.text = @"";

    userName = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 280, 25)];
    userName.borderStyle = UITextBorderStyleRoundedRect;
    userName.textColor = [UIColor blackColor]; //text color
    userName.font = [UIFont systemFontOfSize:15.0];  //font size
    userName.placeholder = @"Enter username or email";  //place holder
    userName.backgroundColor = [UIColor whiteColor]; //background color
    userName.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
    
    userName.keyboardType = UIKeyboardTypeDefault;  // type of the keyboard
    userName.returnKeyType = UIReturnKeyDone;  // type of the return key
    
    userName.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
    [userName setHidden:NO];
    [self.view addSubview:userName];

  
    
    submitUser = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [submitUser addTarget:self action:@selector(sendPost)  forControlEvents:UIControlEventTouchDown];
    [submitUser setTitle:@"Submit" forState:UIControlStateNormal];
    submitUser.frame = CGRectMake(40.0, 45.0, 240.0, 40.0);
    [submitUser setHidden:NO];
    [self.view addSubview:submitUser];

    
    infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 280, 30)];
    infoLabel.text = @"Write Your username and submit it";
    [self.view addSubview:infoLabel];
    infoLabel.backgroundColor = [UIColor clearColor]; // [UIColor brownColor];
	infoLabel.font = [UIFont fontWithName:@"Arial" size: 14.0];
    infoLabel.shadowColor = [UIColor blackColor];
	infoLabel.shadowOffset = CGSizeMake(1,1);
	infoLabel.textColor = [UIColor blueColor];
	infoLabel.textAlignment = UITextAlignmentCenter; // UITextAlignmentCenter, UITextAlignmentLeft
    

    // Do any additional setup after loading the view from its nib.
}

-(void)sendPost {
    
   // NSString *userString = [NSString stringWithFormat:@"http://spireapp.lazarevski-zoran.com/index.php?action=getUserData&user=%@",userName.text];
     NSString *userString = [NSString stringWithFormat:@"http://spireapp.lazarevski-zoran.com/index.php?action=getUserData&user=1"];
    NSLog(@"%@",userString);
    NSURL *requestUrl = [NSURL URLWithString:userString];
    
     ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:requestUrl];
    [request setDelegate:self];
    [request setRequestMethod:@"GET"];
    [request startAsynchronous];

    //[request setUploadProgressDelegate:myProgressIndicator];
    //NSLog(@"Value: %f",[myProgressIndicator progress]);
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    jsonData = [parser objectWithString:responseString error:nil];

    
    NSString *questionString = (NSString *)[jsonData valueForKey:@"Quest"];
    
    [userName setHidden:YES];
    [submitUser setHidden:YES];
    infoLabel.text = @"";

    if ([jsonData count]!=0) {
        questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 25)];
        questionLabel.text = questionString;
        questionLabel.backgroundColor = [UIColor clearColor]; // [UIColor brownColor];
        questionLabel.font = [UIFont fontWithName:@"Arial" size: 14.0];
        questionLabel.shadowColor = [UIColor grayColor];
        questionLabel.shadowOffset = CGSizeMake(1,1);
        questionLabel.textColor = [UIColor redColor];
        questionLabel.textAlignment = UITextAlignmentCenter; // UITextAlignmentCenter, UITextAlignmentLeft
        [questionLabel setHidden:NO];
        [self.view addSubview:questionLabel];
        NSLog(@"JSON %@",jsonData);
        
        
        answer = [[UITextField alloc] initWithFrame:CGRectMake(20, 55, 280, 20)];
        answer.borderStyle = UITextBorderStyleRoundedRect;
        answer.textColor = [UIColor blackColor]; //text color
        answer.font = [UIFont systemFontOfSize:15.0];  //font size
        answer.placeholder = @"Your answer";  //place holder
        answer.backgroundColor = [UIColor whiteColor]; //background color
        answer.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        
        answer.keyboardType = UIKeyboardTypeDefault;  // type of the keyboard
        answer.returnKeyType = UIReturnKeyDone;  // type of the return key
        
        answer.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
        [answer setHidden:NO];
        [self.view addSubview:userName];
        
        
   //change button     
        submitAnswer = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [submitAnswer addTarget:self action:@selector(sendPost)  forControlEvents:UIControlEventTouchDown];
        [submitAnswer setTitle:@"Submit" forState:UIControlStateNormal];
        submitAnswer.frame = CGRectMake(40.0, 85, 240.0, 40.0);
        [submitAnswer setHidden:NO];
        
        [self.view addSubview:submitAnswer];

    }else{
        [infoLabel setHidden:NO];
        
        [infoLabel setText:@"You have a connection problem, try again later"];

        NSLog(@"No JSON value");
    }
       // Use when fetching binary data
    // NSData *responseData = [request responseData];
}
-(void)checkAnswer{

    NSString *answerString = (NSString *)[jsonData valueForKey:@"Answ"];
    NSString *answerTextIntoStr = [NSString stringWithFormat:@"%@",answer.text];

    
    if ([jsonData count]!=0) {

        if ([answerTextIntoStr isEqualToString:answerString]) {
            EditProfileViewController *editProf = [[EditProfileViewController alloc]initWithNibName:@"EditProfileViewController" bundle:nil];
            [editProf setTitle:@"Edit Profile"];
            [self.navigationController pushViewController:editProf animated:YES];
        }else {
            [infoLabel setHidden:NO];
            [infoLabel setText:@"Wrong answer, you have limited number of tries"];
        }
    }else{
        [infoLabel setHidden:NO];

        [infoLabel setText:@"You have a connection problem, try again later"];

    }

}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error);
}   
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == answer) {
        [answer becomeFirstResponder];
    }
    
    else if (textField == userName) {
        [userName becomeFirstResponder];
    } 
    
    else{
        [textField resignFirstResponder];
    }    
    
    
    return YES;
}
-(IBAction)resignKeyboard{
    [self resignFirstResponder];
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
