//
//  DetailViewController.h
//  TaipeiOpenPark
//
//  Created by Wenhao Ho on 8/22/17.
//  Copyright © 2017 w. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@property (nonatomic, weak) IBOutlet UILabel *parkNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *opentimeLabel;
@property (nonatomic, weak) IBOutlet UILabel *introductionLabel;

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic) NSArray<NSDictionary *> *parkDatas;

@property (nonatomic, assign) NSUInteger currentIdx;

@end
