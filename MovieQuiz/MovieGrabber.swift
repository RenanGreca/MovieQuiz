//
//  MovieGrabber.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/6/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import Foundation
import SwiftyJSON

extension String{
    func exclude(find:String) -> String {
        return stringByReplacingOccurrencesOfString(find, withString: "", options: .LiteralSearch, range: nil)
    }
    func replaceAll(find:String, with:String) -> String {
        return stringByReplacingOccurrencesOfString(find, withString: with, options: .CaseInsensitiveSearch, range: nil)
    }
}

func fetchMovies(limit: Int) -> Array<Movie> {
    let apikey = "asprbevazhnusm6fjwqnk24d"
    
    // create the request
    let url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/new_releases.json?apikey=\(apikey)&page_limit=\(limit)")
    let data = NSData(contentsOfURL: url!)
    
    if data == nil {
        println("Rotten Tomatoes 💩")
        return []
    }
    
    var error: NSErrorPointer
    let json = NSJSONSerialization.JSONObjectWithData(data!,
      options: NSJSONReadingOptions.MutableContainers, error: nil) as! [String:AnyObject]
    
    var returnMovies: Array<Movie> = []
    
    if let movies = json["movies"] as? NSArray {
        for movie in movies {
            let title = movie["title"] as! String
            let synopsis = movie["synopsis"] as! String
            let cleanSynopsis = synopsis.replaceAll(title, with: "_____")
            if let posters = movie["posters"] as? NSDictionary {
                let imgURL = posters["original"] as! String
                
                var m = Movie(title: title, synopsis: cleanSynopsis, imgURL: imgURL)
                returnMovies.append(m)
            }
        }
    }
    
    return returnMovies
}

func getStoreURL(title: String) -> String {
    let cleanTitle = title.replaceAll(" ", with: "+")
    let url = NSURL(string: "https://itunes.apple.com/search?entity=movie&term=\(cleanTitle)")
    let data = NSData(contentsOfURL: url!)
    
    if data == nil {
        println("iTunes 💩")
    }
    
    var error: NSErrorPointer
    let json = JSON(data: data!)
    
    if let trackUrl = json["results"][0]["trackViewUrl"].stringValue as? String {
        return trackUrl
    }
    
    return ""
    //    NSString *iTunesURL = [[[data objectForKey:@"results"] objectAtIndex:0] objectForKey:@"trackViewUrl"];
}





