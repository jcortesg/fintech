//
//  EnumDefs.h
//  WeHostels
//
//  Created by John Torres on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#include <sys/types.h>
#include <sys/sysctl.h>


@interface EnumDefs : NSObject

+ (NSString *) md5:(NSString *) input;
+ (NSString *) dateFormatterISO8601:(NSDate *)date;
+ (NSString *) platformString;
+ (NSString *) randomString;


#define API_VERSION             @"v4"
#define ABOUT_US                @"http://m.wehostels.com/about-us-app"

#ifdef DEBUG

#define MODE_RUN                @"DEBUG"
#define URL_REST_SERVICES       @"http://api.inbed-st.com"
#define URL_SEC_REST_SERVICES   @"https://secure.inbed-st.com"
#define API_TOKEN               @"37f4fc2d8e0c63113b98f9a9e03c8b0b"
#define API_SECRET              @"bff8505b0a6075db5f29c522a0224329"
#define FB_APP_ID               @"481786058528960"
#define MIX_PANEL_TOKEN         @"6522c412a8843bf92170852b3c0bdf63"
#define SHOW_DEBUG_BAR          1

#else

#define MODE_RUN                @"RELEASE"
#define URL_REST_SERVICES       @"http://api.wehostels.com"
#define URL_SEC_REST_SERVICES   @"https://secure.wehostels.com"
#define API_TOKEN               @"33104d6d46f0a824782dbe1e885323d6"
#define API_SECRET              @"5e339838b072afc02d45fa8bab6f99ad"
#define FB_APP_ID               @"120971754653035"
#define MIX_PANEL_TOKEN         @"9ea8c00e6bfca73cbf30c83952f899cc"

#endif





@end
