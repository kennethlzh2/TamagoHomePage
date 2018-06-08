//
//  HomeScreenViewController.m
//  TamagoHomePage
//
//  Created by Kenneth Lee on 08/06/2018.
//  Copyright © 2018 Kenneth. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "LanguageCollectionViewCell.h"
#import "LiveUserCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HomeScreenViewController ()

@end

@implementation HomeScreenViewController{
    NSMutableArray *languageArray;
    NSMutableArray *userLiveArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    languageArray = [[NSMutableArray alloc] init];
    userLiveArray = [[NSMutableArray alloc] init];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if(collectionView == self.languageCollectionViewController){
        return languageArray.count;
    }else if(collectionView == self.liveUserCollectionViewController){
        return userLiveArray.count;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(collectionView == self.languageCollectionViewController){
        LanguageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LanguageCollectionViewCell" forIndexPath:indexPath];
        
        return cell;

    }else if(collectionView == self.liveUserCollectionViewController){
        LiveUserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LiveUserCollectionViewCell" forIndexPath:indexPath];
        
        
        
        
        return cell;

    }else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    float cellWidth = (screenWidth - 30) / 2.0;
    CGSize size = CGSizeMake(floorf(cellWidth), floorf(cellWidth));
    
    return size;
}



#pragma mark - SDWebImage

- (void)loadImageWithUrl:(NSString *)imageUrlStr imageView:(UIImageView *)imageView placeholderImage:(UIImage *)placeHolderImage completed:(void (^)(void))completed
{
    
    if([imageUrlStr isKindOfClass:[NSNull class]])
    {
        return;
    }
    if(imageUrlStr.length < 1)
    {
        return;
    }
    NSString *encodeStr = [imageUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    NSURL *imageUrl = [NSURL URLWithString:encodeStr];
    
    [imageView sd_setImageWithURL:imageUrl placeholderImage:placeHolderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        imageView.image = image;
        if (completed) {
            completed();
        }
    }];
}



@end
