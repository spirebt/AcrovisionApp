//
//  EditProfileViewController.m
//  PartyApp
//
//  Created by Spire Jankulovski on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditProfileViewController.h"
#import <AudioToolbox/AudioServices.h>
@interface EditProfileViewController ()

@end

@implementation EditProfileViewController
@synthesize userDataJSON;
@synthesize contentsList;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Edit Profile";
    self.navigationItem.hidesBackButton = TRUE; 
    NSString *bioStr = [NSString stringWithFormat:[userDataJSON valueForKey:@"Bio"]];
    NSString *fNameStr = [NSString stringWithFormat:[userDataJSON valueForKey:@"firstN"]];
    NSString *lNameStr = [NSString stringWithFormat:[userDataJSON valueForKey:@"lastN"]];
    NSString *DoBStr = [NSString stringWithFormat:[userDataJSON valueForKey:@"DoB"]];
    NSString *genderStr = [NSString stringWithFormat:[userDataJSON valueForKey:@"Gender"]];
    NSString *emailStr = [NSString stringWithFormat:[userDataJSON valueForKey:@"Email"]];
    NSString *questStr = [NSString stringWithFormat:[userDataJSON valueForKey:@"Quest"]];
    NSString *answStr = [NSString stringWithFormat:[userDataJSON valueForKey:@"Answ"]];
   
    //[jsonData valueForKey:@"error"]
    NSArray *firstSection = [NSArray arrayWithObjects: nil];
    
    
    NSArray *secondSection = [NSArray arrayWithObjects:fNameStr,lNameStr,DoBStr,genderStr, nil];
    
    
    NSArray *thirdSection = [NSArray arrayWithObjects:emailStr,questStr,answStr,nil];
	
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:firstSection, secondSection, thirdSection, nil];
    [self setContentsList:array];
     array = nil;
    
    imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 231)]; 
    UIButton *sampleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sampleButton setFrame:CGRectMake(10,5,150,95)];
    [sampleButton setTitle:@"Tap to add image" forState:UIControlStateNormal];
    [sampleButton setBackgroundImage:[[UIImage imageNamed:@"redButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [sampleButton setBackgroundColor:[UIColor brownColor]];
    [sampleButton addTarget:self action:@selector(displayImageGallery) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sampleButton];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void) displayImageGallery
{
    imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.delegate = self;
    [self presentModalViewController:imagePickerController animated:YES];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    imgv.image = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
    [self dismissModalViewControllerAnimated:YES];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
       NSInteger sections = [[self contentsList] count];

    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray *sectionContents = [[self contentsList] objectAtIndex:section];
    NSInteger rows = [sectionContents count];

    return rows;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}   


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // wrapperView - by default has the width of the table, you can change the height
    // with the heightForHeaderInSection method
    UIView *aView = [[UIView alloc] initWithFrame:CGRectZero];
    if (section == 1) {
        NSString *bioStr = [NSString stringWithFormat:[userDataJSON valueForKey:@"Bio"]];

        // your real section view: a label, a uiview, whatever
        CGRect myFrame; // create your own frame
        myFrame.origin = CGPointMake(10, 0);
        //myFrame.size = CGSizeMake(tableView.bounds.size.width-10,44); 
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(160, 0.0, 150, 44.0)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        //yes strange, but otherwise the textfield won't show up :(
        
        textField.text = bioStr;
        [textField setDelegate:self];		
        [textField addTarget:self action:@selector(textFieldDone:) 
            forControlEvents:UIControlEventEditingDidEndOnExit];
        [aView addSubview:textField];
        
        return aView;
    }
    else return aView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *sectionContents = [[self contentsList] objectAtIndex:[indexPath section]];
    NSString *contentForThisRow = [sectionContents objectAtIndex:[indexPath row]];


    static NSString *CellIdentifier = @"Cell";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0.0, 0.0, 300.0, 44.0)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    //yes strange, but otherwise the textfield won't show up :(
    cell.textLabel.backgroundColor = [UIColor blackColor];
    
    textField.text = contentForThisRow;
    [textField setDelegate:self];		
    [textField addTarget:self action:@selector(textFieldDone:) 
        forControlEvents:UIControlEventEditingDidEndOnExit];
    [cell.contentView addSubview:textField];

	//[[cell textLabel] setText:contentForThisRow];
    return cell;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
	NSLog(@"textFieldDidBeginEditing");
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	NSLog(@"textFieldDidEndEditing");
    //here we put submit to server updates
}

-(IBAction)textFieldDone:(id)sender{	
	NSLog(@"textFieldDone");
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
