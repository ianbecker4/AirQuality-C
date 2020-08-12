//
//  DVMCityAirQualityController.m
//  AirQuality ObjC
//
//  Created by Ian Becker on 8/12/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "DVMCityAirQualityController.h"

static NSString * const myBaseURL = @"https://api.airvisual.com/";
static NSString * const versionComponent = @"v2";
static NSString * const countryComponent = @"countries";
static NSString * const stateComponent = @"states";
static NSString * const cityComponent = @"cities";
static NSString * const cityDetailsComponent = @"city";
static NSString * const myAPIKey = @"63d224e1-5161-490c-8348-e539000b32bc";

@implementation DVMCityAirQualityController

//+ (instancetype)sharedInstance
//{
//    static DVMCityAirQualityController * sharedInstance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^ {
//        sharedInstance = [DVMCityAirQualityController new];
//    });
//
//    return sharedInstance;
//}

- (void)fetchSupportedCountries:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL * baseURL = [NSURL URLWithString:myBaseURL];
    NSURL * versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL * countryURL = [versionURL URLByAppendingPathComponent:countryComponent];
    NSURLComponents * urlComponents = [NSURLComponents componentsWithURL:countryURL resolvingAgainstBaseURL:true];
    NSURLQueryItem * apiKeyQuery = [NSURLQueryItem queryItemWithName:myAPIKey value:@"key"];
    urlComponents.queryItems = @[apiKeyQuery];
    NSURL * finalURL = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (!data)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        
        NSDictionary * topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!topLevelJSON)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        
        NSDictionary * secondLevelJSON = topLevelJSON[@"data"];
        
        NSMutableArray * arrayOfCountries = [NSMutableArray new];
        
        for (NSDictionary * currentDictionary in secondLevelJSON)
        {
            NSDictionary * countryDictionary = currentDictionary[@"data"];
            DVMCityAirQuality * country = [[DVMCityAirQuality alloc] initWithDictionary:countryDictionary];
            [arrayOfCountries addObject:country];
        }
    }] resume];
}

- (void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL * baseURL = [NSURL URLWithString:myBaseURL];
    NSURL * versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL * stateURL = [versionURL URLByAppendingPathComponent:stateComponent];
    NSURLComponents * urlComponents = [NSURLComponents componentsWithURL:stateURL resolvingAgainstBaseURL:true];
    NSURLQueryItem * countryQuery = [NSURLQueryItem queryItemWithName:countryComponent value:@"country"];
    NSURLQueryItem * apiKeyQuery = [NSURLQueryItem queryItemWithName:myAPIKey value:@"key"];
    urlComponents.queryItems = @[countryQuery, apiKeyQuery];
    NSURL * finalURL = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (!data)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        
        NSDictionary * topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!topLevelJSON)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        
        NSDictionary * secondLevelJSON = topLevelJSON[@"data"];
        
        NSMutableArray * arrayOfStates = [NSMutableArray new];
        
        for (NSDictionary * currentDictionary in secondLevelJSON)
        {
            NSDictionary * stateDictionary = currentDictionary[@"data"];
            DVMCityAirQuality * state = [[DVMCityAirQuality alloc] initWithDictionary:stateDictionary];
            [arrayOfStates addObject:state];
        }
    }] resume];
    
}

- (void)fetchSupportedCitiesInState:(NSString *)country state:(NSString *)state completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL * baseURL = [NSURL URLWithString:myBaseURL];
    NSURL * versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL * cityURL = [versionURL URLByAppendingPathComponent:cityComponent];
    NSURLComponents * urlComponents = [NSURLComponents componentsWithURL:cityURL resolvingAgainstBaseURL:true];
    NSURLQueryItem * countryQuery = [NSURLQueryItem queryItemWithName:countryComponent value:@"country"];
    NSURLQueryItem * stateQuery = [NSURLQueryItem queryItemWithName:stateComponent value:@"state"];
    NSURLQueryItem * apiKeyQuery = [NSURLQueryItem queryItemWithName:myAPIKey value:@"key"];
    urlComponents.queryItems = @[stateQuery, countryQuery, apiKeyQuery];
    NSURL * finalURL = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (!data)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        
        NSDictionary * topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!topLevelJSON)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        
        NSDictionary * secondLevelJSON = topLevelJSON[@"data"];
        
        NSMutableArray * arrayOfCities = [NSMutableArray new];
        
        for (NSDictionary * currentDictionary in secondLevelJSON)
        {
            NSDictionary * cityDictionary = currentDictionary[@"data"];
            DVMCityAirQuality * city = [[DVMCityAirQuality alloc] initWithDictionary:cityDictionary];
            [arrayOfCities addObject:city];
        }
    }] resume];
}

- (void)fetchDataForCity:(NSString *)country state:(NSString *)state city:(NSString *)city completion:(void (^)(DVMCityAirQuality * _Nullable))completion
{
    NSURL * baseURL = [NSURL URLWithString:myBaseURL];
    NSURL * versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL * cityDetailsURL = [versionURL URLByAppendingPathComponent:cityDetailsComponent];
    NSURLComponents * urlComponents = [NSURLComponents componentsWithURL:cityDetailsURL resolvingAgainstBaseURL:true];
    NSURLQueryItem * countryQuery = [NSURLQueryItem queryItemWithName:countryComponent value:@"country"];
    NSURLQueryItem * stateQuery = [NSURLQueryItem queryItemWithName:stateComponent value:@"state"];
    NSURLQueryItem * cityQuery = [NSURLQueryItem queryItemWithName:cityComponent value:@"city"];
    NSURLQueryItem * apiKeyQuery = [NSURLQueryItem queryItemWithName:myAPIKey value:@"key"];
    urlComponents.queryItems = @[cityQuery, stateQuery, countryQuery,apiKeyQuery];
    NSURL * finalURL = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (!data)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        
        NSDictionary * topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!topLevelJSON)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        
        NSDictionary * secondLevelJSON = topLevelJSON[@"data"];
        
        NSDictionary * thirdLevelJSON = secondLevelJSON[@"current"];
        
        DVMCityAirQuality * cityAirQuality = [[DVMCityAirQuality alloc] initWithDictionary:thirdLevelJSON];
        completion(cityAirQuality);
    }] resume];
}

@end
