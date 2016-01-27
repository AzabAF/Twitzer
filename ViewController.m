//
//  ViewController.m
//  Task
//
//  Created by Ahmed Azab on 1/19/16.
//  Copyright © 2016 Ahmed Azab. All rights reserved.
//

#import "ViewController.h"
#import "FetchData.h"
#import "DataTableCell.h"

@interface ViewController () <FetchDataDelegate>
{
    FetchData * fetchData;
}

@property (nonatomic,strong)UIActivityIndicatorView * loadIndicator ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self initLoadIndicator];
    [self initFetchData];
    [self addBackgroundColor];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Helping Methods
-(void)addBackgroundColor
{
#if defined(TARGET_LITE)
    
    [self.tableView setBackgroundColor:[UIColor grayColor]];//Colored version
#else
    [self.tableView setBackgroundColor:[UIColor whiteColor]];//UN Colored version
#endif
}

#pragma mark - Init Methods
-(void)initLoadIndicator
{
    _loadIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [_loadIndicator setHidesWhenStopped:YES];

    [self.tableView addSubview:_loadIndicator];
    
    [_loadIndicator setCenter:self.tableView.center];
    [_loadIndicator startAnimating];
}

- (void)initFetchData
{
    fetchData = [[FetchData alloc]init];
    [fetchData getData];
    [fetchData setDelegate:self];
}


#pragma mark - Fetch Data Delegate
- (void)fetchDataDidFinish:(FetchData *)fetchData
{
     [_loadIndicator stopAnimating];
    [self.tableView reloadData];
}

- (void)fetchDataFailedWithError:(NSError *)error
{
   [_loadIndicator stopAnimating];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [alert show];
}


#pragma mark - Observers

//- (void)didChangePreferredContentSize:(NSNotification *)notification
//{
//    [self.tableView reloadData];
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [fetchData numberOfFetchedData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"DataCell";
    
    DataTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell updateCell:[fetchData tweetAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    NSString * url = [fetchData tweetAtIndex:indexPath.row].url;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
}

@end
