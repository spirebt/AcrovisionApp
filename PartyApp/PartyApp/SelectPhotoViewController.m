//
//  SelectPhotoViewController.m
//  PartyApp
//
//  Created by Spire Jankulovski on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectPhotoViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
@interface SelectPhotoViewController ()

@end

@implementation SelectPhotoViewController
@synthesize imageView;
@synthesize jsonData;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
        if (newMedia)
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
        
        UIButton *sendPhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [sendPhoto setFrame:CGRectMake(120, 320, 81, 37)];
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
-(void)addImageName{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Your title here!" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    [myTextField setBackgroundColor:[UIColor whiteColor]];
    [myAlertView addSubview:myTextField];
    
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0.0, 50.0);
    [myAlertView setTransform:myTransform];
    [myAlertView show];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *nameString = [NSString stringWithFormat:@"%@",myTextField.text];
    if(buttonIndex==0){
        NSLog(@"%d",buttonIndex);
    }
    else{
        [self sendData:nameString];
    } 
}
-(void)sendData:(NSString *)imageName{
    NSLog(@"image %@",imageName);

    NSLog(@"%@",imageData);

    NSURL *url = [NSURL URLWithString:@""];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    [request setData:imageData withFileName:@"myphoto.jpg" andContentType:@"image/jpeg" forKey:@"image"];
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
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error);
}   

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Upload Picture"];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    self.imageView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
