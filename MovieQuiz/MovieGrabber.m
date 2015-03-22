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
    
    NSLog(@"%@", iTunesURL);
    return iTunesURL;
}

+ (NSString *) filter:(NSString *)text with:(NSString *)title {
    //NSArray *sentences = [text componentsSeparatedByString: @"."];
    //NSArray *words = [text componentsSeparatedByString: @" "];
    //NSArray *titlewords = [title componentsSeparatedByString: @" "];
    
    /*for (int i=0; i<words.count; i++) {
        NSString *word = [words objectAtIndex:i];
        for (NSString *titleword in titlewords) {
            if ([word containsString:titleword]) {
                word = @"???";
            }
        }
    }*/
    text = [text stringByReplacingOccurrencesOfString:(NSString *)title
                                            withString:(NSString *)@"_____"
                                            options:NSCaseInsensitiveSearch
                                            range:NSMakeRange(0, [text length])];
    
    return text;
    //NSLog(@"%@", words);
    //return [words componentsJoinedByString:@" "];
}


/*+ (NSDictionary *) parseJSON:(NSData *)json {
    NSDictionary *ret;
    
    if(NSClassFromString(@"NSJSONSerialization"))
    {
        NSError *error = nil;
        id object = [NSJSONSerialization
                     JSONObjectWithData:json
                     options:0
                     error:&error];
        
        if(error) {  }
        
        // the originating poster wants to deal with dictionaries;
        // assuming you do too then something like this is the first
        // validation step:
        if([object isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *ret = object;
        }
        else
        {
        }
    }
    else
    {
        // the user is using iOS 4; we'll need to use a third-party solution.
        // If you don't intend to support iOS 4 then get rid of this entire
        // conditional and just jump straight to
        // NSError *error = nil;
        // [NSJSONSerialization JSONObjectWithData:...
    }

}*/

@end
