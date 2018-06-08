//
//  LanguageModel.h
//  TamagoHomePage
//
//  Created by Kenneth Lee on 08/06/2018.
//  Copyright © 2018 Kenneth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageModel : NSObject

-(NSArray *)getLanguageList;

@property (strong,nonatomic) NSString *iD;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *hex;




@property (strong,nonatomic) NSArray *languageList;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
