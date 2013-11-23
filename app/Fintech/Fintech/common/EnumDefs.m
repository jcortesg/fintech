//
//  EnumDefs.m
//  WeHostels
//
//  Created by John Torres on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EnumDefs.h"

@implementation EnumDefs
#define APPLE_ID               @"545679170"

//static function for MD5 encriptation
+ (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}
//static function for dataformmater dateFormatterISO8601
+ (NSString *)dateFormatterISO8601:(NSDate *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"yyyy-MM-dd"];
    NSString *stingDate=[dateFormat stringFromDate:date];
    return stingDate;
    


}


+(NSString *) platformString {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 GSM";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 CDMA";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad 4 (CDMA)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}

+(NSString*)randomString {
    NSString *result = nil;
    
    int value=(arc4random() % (10));
    
    switch(value) {
        case 0:
            result = @"The world is a book and those who do not travel read only one page";
            break;
        case 1:
            result = @"Get lost. Find yourself";
            break;
        case 2:
            result = @"A journey of a thousand miles must begin with a single step";
            break;
        case 3:
            result = @"Don't go where the path may lead, go instead where there is no path and leave a trail.";
            break;
        case 4:
            result = @"Not all those who wander are lost.";
            break;
        case 5:
            result = @"He who does not travel does not know the value of men.";
            break;     
        case 6:
            result = @"A journey is best measured in friends, rather than miles";
            break;    
        case 7:
            result = @"I don't know where I'm going, but I'm on my way.";
            break;
        case 8:
            result = @"Wandering re-establishes the original harmony which once existed between man and the universe.";
            break;
        case 9:
            result = @"Travel is fatal to prejudice, bigotry, and narrow-mindedness.";
            break; 
        case 10:
            result = @"Life is a journey not a destination";
            break;      
        default:
            result= @"I don't know where I'm going, but I'm on my way.";
    }
    
    return result;
}






@end
