//
//  DataTableCell.m
//  Task
//
//  Created by Ahmed Azab on 1/25/16.
//  Copyright © 2016 Ahmed Azab. All rights reserved.
//

#import "DataTableCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface DataTableCell()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *photoTitle;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation DataTableCell


-(void)updateCell:(Tweet*)tweet
{
    NSString * imageName = tweet.img;
   // imageName = [imageName stringByReplacingOccurrencesOfString:@"http"
   //                                                  withString:@"https"];
    
    NSURL * imageURL = [NSURL URLWithString:imageName]  ;
    _photoTitle.text = tweet.text;
    
    _dateLabel.text = tweet.dateText;
    
    //Letting AFNetworking handle from async downloads to caching management.
    _userImageView.image = nil;
    [_userImageView setImageWithURL:imageURL];
}

@end