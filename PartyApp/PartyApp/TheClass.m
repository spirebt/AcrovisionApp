//
//  TheClass.m
//  PartyApp
//
//  Created by Spire Jankulovski on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TheClass.h"

@implementation TheClass
@synthesize dataString;
@synthesize convertToStringData;
-(void)signIn: (NSString *)incomingStr{
    
    nodeContent = [[NSMutableString alloc]init];
    //NSString *soapFormat = [NSString stringWithFormat:@"action=saveUser&save_user=1&firstN=First_name_here&lastN=Last_name&User=Username_here&Pass=Password_here&DoB=23.07.2012&Gender=M&Email=spire.bt@gmail.com&Quest=Question_here&Answ=Answer_here&Token=Token_here&Image=Image_here&Bio=&id=0"];
    NSString *soapFormat = [NSString stringWithFormat:@"%@",incomingStr];
    
    NSURL *locationOfWebService = [NSURL URLWithString:@"http://spireapp.lazarevski-zoran.com/index.php?action=saveUser"];
    
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc]initWithURL:locationOfWebService];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d",[soapFormat length]];
    
    [theRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    //the below encoding is used to send data over the net
    [theRequest setHTTPBody:[soapFormat dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connect = [[NSURLConnection alloc]initWithRequest:theRequest delegate:self];
    
    if (connect) {
        webData = [[NSMutableData alloc]init];
    }
    else {
        NSLog(@"No Connection established");
    }
    
}

//NSURLConnection delegate method

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR with theConenction");
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSLog(@"DONE. Received Bytes: %d", [webData length]);
    //NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    
    convertToStringData = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    
    NSLog(@"Eve rezultat: %@",convertToStringData);
}

@end
