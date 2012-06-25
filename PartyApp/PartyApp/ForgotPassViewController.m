//
//  SignInViewController.m
//  PartyApp
//
//  Created by Spire Jankulovski on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ForgotPassViewController.h"
#import "SBJson.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "EditProfileViewController.h"
@interface ForgotPassViewController ()


@end

@implementation ForgotPassViewController

@synthesize forgotPassJson;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
        
        /*----------------------------------------*/
        questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 25)];
        questionLabel.backgroundColor = [UIColor clearColor]; // [UIColor brownColor];
        questionLabel.textColor = [UIColor blackColor];
        questionLabel.font = [UIFont fontWithName:@"Arial" size: 14.0];
        questionLabel.shadowColor = [UIColor grayColor];
        questionLabel.shadowOffset = CGSizeMake(1,1);
        questionLabel.textColor = [UIColor redColor];
        questionLabel.textAlignment = UITextAlignmentCenter; // UITextAlignmentCenter, UITextAlignmentLeft
      
        answer = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 280, 25)];
        answer.borderStyle = UITextBorderStyleRoundedRect;
        answer.textColor = [UIColor blackColor]; //text color
        answer.font = [UIFont systemFontOfSize:15.0];  //font size
        answer.placeholder = @"Your answer";  //place holder
        answer.backgroundColor = [UIColor whiteColor]; //background color
        answer.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        answer.keyboardType = UIKeyboardTypeDefault;  // type of the keyboard
        answer.returnKeyType = UIReturnKeyDone;  // type of the return key
        answer.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right

        submitAnswer = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [submitAnswer addTarget:self action:@selector(checkAnswer)  forControlEvents:UIControlEventTouchDown];
        [submitAnswer setTitle:@"SubmitAnswer" forState:UIControlStateNormal];
        submitAnswer.frame = CGRectMake(40.0, 95, 240.0, 40.0);
        /*----------------------------------------*/
        
        infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 280, 30)];
        infoLabel.text = @"Write Your username and submit it";
        infoLabel.backgroundColor = [UIColor clearColor]; // [UIColor brownColor];
        infoLabel.font = [UIFont fontWithName:@"Arial" size: 14.0];
        infoLabel.shadowColor = [UIColor blackColor];
        infoLabel.shadowOffset = CGSizeMake(1,1);
        infoLabel.textColor = [UIColor blueColor];
        infoLabel.textAlignment = UITextAlignmentCenter; // UITextAlignmentCenter, UITextAlignmentLeft
        [self.view addSubview:infoLabel];
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [answer setHidden:YES];
    [submitAnswer setHidden:YES];
    [questionLabel setHidden:YES];
    [userName setHidden:NO];
    [submitUser setHidden:NO];
    infoLabel.text = @"";
    
        
    // Do any additional setup after loading the view from its nib.
       // Do any additional setup after loading the view from its nib.
}

//-(void)sendPost: (NSString *)incomingStr uploadImage:(NSData *)imageData otherStuff:(NSDictionary*)dictionaryData {
-(void)sendPost {
    
    NSString *userString = [NSString stringWithFormat:@"%@",userName.text];
    NSLog(@"%@",userString);
    NSURL *requestUrl = [NSURL URLWithString:@"http://spireapp.lazarevski-zoran.com/index.php?action=getQuestion"];

    ASIFormDataRequest *formatRequest = [ASIFormDataRequest requestWithURL:requestUrl];
    [formatRequest setPostValue:@"1" forKey:@"get_question"];
    [formatRequest setPostValue:userString forKey:@"User"];
    [formatRequest setDelegate:self];
    [formatRequest startAsynchronous];
   
    //[request setUploadProgressDelegate:myProgressIndicator];
    //NSLog(@"Value: %f",[myProgressIndicator progress]);
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    forgotPassJson = [parser objectWithString:responseString error:nil];
    
    
    NSString *questionString = (NSString *)[forgotPassJson valueForKey:@"question"];
    
    [userName setHidden:YES];
    [submitUser setHidden:YES];
    infoLabel.text = @"";
    
    if ([forgotPassJson count]!=0) {
        questionLabel.text = questionString;
        [self.view addSubview:answer];
        [self.view addSubview:submitAnswer];
        [self.view addSubview:questionLabel];

        NSLog(@"JSON %@",forgotPassJson);
        [answer setHidden:NO];
        [submitAnswer setHidden:NO];
        [questionLabel setHidden:NO];
        
        
        //change button     

        
    }else{
        [infoLabel setHidden:NO];
        
        [infoLabel setText:@"You have a connection problem, try again later"];
        
        NSLog(@"No JSON value");
    }
    // Use when fetching binary data
    // NSData *responseData = [request responseData];
}
-(void)checkAnswer{

    NSString *answerString = (NSString *)[forgotPassJson valueForKey:@"answer"];
    NSString *answerTextIntoStr = [NSString stringWithFormat:@"%@",answer.text];
    NSString *idString = [NSString stringWithFormat:@"%@",[forgotPassJson valueForKey:@"id"]];
        
        if ([answerTextIntoStr isEqualToString:answerString]) {

            EditProfileViewController *editProf = [[EditProfileViewController alloc]initWithNibName:@"EditProfileViewController" bundle:nil];
            [editProf setTitle:@"Edit Profile"];
            editProf.idString = idString;
            [self.navigationController pushViewController:editProf animated:YES];
        }else {
            [infoLabel setHidden:NO];
            [infoLabel setText:@"Wrong answer, you have limited number of tries"];
        }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error);
}   

//NSURLConnection delegate method
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
