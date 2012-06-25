//
//  SelectPhotoViewController.h
//  PartyApp
//
//  Created by Spire Jankulovski on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface SelectPhotoViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIAlertViewDelegate>
{
    UIImageView *imageView;
    BOOL newMedia;
    UITextField *myTextField;
    NSData* imageData;
}
@property (strong, nonatomic) NSMutableArray *jsonData;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
- (IBAction)useCamera;
- (IBAction)useCameraRoll;
-(void)sendData:(NSString *)imageName;
@end

