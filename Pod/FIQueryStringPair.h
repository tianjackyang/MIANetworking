//
//  FIQueryStringPair.h
//  FICorpUMSApp
//

#import <Foundation/Foundation.h>

extern NSArray * AFQueryStringPairsFromDictionary(NSDictionary *dictionary);
extern NSArray * AFQueryStringPairsFromKeyAndValue(NSString *key, id value);
extern NSString * FIQueryStringFromParametersWithEncoding(NSDictionary *parameters, NSStringEncoding stringEncoding);

@interface FIQueryStringPair : NSObject
@property (readwrite, nonatomic, strong) id field;
@property (readwrite, nonatomic, strong) id value;

- (id)initWithField:(id)field value:(id)value;

- (NSString *)URLEncodedStringValueWithEncoding:(NSStringEncoding)stringEncoding;

@end
