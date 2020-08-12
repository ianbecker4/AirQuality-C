//
//  DVMPollution.h
//  AirQuality ObjC
//
//  Created by Ian Becker on 8/12/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVMPollution : NSObject

@property (nonatomic, readonly) NSInteger airQualityIndex;

-(instancetype)initWithInt:(NSInteger) aqi;

@end

@interface DVMPollution (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
