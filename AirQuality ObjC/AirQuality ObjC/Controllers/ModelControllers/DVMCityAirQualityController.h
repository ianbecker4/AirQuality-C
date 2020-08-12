//
//  DVMCityAirQualityController.h
//  AirQuality ObjC
//
//  Created by Ian Becker on 8/12/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVMCityAirQuality.h"

NS_ASSUME_NONNULL_BEGIN

@interface DVMCityAirQualityController : NSObject

//+(instancetype)sharedInstance;
//
//@property (nonatomic, copy) NSArray<DVMCityAirQuality *> * cityAirQualities;

-(void)fetchSupportedCountries: (void(^)(NSArray<NSString*>*))completion;

-(void)fetchSupportedStatesInCountry: (NSString *)country
                          completion: (void(^)(NSArray<NSString*>*))completion;

-(void)fetchSupportedCitiesInState: (NSString *)country
                             state: (NSString *)state
                        completion: (void(^)(NSArray<NSString*>*))completion;

-(void)fetchDataForCity: (NSString *)country
                  state: (NSString *)state
                   city: (NSString *)city
             completion: (void(^)(DVMCityAirQuality*))completion;

@end

NS_ASSUME_NONNULL_END
