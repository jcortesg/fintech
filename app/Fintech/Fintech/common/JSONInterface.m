
#import "JSONInterface.h"


@implementation JSONInterface

@synthesize receivedData;
@synthesize callback;
@synthesize callback_array;
@synthesize delegate;

@synthesize host;
@synthesize shost;
@synthesize last_connection;


-(id)init {
    
    self = [super init];
    
    // Default host set to google :)
    self.host = URL_REST_SERVICES;
    self.shost = URL_SEC_REST_SERVICES;
    
    return self;
}


-(void) do_post :(NSString *)requested_path
                :(NSString *)args
                :(NSData *)body {
	
    
    NSString *urlFormed;

    if (args) {
        urlFormed=[NSString stringWithFormat:@"%@?%@",requested_path,args];
    } else {
        urlFormed=[NSString stringWithFormat:@"%@",requested_path];
    }
    
    NSLog(@"URL Formed ---> %@",urlFormed);
    
	// make a synchronous HTTP request to your plist API
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlFormed]];
	
    self.receivedData = [[NSMutableData alloc] init];
    
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:body];
	[request setTimeoutInterval:30.0];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];

    
    NSLog(@"Authorization: %@",[request valueForHTTPHeaderField:@"Authorization"]);
    
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
																  delegate:self
														  startImmediately:YES];

	
	[connection start];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    self.last_connection = connection;

}
// server GET HTTP Method
- (void)do_get:(NSString *)requested_path
              :(NSString *)args {

    NSString *urlFormed;
    
    // Absolute URL
    if ([requested_path hasPrefix:@"http"]) {
        
        if (args) {
            urlFormed=[NSString stringWithFormat:@"%@?%@",requested_path,args];
        } else {
            urlFormed=[NSString stringWithFormat:@"%@",requested_path];
        }
        
    } else { // Relative URL
        if (args) {
            urlFormed=[NSString stringWithFormat:@"%@/%@%@?%@",
                       host,API_VERSION,requested_path,args];
        } else {
            urlFormed=[NSString stringWithFormat:@"%@/%@%@",
                       host,API_VERSION,requested_path];
        }
    }
    
    NSString* encodedUrl = [urlFormed stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];

    NSLog(@"URL formed ---> %@",urlFormed);
    
	NSURL *url = [NSURL URLWithString:encodedUrl]; 
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
	
    self.receivedData = [[NSMutableData alloc] init];
    
	[request setHTTPMethod:@"GET"];
	[request setTimeoutInterval:30.0];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];	
	[request setValue:@"application/vnd.wehostels.com;version=1" forHTTPHeaderField:@"Accept"];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
																  delegate:self
														  startImmediately:YES];
    
	
	[connection start];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    self.last_connection = connection;
    
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                 willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    NSCachedURLResponse *newCachedResponse = cachedResponse;

    if ([[[[cachedResponse response] URL] scheme] isEqual:@"https"]) {
        newCachedResponse = nil;
    } else {
        NSDictionary *newUserInfo;
        newUserInfo = [NSDictionary dictionaryWithObject:[NSDate date]
                                                  forKey:@"Cached Date"];
        
        newCachedResponse = [[NSCachedURLResponse alloc]
                              initWithResponse:[cachedResponse response]
                              data:[cachedResponse data]
                              userInfo:newUserInfo
                              storagePolicy:[cachedResponse storagePolicy]];
    }
    return newCachedResponse;
}
- (NSDictionary *)json_to_dict :(NSData *)data {
    
	NSError  *error;
    
    // PARSE json response
    NSMutableDictionary* json_nulls = [NSJSONSerialization
                          JSONObjectWithData:data //1
                          options:NSJSONReadingMutableContainers 
                          error:&error];
    
    
    if (error) {
        [NSException raise:@"Parse Error" format:@"desc: %@", error];
    }
    
    return json_nulls;
    
}

- (NSArray *)json_to_array :(NSData *)data {
    
	NSError  *error;
    
        // PARSE json response
    NSArray* json_nulls = [NSJSONSerialization
                                JSONObjectWithData:data //1
                                options:kNilOptions
                                error:&error];
    
    
    if (error) {
        [NSException raise:@"Parse Error" format:@"desc: %@", error];
    }
    
    return json_nulls;
    
}

// CALLBACKS FOR SSL
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
	
	NSLog(@"Can AUTH?");
	
	return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

