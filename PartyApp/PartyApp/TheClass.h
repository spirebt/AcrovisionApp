//
//  TheClass.h
//  PartyApp
//
//  Created by Spire Jankulovski on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TheClass : NSHTTPURLResponse{
    NSMutableData *webData;
    NSString *convertToStringData;
    NSMutableString *nodeContent;
    NSString *dataString;
}
@property(nonatomic, strong)NSString *dataString;
@property(nonatomic, strong)NSString *convertToStringData;
-(void)signIn: (NSString *)incomingStr;

@end
