//
//  fetchData.m
//  Task
//
//  Created by Ahmed Azab on 1/19/16.
//  Copyright © 2016 Ahmed Azab. All rights reserved.
//

#import "FetchData.h"
#import "Tweet.h"


@implementation FetchData
{
    NSArray * orderedTweetsArray;
}

#pragma mark - Call API
-(void)getData
{

    NSString *urlString = @"https://176.58.126.236/twitzer/";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    [manager.securityPolicy setValidatesDomainName:NO];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
      NSArray *myArray = (NSArray *)responseObject;
        [self parseResponseObject:myArray];
        [self.delegate fetchDataDidFinish:self];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       [self.delegate fetchDataFailedWithError:error];
    }];

}




-(void)parseResponseObject:(NSArray *)list
{
    
    NSLog(@"");
    NSMutableArray * tweetsList = [[NSMutableArray alloc]init];
    // Build an array from the dictionary for easy access to each entry
 
    for (int i=0;i<[list count];i++)
    {
        Tweet * tweet = [Tweet new];
        
        NSDictionary * dict = [list objectAtIndex:i];
        NSString * text = [dict objectForKey:@"text"];
        NSArray * textArray = [text componentsSeparatedByString:@">"];
        if ([textArray count] == 2)
            text = [textArray objectAtIndex:1];
        
        tweet.text = text;
       
        NSString * url = [dict objectForKey:@"url"];
        
        tweet.url = url;
        
        NSString * img = [dict objectForKey:@"img"];

        tweet.img = img;
    
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"date"]doubleValue]];

        
        tweet.date = date;
        
        BOOL today = [[NSCalendar currentCalendar] isDateInToday:date];
        if (today)
        {
            tweet.dateText = @"Today";
        }
        else
        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MMM dd"];
            tweet.dateText = [formatter stringFromDate:[NSDate date]];
        }
        
        [tweetsList addObject:tweet];
        
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    orderedTweetsArray = [tweetsList sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];

    
}

#pragma mark - Helping Methods
-(int)numberOfFetchedData
{
    return (int)orderedTweetsArray.count ;
}
-(Tweet *)tweetAtIndex:(NSInteger)index
{
    return [orderedTweetsArray objectAtIndex:index];
}

@end
