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
    NSArray *bannerArray;
    CGRect screenRect;
    NSTimer *timer;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    
    bannerArray = @[@"image1",@"image2",@"image3",@"image4"];
    
}

- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    //this is true even if your project is using ARC, unless
    //you are targeting iOS 5 as a minimum deployment target
    self.carouselView.delegate = nil;
    self.carouselView.dataSource = nil;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //get screen rect
    screenRect = [[UIScreen mainScreen] bounds];
    
    //setting up language and live user array
    languageArray = [[NSArray alloc] init];
    userLiveArray = [[NSArray alloc] init];
    languageArray = [[LanguageModel alloc] getLanguageList];
    userLiveArray = [[LiveFeedModel alloc] getLiveFeedList];
    
    //configure carousel
    self.carouselView.type = iCarouselTypeRotary;
    self.carouselView.pagingEnabled = YES;
    self.carouselView.currentItemIndex = 0;
    [self.pageControl setCurrentPage:0];
    [self.pageControl setNumberOfPages:bannerArray.count];
    
    
    [self.liveUserCollectionViewController layoutIfNeeded];
    if(userLiveArray.count<1){
        self.liveUserCollectionViewHeightConstraint.constant = 0;
    }
    
    
    CGFloat screenWidth = screenRect.size.width;
    float cellWidth = (screenWidth - 30) / 2.0;
    
    double rows = userLiveArray.count / 2.0;
    self.liveUserCollectionViewHeightConstraint.constant = ((floorf(cellWidth) + 10) * ceil(rows));
    
    [self.liveUserCollectionViewController reloadData];
    [self.languageCollectionViewController reloadData];

    [self addTimer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    //free up memory by releasing subviews
    self.carouselView = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Banner

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [bannerArray count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    UIImageView *imageView = nil;
    
    NSString *imageName = [bannerArray objectAtIndex:index];
    
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIView alloc] initWithFrame:self.carouselView.bounds];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.carouselView.bounds.origin.x + 10, self.carouselView.bounds.origin.y, self.carouselView.bounds.size.width - 20, self.carouselView.bounds.size.height)];
        imageView.layer.cornerRadius = 10;
        
        [imageView setImage:[UIImage imageNamed:imageName]];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        
        [view addSubview:label];
        [view addSubview:imageView];
        [view bringSubviewToFront:label];
        
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
        
        //get a reference to the image view in the recycled view
        [imageView setImage:[UIImage imageNamed:imageName]];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    
//    //set background color
//    CGFloat red = arc4random() / (CGFloat)INT_MAX;
//    CGFloat green = arc4random() / (CGFloat)INT_MAX;
//    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
//    view.backgroundColor = [UIColor colorWithRed:red
//                                           green:green
//                                            blue:blue
//                                           alpha:1.0];
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
//    label.text = [bannerArray[index] stringValue];
    
    return view;
}

#pragma mark - Timer
-(void)addTimer
{
    if (!timer)
    {
        
#if DEBUG
        NSLog(@"%@",@"start timer");
#endif
        
        timer = [NSTimer scheduledTimerWithTimeInterval:4.0f
                                                      target:self
                                                    selector:@selector(indicatorTimerFired:)
                                                    userInfo:nil
                                                     repeats:YES];
        
    }
}
-(void)removedTimer
{
#if DEBUG
    NSLog(@"%@",@"remove timer");
#endif
    
    if ([timer isValid]) {
        [timer invalidate];
    }
    timer = nil;
}

- (void)indicatorTimerFired:(NSTimer *)timer {
#if DEBUG
    NSLog(@"%@",@"run timer");
#endif
    
    NSInteger nextPage = self.carouselView.currentItemIndex + 1;
    NSInteger pageControllerNextPage = 0;
    
    [self.carouselView scrollToItemAtIndex:nextPage animated:YES];
    
    pageControllerNextPage = nextPage == bannerArray.count ? 0 : nextPage;
    [self.pageControl setCurrentPage: pageControllerNextPage];
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
            cell.containerView.backgroundColor = [self colorWithHexString:model.hex alpha:1.0];
            cell.containerView.layer.cornerRadius = 5;
            
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
            cell.liveView.layer.cornerRadius = 5;
            cell.containerView.layer.cornerRadius = 14;
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
        CGFloat screenWidth = screenRect.size.width;
        float cellWidth = (screenWidth - 50) / 4.3;
        CGSize size = CGSizeMake(floorf(cellWidth), 37);
        
        return size;
    }else if(collectionView == self.liveUserCollectionViewController){
    
        CGFloat screenWidth = screenRect.size.width;
        float cellWidth = (screenWidth - 30) / 2.0;
        CGSize size = CGSizeMake(floorf(cellWidth), floorf(cellWidth));
        
        return size;
    }else{

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
