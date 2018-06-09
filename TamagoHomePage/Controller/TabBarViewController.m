//
//  TabBarViewController.m
//  TamagoHomePage
//
//  Created by Kenneth Lee on 08/06/2018.
//  Copyright © 2018 Kenneth. All rights reserved.
//

#import "TabBarViewController.h"
#import "NavigationBarCustomView.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController{
//    UIView *channelsView;
//    UIView *tamagoView;
//    UIView *discoveryView;

    NavigationBarCustomView *customView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigationBar{
    
//    UIView *navBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 32)];
//    navBarView.layer.cornerRadius = 15;
//    navBarView.layer.borderWidth = 1;
//    navBarView.layer.borderColor = [UIColor yellowColor].CGColor;
//
//    channelsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 66.5, 32)];
//    UILabel *channelLabel = [[UILabel alloc] init];
//    channelLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    channelLabel.font = [UIFont systemFontOfSize:12];
//    channelLabel.text = @"Channels";
//
//    NSLayoutConstraint *channelsViewTopConstraint = [NSLayoutConstraint constraintWithItem:channelLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:channelsView attribute:NSLayoutAttributeTop multiplier:1 constant:5];
//    NSLayoutConstraint *channelsViewBottom = [NSLayoutConstraint constraintWithItem:channelLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:channelsView attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
//    NSLayoutConstraint *channelsViewLeading = [NSLayoutConstraint constraintWithItem:channelLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:channelsView attribute:NSLayoutAttributeLeading multiplier:1 constant:5];
//    NSLayoutConstraint *channelsViewTrailing = [NSLayoutConstraint constraintWithItem:channelLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:channelsView attribute:NSLayoutAttributeTrailing multiplier:1 constant:5];
//    [channelsView addConstraints:@[channelsViewTopConstraint,channelsViewBottom,channelsViewLeading,channelsViewTrailing]];
//
//
//    tamagoView = [[UIView alloc] initWithFrame:CGRectMake(66.5, 0, 67, 32)];
//    UILabel *tamagoLabel = [[UILabel alloc] init];
//    tamagoLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    tamagoLabel.font = [UIFont systemFontOfSize:12];
//    tamagoLabel.text = @"Tamago";
//
//
//    NSLayoutConstraint *tamagoViewTopConstraint = [NSLayoutConstraint constraintWithItem:tamagoLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:tamagoView attribute:NSLayoutAttributeTop multiplier:1 constant:5];
//    NSLayoutConstraint *tamagoViewBottom = [NSLayoutConstraint constraintWithItem:tamagoLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:tamagoView attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
//    NSLayoutConstraint *tamagoViewLeading = [NSLayoutConstraint constraintWithItem:tamagoLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:tamagoView attribute:NSLayoutAttributeLeading multiplier:1 constant:5];
//    NSLayoutConstraint *tamagoViewTrailing = [NSLayoutConstraint constraintWithItem:tamagoLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:tamagoView attribute:NSLayoutAttributeTrailing multiplier:1 constant:5];
//    [tamagoView addConstraints:@[tamagoViewTopConstraint,tamagoViewBottom,tamagoViewLeading,tamagoViewTrailing]];
//
//    discoveryView = [[UIView alloc] initWithFrame:CGRectMake(133.5,0 , 66.5, 32)];
//    UILabel *discoveryLabel = [[UILabel alloc] init];
//    discoveryLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    discoveryLabel.font = [UIFont systemFontOfSize:12];
//    discoveryLabel.text = @"Discovery";
//
//
//    NSLayoutConstraint *discoveryViewTopConstraint = [NSLayoutConstraint constraintWithItem:discoveryLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:discoveryView attribute:NSLayoutAttributeTop multiplier:1 constant:5];
//    NSLayoutConstraint *discoveryViewBottom = [NSLayoutConstraint constraintWithItem:discoveryLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:discoveryView attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
//    NSLayoutConstraint *discoveryViewLeading = [NSLayoutConstraint constraintWithItem:discoveryLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:discoveryView attribute:NSLayoutAttributeLeading multiplier:1 constant:5];
//    NSLayoutConstraint *discoveryViewTrailing = [NSLayoutConstraint constraintWithItem:discoveryLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:discoveryView attribute:NSLayoutAttributeTrailing multiplier:1 constant:5];
//    [discoveryView addConstraints:@[discoveryViewTopConstraint,discoveryViewBottom,discoveryViewLeading,discoveryViewTrailing]];
//
//
//
//
//
//    [navBarView addSubview:channelsView];
//    [navBarView addSubview:tamagoView];
//    [navBarView addSubview:discoveryView];
    
    customView = [[[NSBundle mainBundle] loadNibNamed:@"NavigationBarCustomView" owner:self options:nil] objectAtIndex:0];
    customView.layer.cornerRadius = 15;
    customView.clipsToBounds = YES;
    customView.layer.borderWidth = 1;
    customView.layer.borderColor = [UIColor yellowColor].CGColor;
    
    //to set the default colour of the bar
    customView.tamagoView.backgroundColor = [UIColor yellowColor];
    
    
    self.navigationItem.titleView = customView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:nil];
    
    [self addTapGesture];
    
}

- (void)addTapGesture{
    UITapGestureRecognizer *channelsViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(channelsViewTap)];
    channelsViewTapGesture.numberOfTapsRequired = 1;
    [customView.channelsView setUserInteractionEnabled:YES];
    [customView.channelsView addGestureRecognizer:channelsViewTapGesture];
    
    UITapGestureRecognizer *tamagoViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tamagoViewTap)];
    tamagoViewTapGesture.numberOfTapsRequired = 1;
    [customView.tamagoView setUserInteractionEnabled:YES];
    [customView.tamagoView addGestureRecognizer:tamagoViewTapGesture];
    
    UITapGestureRecognizer *discoveryViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(discoveryViewTap)];
    discoveryViewTapGesture.numberOfTapsRequired = 1;
    [customView.discoveryView setUserInteractionEnabled:YES];
    [customView.discoveryView addGestureRecognizer:discoveryViewTapGesture];
    
}

- (void)channelsViewTap{
    customView.channelsView.backgroundColor = [UIColor yellowColor];
    customView.tamagoView.backgroundColor = [UIColor whiteColor];
    customView.discoveryView.backgroundColor = [UIColor whiteColor];
}

- (void)tamagoViewTap{
    customView.channelsView.backgroundColor = [UIColor whiteColor];
    customView.tamagoView.backgroundColor = [UIColor yellowColor];
    customView.discoveryView.backgroundColor = [UIColor whiteColor];
}

- (void)discoveryViewTap{
    customView.channelsView.backgroundColor = [UIColor whiteColor];
    customView.tamagoView.backgroundColor = [UIColor whiteColor];
    customView.discoveryView.backgroundColor = [UIColor yellowColor];
}





@end
