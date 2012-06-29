//
//  EditProfileViewController.m
//  PartyApp
//
//  Created by Spire Jankulovski on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditProfileViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
@interface EditProfileViewController ()

@end

@implementation EditProfileViewController
@synthesize userDataJSON;
@synthesize idString;
@synthesize jsonData;
@synthesize contentsList;
@synthesize scrollView;
@synthesize imageView;
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
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = TRUE; 
    
    if (idString) {
        NSString *urlString = [NSString stringWithFormat:@"http://spireapp.lazarevski-zoran.com/index.php?action=getUserData&id=%@",idString];
        NSURL *url = [NSURL URLWithString:urlString];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setDelegate:self];
        [request startAsynchronous];
        
    }else {
        
        self.title = @"Edit Profile";
        bioStr = [NSString stringWithFormat:[userDataJSON valueForKey:@"Bio"]];
        fNameStr = [NSString stringWithFormat:[userDataJSON valueForKey:@"firstN"]];
        lNameStr = [NSString stringWithFormat:[userDataJSON valueForKey:@"lastN"]];
        DoBStr = [NSString stringWithFormat:[userDataJSON valueForKey:@"DoB"]];
        genderStr = [NSString stringWithFormat:[userDataJSON valueForKey:@"Gender"]];
        emailStr = [NSString stringWithFormat:[userDataJSON valueForKey:@"Email"]];
        questStr = [NSString stringWithFormat:[userDataJSON valueForKey:@"Quest"]];
        answStr = [NSString stringWithFormat:[userDataJSON valueForKey:@"Answ"]];
        passString = [NSString stringWithFormat:[userDataJSON valueForKey:@"Pass"]];
        [self drawView];     
    }



    // Do any additional setup after loading the view from its nib.
}
-(void)drawView{
    scrollView.contentSize = CGSizeMake(320, 915);
	[scrollView scrollRectToVisible:CGRectMake(0, 0, 320, 416) animated:NO];
    
    NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imageString]];
    UIImage *myimage = [[UIImage alloc] initWithData:mydata];
    
    NSLog(@"%@",myimage);
    
    sampleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sampleButton setFrame:CGRectMake(10,10,150,150)];
    [sampleButton setTitle:@"Tap to add image" forState:UIControlStateNormal];
    [sampleButton setBackgroundColor:[UIColor brownColor]];
    [sampleButton addTarget:self action:@selector(displayImageGallery) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:sampleButton];
    
    bioTextView = [[UITextView alloc]initWithFrame:CGRectMake(170, 10, 150, 150)];
    [bioTextView setText:bioStr];
    [scrollView addSubview:bioTextView];
    
    nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 170.0, 300, 30)];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    nameTextField.text = fNameStr;
    [nameTextField setDelegate:self];		
    [nameTextField addTarget:self action:@selector(textFieldDone:) 
            forControlEvents:UIControlEventEditingDidEndOnExit];
    [scrollView addSubview:nameTextField];
    
    lNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 210, 300, 30)];
    lNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    lNameTextField.text = lNameStr;
    [lNameTextField setDelegate:self];		
    [lNameTextField addTarget:self action:@selector(textFieldDone:) 
            forControlEvents:UIControlEventEditingDidEndOnExit];
    [scrollView addSubview:lNameTextField];
    

    
	NSArray *DobArray = [[NSArray alloc] initWithArray:[DoBStr componentsSeparatedByString:@"-"]];

    dayTextField = [[UITextField alloc]initWithFrame:CGRectMake(10,250, 46, 30)];
    dayTextField.borderStyle = UITextBorderStyleRoundedRect;
    dayTextField.text = [DobArray objectAtIndex:2];
    [dayTextField setDelegate:self];		
    [dayTextField addTarget:self action:@selector(textFieldDone:) 
             forControlEvents:UIControlEventEditingDidEndOnExit];
    [dayTextField setTextAlignment:UITextAlignmentCenter];
    [scrollView addSubview:dayTextField];
    
    monthTextField = [[UITextField alloc]initWithFrame:CGRectMake(60, 250, 46, 30)];
    monthTextField.borderStyle = UITextBorderStyleRoundedRect;
    monthTextField.text = [DobArray objectAtIndex:1];
    [monthTextField setDelegate:self];		
    [monthTextField addTarget:self action:@selector(textFieldDone:) 
             forControlEvents:UIControlEventEditingDidEndOnExit];
    [monthTextField setTextAlignment:UITextAlignmentCenter];
    [scrollView addSubview:monthTextField];
    
    yearTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 250, 55, 30)];
    yearTextField.borderStyle = UITextBorderStyleRoundedRect;
    yearTextField.text = [DobArray objectAtIndex:0];
    [yearTextField setDelegate:self];		
    [yearTextField addTarget:self action:@selector(textFieldDone:) 
             forControlEvents:UIControlEventEditingDidEndOnExit];
    [yearTextField setTextAlignment:UITextAlignmentCenter];
    [scrollView addSubview:yearTextField];
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"M", @"F", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(175, 250, 135, 30);
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];    segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
    int i;
    if ([genderStr isEqualToString:@"M"]) {
        i=0;
    }else if([genderStr isEqualToString:@"F"]){
        i=1;
    }
    segmentedControl.selectedSegmentIndex = i;
    [scrollView addSubview:segmentedControl];
    
    emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 290, 300, 30)];
    emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    emailTextField.text = emailStr;
    [emailTextField setDelegate:self];		
    [emailTextField addTarget:self action:@selector(textFieldDone:) 
             forControlEvents:UIControlEventEditingDidEndOnExit];
    [emailTextField setTextAlignment:UITextAlignmentCenter];
    [scrollView addSubview:monthTextField];

    questionTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 330, 300, 30)];
    questionTextField.borderStyle = UITextBorderStyleRoundedRect;
    questionTextField.text = questStr;
    [questionTextField setDelegate:self];		
    [questionTextField addTarget:self action:@selector(textFieldDone:) 
                forControlEvents:UIControlEventEditingDidEndOnExit];
    [questionTextField setTextAlignment:UITextAlignmentCenter];
    [scrollView addSubview:questionTextField];
    
    answerTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 370, 300, 30)];
    answerTextField.borderStyle = UITextBorderStyleRoundedRect;
    answerTextField.text = answStr;
    [answerTextField setDelegate:self];		
    [answerTextField addTarget:self action:@selector(textFieldDone:) 
                forControlEvents:UIControlEventEditingDidEndOnExit];
    [answerTextField setTextAlignment:UITextAlignmentCenter];
    [scrollView addSubview:answerTextField];
    
    passTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 410, 300, 30)];
    passTextField.borderStyle = UITextBorderStyleRoundedRect;
    passTextField.text = passString;
    [passTextField setDelegate:self];		
    [passTextField addTarget:self action:@selector(textFieldDone:) 
              forControlEvents:UIControlEventEditingDidEndOnExit];
    [passTextField setTextAlignment:UITextAlignmentCenter];
    [scrollView addSubview:passTextField];

    passTextField2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 450, 300, 30)];
    passTextField2.borderStyle = UITextBorderStyleRoundedRect;
    passTextField2.text = passString;
    [passTextField2 setDelegate:self];		
    [passTextField2 addTarget:self action:@selector(textFieldDone:) 
            forControlEvents:UIControlEventEditingDidEndOnExit];
    [passTextField2 setTextAlignment:UITextAlignmentCenter];
    [scrollView addSubview:passTextField2];
    
    UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [updateButton setFrame:CGRectMake(80,490,150,44)];
    [updateButton setTitle:@"Update Profile" forState:UIControlStateNormal];
    [updateButton setBackgroundColor:[UIColor clearColor]];
    [updateButton addTarget:self action:@selector(sendData) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:updateButton];

}
- (void) useCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects: (NSString *) kUTTypeImage, nil];
        imagePicker.allowsEditing = NO;
        [self presentModalViewController:imagePicker animated:YES];
        newMedia = YES;
    }
}
- (void) useCameraRoll
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects: (NSString *) kUTTypeImage, nil];
        imagePicker.allowsEditing = NO;
        [self presentModalViewController:imagePicker animated:YES];
        newMedia = NO;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    [self dismissModalViewControllerAnimated:YES];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext(); 
        UIGraphicsEndImageContext();
        imageData=UIImageJPEGRepresentation(newImage, 0.5); 
        imageView.image = image;
        [sampleButton setImage:image forState:UIControlStateNormal];
        
        if (newMedia)
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
        
        UIButton *sendPhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [sendPhoto setFrame:CGRectMake(120, 530, 81, 37)];
        [sendPhoto setTitle:@"Upload" forState:UIControlStateNormal];
        [sendPhoto addTarget:self action:@selector(addImageName)  forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:sendPhoto];
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
		// Code here to support video if enabled
	}
}
-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Save failed" message: @"Failed to save image"\
                                                       delegate: nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex==0){
        [self useCameraRoll];
    }
    else{
        [self useCamera];
    } 
}
-(void)displayImageGallery{

    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Choose Image From" message:@"" delegate:self cancelButtonTitle:@"Gallery" otherButtonTitles:@"Camera", nil];
    
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0.0, 50.0);
    [myAlertView setTransform:myTransform];
    [myAlertView show];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    //set up here for response!!!
    jsonData = [parser objectWithString:responseString error:nil];
    
    NSLog(@"So vrakas? %@",jsonData);
    if (!sendReceive) {
 
        bioStr = [NSString stringWithFormat:[jsonData valueForKey:@"Bio"]];
        fNameStr = [NSString stringWithFormat:[jsonData valueForKey:@"firstN"]];
        lNameStr = [NSString stringWithFormat:[jsonData valueForKey:@"lastN"]];
        DoBStr = [NSString stringWithFormat:[jsonData valueForKey:@"DoB"]];
        genderStr = [NSString stringWithFormat:[jsonData valueForKey:@"Gender"]];
        emailStr = [NSString stringWithFormat:[jsonData valueForKey:@"Email"]];
        questStr = [NSString stringWithFormat:[jsonData valueForKey:@"Quest"]];
        answStr = [NSString stringWithFormat:[jsonData valueForKey:@"Answ"]];
        passString = [NSString stringWithFormat:[jsonData valueForKey:@"Pass"]];
        imageString = [NSString stringWithFormat:[jsonData valueForKey:@"Image"]];
        userString = [NSString stringWithFormat:[jsonData valueForKey:@"User"]];
        idUser = [NSString stringWithFormat:[jsonData valueForKey:@"id"]];
        NSLog(@"Tuka %@",userString);
        // Use when fetching binary data
        //NSData *responseData = [request responseData];
        [self drawView];     
        
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error);
}
- (void)segmentAction:(id)sender
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
-(void)sendData{
    UILabel *warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 490, 280, 30)];
    [warningLabel setHidden:YES];
    if ([passTextField.text isEqualToString:passTextField2.text]) {

        NSString *DoBString = [NSString stringWithFormat:@"%@.%@.%@",dayTextField.text,monthTextField.text,yearTextField.text];
        if (segControl == 0) {
           genderString = @"M";

        }else {
            genderString = @"F";

        }
        NSLog(@"User %@",userString);
        NSString *incomingStr = @"http://spireapp.lazarevski-zoran.com/index.php?action=saveUser";
        NSURL *url = [NSURL URLWithString:incomingStr];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:@"1" forKey:@"save_user"];
        [request setPostValue:nameTextField.text forKey:@"firstN"];
        [request setPostValue:lNameTextField.text forKey:@"lastN"];
        [request setPostValue:userString forKey:@"User"];
        [request setPostValue:passTextField.text forKey:@"Pass"];
        [request setPostValue:DoBString forKey:@"DoB"];
        [request setPostValue:genderString forKey:@"Gender"];
        [request setPostValue:emailTextField.text forKey:@"Email"];
        [request setPostValue:questionTextField.text forKey:@"Quest"];
        [request setPostValue:answerTextField.text forKey:@"Answ"];
        [request setPostValue:@"Token" forKey:@"Token"];
        [request setPostValue:bioTextView.text forKey:@"Bio"];

        [request setPostValue:idUser forKey:@"id"];
    
        [request setData:imageData withFileName:@"upload.png" andContentType:@"image/png" forKey:@"Image"];
        [request setDelegate:self];
        //[request setUploadProgressDelegate:myProgressIndicator];
        sendReceive = YES;
        [request startAsynchronous];
        
        //NSLog(@"Value: %f",[myProgressIndicator progress]);
        
    }else{
        warningLabel.text = @"Passwords don't match";
        [warningLabel setHidden:NO];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	NSLog(@"textFieldDidBeginEditing");
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	NSLog(@"textFieldDidEndEditing");
    [textField resignFirstResponder];
    //here we put submit to server updates
}
-(IBAction)textFieldDone:(id)sender{	
	NSLog(@"textFieldDone");
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
