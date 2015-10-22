//
//  Counter.m
//  MovieQuiz
//
//  Created by Renan Greca on 3/20/15.
//  Copyright (c) 2015 Renan Greca. All rights reserved.
//

#import "Counter.h"
#import "File.h"

@implementation Counter {
    int counter;
    NSString *name;
    int age;
}

+ (id) sharedInstance {
    static Counter *_sharedInstance = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        _sharedInstance = [[Counter alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        counter = 0;
        [self populate];
    }
    return self;
}

-(int) counter {
    return counter;
}
-(NSString *)name {
    return name;
}

- (void)add {
    counter++;
}

-(void) setName:(NSString *)newName andAge:(int)newAge {
    name = newName;
    age = newAge;
}

-(void) populate {
    NSString *path = [File getSavePath:@"Counter.txt"];
    
    NSError *error;
    NSString *file = [[NSString alloc] initWithContentsOfFile:path
                                                    encoding:NSUTF8StringEncoding
                                                    error:&error];
    NSLog(@"Error loading data: %@", error);
    if (error) {
        return;
    }
    
    NSArray *data = [file componentsSeparatedByString:@"\n"];
    
    if (data.count < 3) {
        return;
    }
    
    counter = (int) [((NSString *)[data objectAtIndex:0]) integerValue];
    name = ((NSString *)[data objectAtIndex:1]);
    age = (int) [((NSString *)[data objectAtIndex:2]) integerValue];
}

-(void) save {
    NSError *error;
    
    NSString *path = [File getSavePath:@"Counter.txt"];
    NSMutableArray *counterInfos;
    counterInfos = [NSMutableArray array];
    
    [counterInfos addObject:[NSString stringWithFormat:@"%d", counter]];
    [counterInfos addObject:name];
    [counterInfos addObject:[NSString stringWithFormat:@"%d", age]];
    
    NSString *infos = [counterInfos componentsJoinedByString:@"\n"];
    [infos writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"Error saving data: %@",error);

}

@end
