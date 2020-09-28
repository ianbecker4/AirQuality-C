//
//  DVMCityAirQualityController.h
//  AirQuality-C
//
//  Created by Ian Becker on 8/12/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVMCityAirQuality.h"

NS_ASSUME_NONNULL_BEGIN

@interface DVMCityAirQualityController : NSObject

//+(instancetype)sharedInstance;

//@property (nonatomic, copy) NSArray<DVMCityAirQuality *> * cityAirQualities;

+(void)fetchSupportedCountries: (void(^)(NSArray<NSString*> *_Nullable))completion;

+(void)fetchSupportedStatesInCountry: (NSString *)country
                          completion: (void(^)(NSArray<NSString*>*_Nullable))completion;

+(void)fetchSupportedCitiesInState: (NSString *)state
                           country: (NSString *)country
                        completion: (void(^)(NSArray<NSString*>*_Nullable))completion;

+(void)fetchDataForCity: (NSString *)city
                  state: (NSString *)state
                country: (NSString *)country
             completion: (void(^)(DVMCityAirQuality *_Nullable))completion;

@end

NS_ASSUME_NONNULL_END
