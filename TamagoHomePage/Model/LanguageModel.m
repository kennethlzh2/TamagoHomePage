//
//  LanguageModel.m
//  TamagoHomePage
//
//  Created by Kenneth Lee on 08/06/2018.
//  Copyright © 2018 Kenneth. All rights reserved.
//

#import "LanguageModel.h"

@implementation LanguageModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if(self = [super init]){
        self.iD = [dictionary objectForKey:@"id"];
        self.title = [dictionary objectForKey:@"title"];
        self.hex = [dictionary objectForKey:@"hex"];
    }
    
    return self;
}


-(NSArray *)getLanguageList{
    
    static NSString *language = @"[\n{\n\"id\": 1,\n\"title\": \"English\",\n\"hex\": \"#F8AB93\"\n},\n{\n\"id\": 2,\n\"title\": \"中文\",\n\"hex\": \"#EB767F\"\n},\n{\n\"id\": 3,\n\"title\": \"Indonesian\",\n\"hex\": \"#8773A2\"\n},\n{\n\"id\": 4,\n\"title\": \"Tagalog\",\n\"hex\": \"#627D8E\"\n},\n{\n\"id\": 5,\n\"title\": \"Vietnam\",\n\"hex\": \"#F8AB93\"\n}\t\t\n]";
    
    
    self.languageList = [[self convertStringToDictionary:language] mutableCopy];
    
    
    return self.languageList;
}

- (NSArray *)convertStringToDictionary:(NSString *)str{
    NSError *jsonError;
    NSData *objectData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:objectData                                               options:NSJSONReadingMutableContainers error:&jsonError];
    
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for(NSDictionary *dic in json){
        LanguageModel *model = [[LanguageModel alloc] initWithDictionary:dic];
        [tempArray addObject:model];
    }
    
    return tempArray;
}

@end

