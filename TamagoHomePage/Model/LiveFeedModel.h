//
//  LiveFeedModel.h
//  TamagoHomePage
//
//  Created by Kenneth Lee on 08/06/2018.
//  Copyright © 2018 Kenneth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveFeedModel : NSObject

-(NSArray *)getLiveFeedList;

@property (strong,nonatomic) NSArray *liveFeedList;

@end
