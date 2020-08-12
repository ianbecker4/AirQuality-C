//
//  DVMCityAirQuality.m
//  AirQuality ObjC
//
//  Created by Ian Becker on 8/12/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "DVMCityAirQuality.h"

@implementation DVMCityAirQuality

- (instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(DVMWeather *)weather pollution:(DVMPollution *)pollution
{
    {
        self = [super init];
        if (self)
        {
            _city = city;
            _state = state;
            _country = country;
            _weather = weather;
            _pollution = pollution;
        }
        return self;
    }
}

@end

@implementation DVMCityAirQuality (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString * city = dictionary[@"city"];
    NSString * state = dictionary[@"state"];
    NSString * country = dictionary[@"country"];
    DVMWeather * weather = dictionary[@"weather"];
    DVMPollution * pollution = dictionary[@"pollution"];
    
    return [self initWithCity:city state:state country:country weather:weather pollution:pollution];
}

@end
