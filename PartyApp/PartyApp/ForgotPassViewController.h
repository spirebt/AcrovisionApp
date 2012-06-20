//
//  ForgotPassViewController.h
//  PartyApp
//
//  Created by Spire Jankulovski on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ASIFormDataRequest;
@interface ForgotPassViewController : UIViewController <UITextFieldDelegate>
{
    UIButton *submitUser;
    UIButton *submitAnswer;
    UILabel *infoLabel;
    UILabel *questionLabel;
    IBOutlet UIButton *resignKeyboardButton;
    UITextField *userName;
    UITextField *answer;    
    NSMutableArray *forgotPassJson;
}
@property (strong, nonatomic) NSMutableArray *forgotPassJson;
-(IBAction)resignKeyboard;
-(void)sendPost;
@end
