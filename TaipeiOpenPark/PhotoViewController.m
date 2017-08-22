//
//  PhotoViewController.m
//  TaipeiOpenPark
//
//  Created by Wenhao Ho on 8/22/17.
//  Copyright © 2017 w. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController () <UIScrollViewDelegate>

@property (nonatomic) UIImage *image;

@end

@implementation PhotoViewController

- (void)setImage:(UIImage *)image {
    _imageView.image = image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

@end
