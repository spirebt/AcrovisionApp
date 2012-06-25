//
//  EditProfileViewController.h
//  PartyApp
//
//  Created by Spire Jankulovski on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface EditProfileViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIAlertViewDelegate>
{
    NSMutableArray *userDataJSON;
    UIImagePickerController *imagePickerController;
    NSString *idString;
    NSString *bioStr;
    NSString *fNameStr;
    NSString *lNameStr;
    NSString *DoBStr;
    NSString *genderStr;
    NSString *emailStr;
    NSString *questStr;
    NSString *answStr;
    NSString *passString;
    UIButton *sampleButton;
    IBOutlet UIScrollView *scrollView;
    
    UIImageView *imageView;
    BOOL newMedia;
    NSData* imageData;
    
    
    
    UITextView *bioTextView;
    UITextField *nameTextField;
    UITextField *lNameTextField;
    UITextField *dayTextField;
    UITextField *monthTextField;
    UITextField *yearTextField;
    UISegmentedControl *segmentedControl;
    UITextField *emailTextField;
    UITextField *questionTextField;
    UITextField *answerTextField;    
    UITextField *passTextField;
    UITextField *passTextField2;
    
}
@property (nonatomic, retain) UIImageView *imageView;
@property (strong, nonatomic) NSMutableArray *jsonData;
@property (strong, nonatomic) NSString *idString;
@property (strong, nonatomic) NSMutableArray *userDataJSON;
@property (nonatomic, retain) NSMutableArray *contentsList;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
-(void)drawView;
-(void) displayImageGallery;
-(IBAction)useCamera;
-(IBAction)useCameraRoll;
//-(void)sendData:(NSString *)imageName;
@end
