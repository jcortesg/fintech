//
//  NSDictionary+Helper.m
//  WeHostels
//
//  Created by Lucas Lain on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+Helper.h"

@implementation NSDictionary (Helper)


- (NSString *) getString :(NSString *)field {
    
    NSString * value = [self objectForKey:field]; 
    id         nul   = [NSNull null];
    
    if (value == nul) {
        return @"";
    } else {
        return value;
    }
    
}

@end
