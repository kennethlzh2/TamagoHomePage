//
//  HomeScreenViewController.h
//  TamagoHomePage
//
//  Created by Kenneth Lee on 08/06/2018.
//  Copyright © 2018 Kenneth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iCarousel/iCarousel.h>

@interface HomeScreenViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,iCarouselDelegate,iCarouselDataSource>

@property (weak, nonatomic) IBOutlet iCarousel *carouselView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;


@property (weak, nonatomic) IBOutlet UICollectionView *languageCollectionViewController;
@property (weak, nonatomic) IBOutlet UICollectionView *liveUserCollectionViewController;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *liveUserCollectionViewHeightConstraint;

@end
