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
#import "LiveFeedModel.h"
#import "LanguageModel.h"

@interface HomeScreenViewController ()

@end

@implementation HomeScreenViewController{
    NSArray *languageArray;
    NSArray *userLiveArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    languageArray = [[NSArray alloc] init];
    userLiveArray = [[NSArray alloc] init];
    
    languageArray = [[LanguageModel alloc] getLanguageList];
    userLiveArray = [[LiveFeedModel alloc] getLiveFeedList];
    
    
    
    [self.liveUserCollectionViewController layoutIfNeeded];
    if(userLiveArray.count<1){
        self.liveUserCollectionViewHeightConstraint.constant = 0;
    }
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    float cellWidth = (screenWidth - 30) / 2.0;
    
    double rows = userLiveArray.count / 2.0;
    self.liveUserCollectionViewHeightConstraint.constant = ((floorf(cellWidth) + 10) * ceil(rows));
    
    
    [self.liveUserCollectionViewController reloadData];
    [self.languageCollectionViewController reloadData];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View

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
        
        if (languageArray.count>0){
            
            LanguageModel *model = [languageArray objectAtIndex:[indexPath row]];
            cell.languageLabel.text = model.title;
            cell.backgroundColor = [self colorWithHexString:model.hex alpha:1.0];
            
        }
        
        return cell;
    }else if(collectionView == self.liveUserCollectionViewController){
        LiveUserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LiveUserCollectionViewCell" forIndexPath:indexPath];
        
        if (userLiveArray.count>0){
            
            LiveFeedModel *model = [userLiveArray objectAtIndex:[indexPath row]];
            cell.backgroundImageView.image = nil;
            cell.viewCountLabel.text = model.runtime;
            cell.momentLabel.text = model.title;
            cell.userNameLabel.text = model.director;
            cell.countryNameLabel.text = model.year;
            [self loadImageWithUrl:model.posterUrl imageView:cell.backgroundImageView placeholderImage:[UIImage imageNamed:@"no-image"] completed:nil];
            
        }
        
        
        return cell;

    }else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == self.languageCollectionViewController){
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        float cellWidth = (screenWidth - 50) / 3.8;
        CGSize size = CGSizeMake(floorf(cellWidth), 37);
        
        return size;
    }else if(collectionView == self.liveUserCollectionViewController){
    
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        float cellWidth = (screenWidth - 30) / 2.0;
        CGSize size = CGSizeMake(floorf(cellWidth), floorf(cellWidth));
        
        return size;
    }else{
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        float cellWidth = screenWidth ;
        CGSize size = CGSizeMake(cellWidth, cellWidth);
        
        return size;
    }
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

#pragma mark - Extra

- (UIColor *)colorWithHexString:(NSString *)str_HEX  alpha:(CGFloat)alpha_range{
    int red = 0;
    int green = 0;
    int blue = 0;
    sscanf([str_HEX UTF8String], "#%02X%02X%02X", &red, &green, &blue);
    return  [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha_range];
}



@end
