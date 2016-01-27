//
//  fetchData.h
//  Task
//
//  Created by Ahmed Azab on 1/19/16.
//  Copyright © 2016 Ahmed Azab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Tweet.h"

@protocol FetchDataDelegate;

@interface FetchData : NSObject


// connect to API and parse the result
-(void)getData;

-(int)numberOfFetchedData;
-(Tweet *)tweetAtIndex:(NSInteger)index;

@property id<FetchDataDelegate>delegate ;

@end


@protocol FetchDataDelegate

-(void)fetchDataDidFinish:(FetchData *)fetchData;
-(void)fetchDataFailedWithError:(NSError *)error;

@end
