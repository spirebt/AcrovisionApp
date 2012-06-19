//
//  SignInViewController.m
//  PartyApp
//
//  Created by Spire Jankulovski on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SignInViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "SBJson.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
@interface SignInViewController ()


@end

@implementation SignInViewController
@synthesize segmentedControl;
@synthesize scrollView;
@synthesize firstN;
@synthesize lastN;
@synthesize user;
@synthesize pass;
@synthesize repeatPass;
@synthesize dobDay;
@synthesize dobMonth;
@synthesize dobYear;
@synthesize gender;
@synthesize email;
@synthesize question;
@synthesize answer;
@synthesize bio;
@synthesize alertLabel;
@synthesize segControl;
@synthesize mainAlertLabel;
@synthesize dataString;
@synthesize convertToStringData;
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

    [alertLabel setHidden:YES];
    [mainAlertLabel setHidden:YES];
    segControl = 0;

    // Do any additional setup after loading the view from its nib.
}


-(IBAction)signIn{
    NSString *DobDay = dobDay.text;
    NSString *DobMonth = dobMonth.text;
    NSString *DobYear = dobYear.text;
    NSString *genderSelected = @"M";
    BOOL isOK = YES;

    if ([DobDay intValue]>=32 || [DobDay intValue]<=0) {
        [alertLabel setText:@""];
        [alertLabel setHidden:NO];
        alertLabel.text = @"You cant be born on this day!";
        isOK = NO;
    }    
    if (([DobMonth intValue]==4) || ([DobMonth intValue]==6) || ([DobMonth intValue]==8) || ([DobMonth intValue]==10)|| ([DobMonth intValue]==12)) {
            if ([DobDay intValue]>30) {
                [alertLabel setText:@""];
                [alertLabel setHidden:NO];
                alertLabel.text = @"There are 30 days";
                isOK = NO;
                    
            }else if([DobMonth intValue]==2 && [DobDay intValue]>29){
                [alertLabel setText:@""];
                [alertLabel setHidden:NO];
                alertLabel.text = @"There are less than 29 days";
                isOK = NO;
            }        
        }
        
    if ([DobMonth intValue]>=13 || [DobMonth intValue]<=0) {
        [alertLabel setText:@""];
        [alertLabel setHidden:NO];
        alertLabel.text = @"There are 12 months, use a number";
        isOK = NO;

    }
    

    if (segControl == 0) {
        genderSelected = @"M";
    }else {
        genderSelected = @"F";
    }
    if (![pass.text isEqualToString:repeatPass.text]) {
        isOK = NO;
        [mainAlertLabel setText:@""];
        [mainAlertLabel setHidden:NO];
        mainAlertLabel.text = @"Passwords don't match";

    }
   

    if ([firstN.text isEqualToString:@""]||[lastN.text isEqualToString:@""]||[user.text isEqualToString:@""]||[pass.text isEqualToString:@""]||[DobDay isEqualToString:@""]||[DobMonth isEqualToString:@""]||[DobYear isEqualToString:@""]||[email.text isEqualToString:@""]||[question.text isEqualToString:@""]||[answer.text isEqualToString:@""]) {
        isOK = NO;
        [mainAlertLabel setText:@""];
        [mainAlertLabel setHidden:NO];
        mainAlertLabel.text = @"All fields are required";
    }
   

    //check if pass is same in both fields!
    if (isOK == YES) {
        
       /* UIImage *im = [info objectForKey:@"UIImagePickerControllerOriginalImage"] ;
        UIGraphicsBeginImageContext(CGSizeMake(320,480)); 
        [im drawInRect:CGRectMake(0, 0,320,480)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        NSData* imageData=UIImageJPEGRepresentation(newImage, 0.5); 
        */
        [alertLabel setHidden:YES];
        [mainAlertLabel setHidden:YES];

        [self sendPost:@"http://spireapp.lazarevski-zoran.com/index.php?action=saveUser" gender:genderSelected];
    }

    //NSString *soapFormat = [NSString stringWithFormat:@"action=saveUser&save_user=1&firstN=First_name_here&lastN=Last_name&User=Username_here&Pass=Password_here&DoB=23.07.2012&Gender=M&Email=spire.bt@gmail.com&Quest=Question_here&Answ=Answer_here&Token=Token_here&Image=Image_here&Bio=&id=0"];

}
//-(void)sendPost: (NSString *)incomingStr uploadImage:(NSData *)imageData otherStuff:(NSDictionary*)dictionaryData {
-(void)sendPost:(NSString *)incomingStr gender:(NSString*)genderData {
    
    NSString *DoBString = [NSString stringWithFormat:@"%@.%@.%@",dobDay.text,dobMonth.text,dobYear.text];
    NSURL *url = [NSURL URLWithString:incomingStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];

    [request setPostValue:@"1" forKey:@"save_user"];
    [request setPostValue:firstN.text forKey:@"firstN"];
    [request setPostValue:lastN.text forKey:@"lastN"];
    [request setPostValue:user.text forKey:@"User"];
    [request setPostValue:pass.text forKey:@"Pass"];
    [request setPostValue:DoBString forKey:@"DoB"];
    [request setPostValue:genderData forKey:@"Gender"];
    [request setPostValue:email.text forKey:@"Email"];
    [request setPostValue:question.text forKey:@"Quest"];
    [request setPostValue:answer.text forKey:@"Answ"];
    [request setPostValue:@"Token" forKey:@"Token"];
    [request setPostValue:@"" forKey:@"Bio"];
    [request setPostValue:@"" forKey:@"Image"];
    [request setPostValue:@"0" forKey:@"id"];

    //[request setFile:@"/Users/spire/Desktop/sign-nobaby.png" forKey:@"Image"];
    [request setDelegate:self];
    //[request setUploadProgressDelegate:myProgressIndicator];
    [request startAsynchronous];
    //NSLog(@"Value: %f",[myProgressIndicator progress]);

}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];

    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    jsonData = [parser objectWithString:responseString error:nil];
    NSLog(@"%@",jsonData);
    if ([jsonData count]!=0) {
        NSArray *userDetails = (NSArray *)[jsonData valueForKey:@"user"]; 
        NSString *errorInfo = (NSString *)[jsonData valueForKey:@"error"];
        NSString *successInfo = (NSString *)[jsonData valueForKey:@"success"];
    
        if ([errorInfo intValue] == 1) {
            mainAlertLabel.text = @"Username already exist";
        
        }else if ([errorInfo intValue] == 2) {
            mainAlertLabel.text = @"This emai has already been used";
        
        }else if ([errorInfo intValue] == 4) {
            mainAlertLabel.text = @"This user can't be created - please contact our support";
        
        }else if(([errorInfo intValue] == 0) && ([successInfo intValue]==1)){
            //[self dismissModalViewControllerAnimated:YES];
            NSLog(@"we won");

        }
    }else{
        NSLog(@"No JSON value");
    }
    // Use when fetching binary data
   // NSData *responseData = [request responseData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error);
}   