// CALLBACK FOR SSL
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	
	NSLog(@"Challenge called");

	[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
	
	[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    //[connection release];
	NSLog(@"Error in connection: %@",error);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

 	if ([delegate respondsToSelector:@selector(requestDidFail:)]) {
        
        // Reset buffer
        [receivedData setLength:0];
                
        NSMutableDictionary * errorDesc = [[NSMutableDictionary alloc] init];
        
        [errorDesc setObject:[error localizedDescription] forKey:@"msg"];
        [errorDesc setObject:[error localizedDescription] forKey:@"debug_description"];
        
 		[delegate performSelector:@selector(requestDidFail:) withObject:errorDesc];
        
 	}
    
}

// DATA RECEIVED FOR LOGIN
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)plistData {
		
    [receivedData appendData:plistData];
		
}

// Connection finished and return values
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
 	
 	// NSString *dataStr=[[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
    // NSLog(@"Response to -> %@: %@", delegate, dataStr);
        
 	if ([delegate respondsToSelector:callback]||[delegate respondsToSelector:callback_array]) {
        
        @try {
            
            // IF fails here, it's a parsing error
            if([delegate respondsToSelector:callback])
            {
                NSDictionary *resp = [self json_to_dict:receivedData];

                // Check login Errors on API
                if ([resp isKindOfClass:[NSDictionary class]] && [resp objectForKey:@"error"]) {
                    [ApiDataException raise:[resp objectForKey:@"error"] format:[resp objectForKey:@"error"],nil];
                }
            
                // NSLog(@"Calling the delegate"); 
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [delegate performSelector:callback withObject:(NSDictionary*)resp];
#pragma clang diagnostic pop

            } else if([delegate respondsToSelector:callback_array]) {

                NSArray *resp=[self json_to_array:receivedData];
            
                // NSLog(@"Calling the delegate");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [delegate performSelector:callback_array withObject:(NSArray*)resp];
#pragma clang diagnostic pop
                       
            }
            
            if([delegate respondsToSelector:@selector(requestFinishLoad)])
            {
                [delegate performSelector:@selector(requestFinishLoad) withObject:nil];
            }
            
        } @catch (ApiDataException *apiException) {

            if ([delegate respondsToSelector:@selector(requestDidFail:)]) {
                
                NSMutableDictionary * errorDesc = [[NSMutableDictionary alloc] init];

                [errorDesc setObject:[apiException debugDescription] forKey:@"msg"];
                [errorDesc setObject:[apiException debugDescription] forKey:@"debug_description"];
                [errorDesc setObject:[[[apiException callStackSymbols] subarrayWithRange:NSMakeRange(0, 15)] componentsJoinedByString:@"\n"] forKey:@"stack_trace"];
                [errorDesc setObject:NSStringFromSelector(callback)  forKey:@"callback"];

                // NSLog(@"Calling the delegate");
                [delegate performSelector:@selector(requestDidFail:) withObject:errorDesc];
                
            }
            
        } @catch (NSException *exception) {
                        
            NSString *dataStr = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
            
            NSLog(@"Error parsing: %@", [exception debugDescription]);
            NSLog(@"RAW Response to %@ (%@): %@ ", delegate, NSStringFromSelector(callback),dataStr);
            NSLog(@"Stack trace: %@",[[[exception callStackSymbols] subarrayWithRange:NSMakeRange(0, 15)] componentsJoinedByString:@"\n"]);
            
            if ([delegate respondsToSelector:@selector(requestDidFail:)]) {
                
                NSMutableDictionary * errorDesc = [[NSMutableDictionary alloc] init];
                
                NSString *msg = @"Service unavailable. Try again in a few minutes.";

                [errorDesc setObject:msg forKey:@"msg"];
                [errorDesc setObject:[exception debugDescription] forKey:@"debug_description"];
                [errorDesc setObject:[[[exception callStackSymbols] subarrayWithRange:NSMakeRange(0, 15)] componentsJoinedByString:@"\n"] forKey:@"stack_trace"];
                
                // NSLog(@"Calling the delegate"); 
                [delegate performSelector:@selector(requestDidFail:) withObject:errorDesc];
                                
            }

        }
                
        // Reset buffer
        [receivedData setLength:0];

 	}
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

 	
}

- (void)cancel_last {
    if (self.last_connection != nil) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [self.last_connection cancel];
    }
}

- (void)dealloc {
	NSLog(@"JSONInterface dealloc");
}

@end
