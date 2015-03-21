//
//  File.h
//  BEPiD vs. The World
//
//  Created by Renan Greca on 3/13/15.
//  Copyright (c) 2015 Renan Greca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface File : NSObject

+ (NSString *) getSavePath:(NSString *)file;
+ (NSString *) getLoadPath:(NSString *)file ofType:(NSString *)type;

@end
