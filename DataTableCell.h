//
//  DataTableCell.h
//  Task
//
//  Created by Ahmed Azab on 1/25/16.
//  Copyright © 2016 Ahmed Azab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface DataTableCell : UITableViewCell

-(void)updateCell:(Tweet*)tweet ;

@end
