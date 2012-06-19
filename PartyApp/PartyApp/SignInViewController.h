//
//  SignInViewController.h
//  PartyApp
//
//  Created by Spire Jankulovski on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPKeyboardAvoidingScrollView,ASIFormDataRequest; ;
@interface SignInViewController : UIViewController  <UITextFieldDelegate>{
    int segControl;
    
    NSString *convertToStringData;
    NSString *dataString;
}

@property(nonatomic, strong)NSString *dataString;
@property(nonatomic, strong)NSString *convertToStringData;
-(void)sendPost: (NSString *)incomingStr gender:(NSString*)genderData;
-(IBAction)signIn;
@property (strong, nonatomic) NSMutableArray *jsonData;

@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UITextField *firstN;
@property (nonatomic, retain) IBOutlet UITextField *lastN;
@property (nonatomic, retain) IBOutlet UITextField *user;
@property (nonatomic, retain) IBOutlet UITextField *pass;
@property (nonatomic, retain) IBOutlet UITextField *repeatPass;
@property (nonatomic, retain) IBOutlet UITextField *dobDay;
@property (nonatomic, retain) IBOutlet UITextField *dobMonth;
@property (nonatomic, retain) IBOutlet UITextField *dobYear;
@property (nonatomic, retain) IBOutlet UITextField *gender;
@property (nonatomic, retain) IBOutlet UITextField *email;
@property (nonatomic, retain) IBOutlet UITextField *question;
@property (nonatomic, retain) IBOutlet UITextField *answer;
@property (nonatomic, retain) IBOutlet UITextField *bio;
@property (nonatomic, retain) IBOutlet UILabel *alertLabel;
@property (nonatomic, retain) IBOutlet UILabel *mainAlertLabel;
@property (nonatomic, assign) int segControl;
@end
