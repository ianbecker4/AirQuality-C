//
//  DVMCityAirQualityController.m
//  AirQuality-C
//
//  Created by Ian Becker on 8/12/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

#import "DVMCityAirQualityController.h"
#import "DVMCityAirQuality.h"

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

+ (void)fetchSupportedCountries:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL * baseURL = [NSURL URLWithString:myBaseURL];
    NSURL * versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL * countryURL = [versionURL URLByAppendingPathComponent:countryComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem * apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:myAPIKey];
    
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents * urlComponents = [[NSURLComponents alloc] initWithURL:countryURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL * finalURL = [urlComponents URL];
    
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
        if (data)
        {
            NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSDictionary *dataDict = topLevel[@"data"];
            NSMutableArray *countries = [NSMutableArray new];
            for (NSDictionary *countryDict in dataDict)
            {
                NSString *country = [[NSString alloc] initWithString:countryDict[@"country"]];
                [countries addObject:country];
            }
            completion(countries);
        }
    }] resume];
}

+ (void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL * baseURL = [NSURL URLWithString:myBaseURL];
    NSURL * versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL * stateURL = [versionURL URLByAppendingPathComponent:stateComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem * countryQuery = [[NSURLQueryItem alloc]  initWithName:@"country" value:country];
    NSURLQueryItem * apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:myAPIKey];
    
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents * urlComponents = [[NSURLComponents alloc] initWithURL:stateURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL * finalURL = [urlComponents URL];
    
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
        if (data)
        {
            NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSDictionary *dataDict = topLevel[@"data"];
            NSMutableArray *states = [NSMutableArray new];
            for (NSDictionary *stateDict in dataDict)
            {
                NSString *state = stateDict[@"state"];
                [states addObject:state];
            }
            completion(states);
        }
    }] resume];
    
}

+ (void)fetchSupportedCitiesInState:(NSString *)state country:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL * baseURL = [NSURL URLWithString:myBaseURL];
    NSURL * versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL * cityURL = [versionURL URLByAppendingPathComponent:cityComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem * stateQuery = [[NSURLQueryItem alloc]  initWithName:@"state" value:state];
    NSURLQueryItem * countryQuery = [[NSURLQueryItem alloc]  initWithName:@"country" value:country];
    NSURLQueryItem * apiKeyQuery = [[NSURLQueryItem alloc]  initWithName:@"key" value:myAPIKey];
    
    [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents * urlComponents = [[NSURLComponents alloc] initWithURL:cityURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL * finalURL = [urlComponents URL];
    
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
        if (data)
        {
            NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSDictionary *dataDict = topLevel[@"data"];
            NSMutableArray *cities = [NSMutableArray new];
            for (NSDictionary *cityDict in dataDict)
            {
                NSString *city = cityDict[@"city"];
                [cities addObject:city];
            }
            completion(cities);
        }
    }] resume];
}

+ (void)fetchDataForCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void (^)(DVMCityAirQuality * _Nullable))completion
{
    NSURL * baseURL = [NSURL URLWithString:myBaseURL];
    NSURL * versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL * cityDetailsURL = [versionURL URLByAppendingPathComponent:cityDetailsComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *cityQuery = [[NSURLQueryItem alloc] initWithName:@"city" value:city];
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:myAPIKey];
    
    [queryItems addObject:cityQuery];
    [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:cityDetailsURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
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
        if (data)
        {
            NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSDictionary *dataDict = topLevel[@"data"];
            
            DVMCityAirQuality *cityAQI = [[DVMCityAirQuality alloc] initWithDictionary:dataDict];
            completion(cityAQI);
        }
    }] resume];
}

@end
