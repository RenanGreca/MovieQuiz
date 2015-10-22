//
//  File.m
//  BEPiD vs. The World
//
//  Created by Renan Greca on 3/13/15.
//  Copyright (c) 2015 Renan Greca. All rights reserved.
//

#import "File.h"

@implementation File

// Funções para ajudar na hora de ler e criar arquivos

+ (NSString *)getSavePath:(NSString *)file {
    NSURL *docDir = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSString *path = [docDir.path
                      stringByAppendingPathComponent:file];
    return path;
}

+ (NSString *)getLoadPath:(NSString *)file ofType:(NSString *)type {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:file ofType:type];

    return path;
}

@end
