//
//  LanguageModel.m
//  TamagoHomePage
//
//  Created by Kenneth Lee on 08/06/2018.
//  Copyright © 2018 Kenneth. All rights reserved.
//

#import "LanguageModel.h"

@implementation LanguageModel

-(NSArray *)getLanguageList{
    
    static NSString *country = @"[[\r\n{\r\n\"id\": 1,\r\n\"title\": \u201CEnglish\u201D,\r\n\u201Chex\u201D: \"F8AB93\"\r\n},\r\n{\r\n\"id\": 2,\r\n\"title\": \u201C\u4E2D\u6587\u201D,\r\n\u201Chex\u201D: \"EB767F\"\r\n},\r\n{\r\n\"id\": 3,\r\n\"title\": \u201CIndonesian\u201D,\r\n\u201Chex\u201D: \"8773A2\"\r\n},\r\n{\r\n\"id\": 4,\r\n\"title\": \u201CTagalog\u201D,\r\n\u201Chex\u201D: \"627D8E\"\r\n},\r\n{\r\n\"id\": 5,\r\n\"title\": \u201CVietnam\u201D,\r\n\u201Chex\u201D: \"F8AB93\"\r\n}\t\t\r\n]]";
    
    
    self.languageList = [[self convertStringToDictionary:country] mutableCopy];
    
    
    return self.languageList;
}

- (NSArray *)convertStringToDictionary:(NSString *)str{
    NSError *jsonError;
    NSData *objectData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:objectData                                               options:NSJSONReadingMutableContainers error:&jsonError];
    
    return json;
}

@end

