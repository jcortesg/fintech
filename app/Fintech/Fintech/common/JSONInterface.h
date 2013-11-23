#import <Foundation/Foundation.h>
#import "EnumDefs.h"
#import "ApiDataException.h"


@interface JSONInterface : NSObject {
    __weak id           delegate;
 	NSMutableData     * receivedData;
    SEL                 callback;
    SEL                 callback_array;
    NSString          * host;
    NSString          * shost;
    NSURLConnection   * last_connection;
}

@property (nonatomic,retain) NSMutableData   * receivedData;
@property (nonatomic, assign) SEL              callback;
@property (nonatomic, assign) SEL              callback_array;
@property (weak)   id                          delegate;
@property (strong) NSString                  * host;
@property (strong) NSString                  * shost;
@property (strong) NSURLConnection           * last_connection;


-(NSDictionary *)   json_to_dict    :(NSData *)   data;
-(NSArray*)         json_to_array   :(NSData *)   data;
-(void)             do_post         :(NSString *) requested_path
                                    :(NSString *) args
                                    :(NSData *)   body;

-(void)             do_get          :(NSString *) requested_path
                                    :(NSString *) args;
-(void)             cancel_last;

@end
