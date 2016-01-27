//
//  Tweet.h
//  Task
//
//  Created by Ahmed Azab on 1/24/16.
//  Copyright © 2016 Ahmed Azab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject
{
    NSString * text;
    NSString * url;
    NSString * img;
    NSDate * date;
    NSString * dateText;
}

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *dateText;

@end