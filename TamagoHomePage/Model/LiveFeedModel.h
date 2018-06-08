//
//  LiveFeedModel.h
//  TamagoHomePage
//
//  Created by Kenneth Lee on 08/06/2018.
//  Copyright © 2018 Kenneth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveFeedModel : NSObject

@property (strong,nonatomic) NSString *iD;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *year;
@property (strong,nonatomic) NSString *runtime;
@property (strong,nonatomic) NSArray *genres;
@property (strong,nonatomic) NSString *director;
@property (strong,nonatomic) NSString *actors;
@property (strong,nonatomic) NSString *plot;
@property (strong,nonatomic) NSString *posterUrl;




-(NSArray *)getLiveFeedList;

@property (strong,nonatomic) NSArray *liveFeedList;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
