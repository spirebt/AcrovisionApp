//
//  EditProfileViewController.h
//  PartyApp
//
//  Created by Spire Jankulovski on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UITableViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSMutableArray *userDataJSON;
    UIImagePickerController *imagePickerController;
    UIImageView *imgv;
}
@property (strong, nonatomic) NSMutableArray *userDataJSON;
@property (nonatomic, retain) NSMutableArray *contentsList;
-(void) displayImageGallery;
@end
