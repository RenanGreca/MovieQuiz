//
//  Counter.h
//  MovieQuiz
//
//  Created by Renan Greca on 3/20/15.
//  Copyright (c) 2015 Renan Greca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Counter : NSObject

+ (id) sharedInstance;

- (int) counter;
- (NSString *)name;

- (void) add;

-(void) setName:(NSString *)newName andAge:(int)newAge;

- (void) save;

@end