//NSURLConnection delegate method

- (IBAction)segmentAction:(id)sender
{
    segmentedControl = (UISegmentedControl *)sender;
    switch ([sender selectedSegmentIndex])
    {
        case 0: 
        {   
            segControl = 0;
            break;
        }
        case 1: 
        {   
            segControl = 1;
            break;
        }
    }


}
- (void)viewDidUnload
{
    [self setScrollView:nil];

    
    [self setFirstN:nil];
    [self setLastN:nil];
    [self setUser:nil];
    [self setPass:nil];
    [self setRepeatPass:nil];
    [self setDobDay:nil];
    [self setDobMonth:nil];
    [self setDobYear:nil];
    [self setGender:nil];
    [self setEmail:nil];
    [self setQuestion:nil];
    [self setAnswer:nil];
    [self setBio:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == firstN) {
        [firstN becomeFirstResponder];
    }
    
    else if (textField == lastN) {
        [lastN becomeFirstResponder];
    }
    
    else if (textField == user) {
        [user becomeFirstResponder];
    }
    
    else if (textField == pass) {
        [pass becomeFirstResponder];
    }
    
    else if (textField == repeatPass) {
        [repeatPass becomeFirstResponder];
    }
    
    
    else if (textField == dobDay) {
        [dobDay becomeFirstResponder];
    }
    
    else if (textField == dobMonth) {
        [dobMonth becomeFirstResponder];
    }
    
    else if (textField == dobYear) {
        [dobYear becomeFirstResponder];
    }
    
    else if (textField == gender) {
        [gender becomeFirstResponder];
    }
    
    else if (textField == email) {
        [email becomeFirstResponder];
    }
    
    else if (textField == question) {
        [question becomeFirstResponder];
    }
    
    else if (textField == answer) {
        [answer becomeFirstResponder];
    }
    
    else if (textField == bio) {
        [bio becomeFirstResponder];
    }
    
    else{
        [textField resignFirstResponder];
    }    
    
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [scrollView adjustOffsetToIdealIfNeeded];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
