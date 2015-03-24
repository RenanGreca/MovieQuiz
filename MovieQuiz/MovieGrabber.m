//
//  MovieGrabber.m
//  MovieQuiz
//
//  Created by Renan Greca on 3/18/15.
//  Copyright (c) 2015 Renan Greca. All rights reserved.
//

#import "MovieGrabber.h"
#import "Movie.h"

@interface MovieGrabber ()
@end

@implementation MovieGrabber

+ (BOOL) put:(int)limit moviesInList:(NSMutableArray *)list {
    //MovieList *list = [MovieList sharedInstance];

    NSString *apiKey = @"asprbevazhnusm6fjwqnk24d";
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/new_releases.json?apikey=%@&page_limit=%d", apiKey, limit]];
    //NSString *apiUrl = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/new_releases.json?apikey=%@&page_limit=%d", apiKey, limit];
    
    NSError *error = nil;
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    if (!urlData) {
        return NO;
    }
    
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:urlData options:0 error:&error];
    
    if ([data objectForKey:@"error"]) {
        return NO;
    }
    
    NSArray *movies = [data objectForKey:@"movies"];
    
    for (NSDictionary *movie in movies) {
        NSString *title = [movie objectForKey:@"title"];
        
        NSString *synopsis = [movie objectForKey:@"synopsis"];
        synopsis = [MovieGrabber filter:synopsis with:title];
        
        NSString *img = [[movie objectForKey:@"posters"] objectForKey:@"detailed"];
        
        [list addObject:[Movie MovieWithTitle:title andSynopsis:synopsis andImg:img]];
    }
        
    //Movie *movie = [list objectAtIndex:0];
    return YES;
}

+ (NSString *) getDataFrom:(NSString *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

+ (NSString *) getiTunesURLWithTitle:(NSString *)title {
    title = [title stringByReplacingOccurrencesOfString:(NSString *)@" "
                                            withString:(NSString *)@"+"
                                            options:NSCaseInsensitiveSearch
                                            range:NSMakeRange(0, [title length])];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/search?entity=movie&term=%@", title]];

    NSError *error = nil;
    NSData *urlData = [NSData dataWithContentsOfURL:url];

    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:urlData options:0 error:&error];

    NSString *iTunesURL = [[[data objectForKey:@"results"] objectAtIndex:0] objectForKey:@"trackViewUrl"];
    
    return iTunesURL;
}

+ (NSString *) filter:(NSString *)text with:(NSString *)title {

    text = [text stringByReplacingOccurrencesOfString:(NSString *)title
                                            withString:(NSString *)@"_____"
                                            options:NSCaseInsensitiveSearch
                                            range:NSMakeRange(0, [text length])];
    
    return text;
}

@end
