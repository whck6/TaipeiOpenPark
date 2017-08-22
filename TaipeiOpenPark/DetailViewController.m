//
//  DetailViewController.m
//  TaipeiOpenPark
//
//  Created by Wenhao Ho on 8/22/17.
//  Copyright © 2017 w. All rights reserved.
//

#import "PhotoViewController.h"
#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:[_parkDatas[_currentIdx] objectForKey:@"Image"]] placeholderImage:[UIImage imageNamed:@"default"] options:SDWebImageRefreshCached];
    
    _parkNameLabel.text = [_parkDatas[_currentIdx] objectForKey:@"ParkName"];
    _nameLabel.text = [_parkDatas[_currentIdx] objectForKey:@"Name"];
    _opentimeLabel.text = [@"開放時間：" stringByAppendingString:[_parkDatas[_currentIdx] objectForKey:@"OpenTime"]];
    _introductionLabel.text = [_parkDatas[_currentIdx] objectForKey:@"Introduction"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [_collectionView indexPathForCell:sender];
    
    [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:[NSURL URLWithString:[_parkDatas[indexPath.row] objectForKey:@"Image"]] options:SDWebImageDownloaderHighPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (error) {
#ifdef DEBUG
            NSLog(@"%@", error.description);
#endif
        } else {
            if ([segue.destinationViewController isKindOfClass:[PhotoViewController class]]) {
                [segue.destinationViewController setValue:image forKey:@"image"];
            }
        }
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _parkDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dataCell" forIndexPath:indexPath];
    [((UIImageView *)[cell viewWithTag:999]) sd_setImageWithURL:[NSURL URLWithString:[_parkDatas[indexPath.row] objectForKey:@"Image"]] placeholderImage:[UIImage imageNamed:@"default"] options:SDWebImageRefreshCached];
    ((UILabel *)[cell viewWithTag:998]).text = [_parkDatas[indexPath.row] objectForKey:@"Name"];
    return cell;
}

@end
