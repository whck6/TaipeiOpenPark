//
//  ViewController.m
//  TaipeiOpenPark
//
//  Created by Wenhao Ho on 8/21/17.
//  Copyright © 2017 w. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSMutableDictionary<NSString *, NSArray *> *parkDataDictionary;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
#ifdef DEBUG
            NSLog(@"%@", error.description);
#endif
        } else {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            if (!_parkDataDictionary) {
                _parkDataDictionary = [NSMutableDictionary new];
            }
            
            NSArray *tmps = [[dictionary objectForKey:@"result"] objectForKey:@"results"];
            
            //dispatch_group_t dgroup = dispatch_group_create();
            
            for (NSDictionary *tmp in tmps) {
                if (![_parkDataDictionary.allKeys containsObject:[tmp objectForKey:@"ParkName"]]) {
                    [_parkDataDictionary setObject:@[] forKey:[tmp objectForKey:@"ParkName"]];
                }
                
                // NSMutableDictionary *newDictionary = [NSMutableDictionary dictionaryWithDictionary:tmp];
                // [_results addObject:newDictionary];
                
                //dispatch_group_async(dgroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                    /*NSData *pic = [NSData dataWithContentsOfURL:[NSURL URLWithString:[tmp objectForKey:@"Image"]]];
                    UIImage *image = [UIImage imageWithData:pic];
                    if (!image) {
                        image = [UIImage imageNamed:@"default"];
                    }
                    
                    CGFloat rate = self.view.frame.size.width / image.size.width;
                    UIImage *newImage = [AppDelegate scaleImage:image size:CGSizeMake(image.size.width * rate, image.size.height * rate)];
                    [newDictionary setObject:newImage forKey:@"newImage"];*/
                    
                    NSMutableArray *parkDatas = [NSMutableArray arrayWithArray:_parkDataDictionary[[tmp objectForKey:@"ParkName"]]];
                    [parkDatas addObject:tmp];
                    
                    [_parkDataDictionary setObject:parkDatas forKey:[tmp objectForKey:@"ParkName"]];
                //});
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }
    }] resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [_tableView indexPathForCell:sender];
    ((DetailViewController *)segue.destinationViewController).currentIdx = indexPath.row;
    
    NSString *sectionTitle = _parkDataDictionary.allKeys[indexPath.section];
    ((DetailViewController *)segue.destinationViewController).parkDatas = _parkDataDictionary[sectionTitle];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *firstIndexPath = [tableView indexPathForCell:tableView.visibleCells.firstObject];
    self.navigationItem.title = _parkDataDictionary.allKeys[firstIndexPath.section];
}

#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"　　%@", _parkDataDictionary.allKeys[section]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _parkDataDictionary.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionTitle = _parkDataDictionary.allKeys[section];
    return _parkDataDictionary[sectionTitle].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dataCell" forIndexPath:indexPath];
    
    NSString *sectionTitle = _parkDataDictionary.allKeys[indexPath.section];
    NSDictionary *dataDictionary = _parkDataDictionary[sectionTitle][indexPath.row];
    [((UIImageView *)[cell viewWithTag:999]) sd_setImageWithURL:[NSURL URLWithString:dataDictionary[@"Image"]] placeholderImage:[UIImage imageNamed:@"default"] options:SDWebImageRefreshCached];
    ((UILabel *)[cell viewWithTag:998]).text = dataDictionary[@"ParkName"];
    ((UILabel *)[cell viewWithTag:997]).text = dataDictionary[@"Name"];
    ((UILabel *)[cell viewWithTag:996]).text = dataDictionary[@"Introduction"];
    return cell;
}

@end
