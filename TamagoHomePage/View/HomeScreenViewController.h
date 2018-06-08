//
//  HomeScreenViewController.h
//  TamagoHomePage
//
//  Created by Kenneth Lee on 08/06/2018.
//  Copyright © 2018 Kenneth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeScreenViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *languageCollectionViewController;
@property (weak, nonatomic) IBOutlet UICollectionView *liveUserCollectionViewController;

@end
