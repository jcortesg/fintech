//
//  WHInterface.m
//  WeHostels
//

#import "LDInterface.h"

@implementation LDInterface

-(id) init {
    self = [super init];
    
    return self;
}



- (NSMutableData *)convert_to_body:(NSMutableDictionary *)params {
        
    NSMutableData *body = [NSMutableData data];


    
    for (id key in params) {
        NSLog(@" --> key: %@, value: %@", key, [params objectForKey:key]);
        
        NSString * part    = [NSString stringWithFormat:@"%@=%@&",
                            key,
                           [params objectForKey:key]
                           ];
        
        NSString * encpart = [part stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [body appendData:[encpart dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    return body;
    
}

- (NSString *)convert_to_args:(NSMutableDictionary *)params {

    
    NSMutableData *args = [NSMutableData data];

    
    for (id key in params) {
        NSLog(@" --> key: %@, value: %@", key, [params objectForKey:key]);
        NSString * part = [NSString stringWithFormat:@"%@=%@&",key,[params getString:key]];
        [args appendData:[part dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    NSString * url_args = [[NSString alloc] initWithData:args encoding:NSUTF8StringEncoding];

    return url_args;
    
}

-(void) getReverseGeo :(NSMutableDictionary *)params {
    /*
     * GET [VERSION]/hostels/:id/hostel_info.json
     */
    NSString * url = @"http://maps.googleapis.com/maps/api/geocode/json";
    
    NSString * args = [self convert_to_args:params];
    
	[self do_get  :url
                  :args];
    
}



@end
