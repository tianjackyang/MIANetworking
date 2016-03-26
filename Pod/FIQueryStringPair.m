//
//  FIQueryStringPair.m
//  FICorpUMSApp
//

#import "FIQueryStringPair.h"

@implementation FIQueryStringPair

static NSString * const kFICharactersToBeEscapedInQueryString = @":/?&=;+!@#$()',*";

static NSString * FIPercentEscapedQueryStringKeyFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    static NSString * const kFICharactersToLeaveUnescapedInQueryStringPairKey = @"[].";
    
    return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, (__bridge CFStringRef)kFICharactersToLeaveUnescapedInQueryStringPairKey, (__bridge CFStringRef)kFICharactersToBeEscapedInQueryString, CFStringConvertNSStringEncodingToEncoding(encoding));
}

static NSString * FIPercentEscapedQueryStringValueFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)kFICharactersToBeEscapedInQueryString, CFStringConvertNSStringEncodingToEncoding(encoding));
}

- (id)initWithField:(id)field value:(id)value {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.field = field;
    self.value = value;
    
    return self;
}

- (NSString *)URLEncodedStringValueWithEncoding:(NSStringEncoding)stringEncoding
{
    if (!self.value || [self.value isEqual:[NSNull null]]) {
        return FIPercentEscapedQueryStringKeyFromStringWithEncoding([self.field description], stringEncoding);
    } else {
        return [NSString stringWithFormat:@"%@=%@", FIPercentEscapedQueryStringKeyFromStringWithEncoding([self.field description], stringEncoding), FIPercentEscapedQueryStringValueFromStringWithEncoding([self.value description], stringEncoding)];
    }
}

NSString * FIQueryStringFromParametersWithEncoding(NSDictionary *parameters, NSStringEncoding stringEncoding)
{
    NSMutableArray *mutablePairs = [NSMutableArray array];
    for (FIQueryStringPair *pair in FIQueryStringPairsFromDictionary(parameters)) {
        if (![pair URLEncodedStringValueWithEncoding:stringEncoding]) {
            
        }
        else{
            [mutablePairs addObject:[pair URLEncodedStringValueWithEncoding:stringEncoding]];
        }
    }
    
    return [mutablePairs componentsJoinedByString:@"&"];
}

NSArray * FIQueryStringPairsFromDictionary(NSDictionary *dictionary)
{
    return FIQueryStringPairsFromKeyAndValue(nil, dictionary);
}

NSArray * FIQueryStringPairsFromKeyAndValue(NSString *key, id value)
{
    NSMutableArray *mutableQueryStringComponents = [NSMutableArray array];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(compare:)];
    
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = value;
        // Sort dictionary keys to ensure consistent ordering in query string, which is important when deserializing potentially ambiguous sequences, such as an array of dictionaries
        for (id nestedKey in [dictionary.allKeys sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            id nestedValue = [dictionary objectForKey:nestedKey];
            if (nestedValue) {
                [mutableQueryStringComponents addObjectsFromArray:FIQueryStringPairsFromKeyAndValue((key ? [NSString stringWithFormat:@"%@[%@]", key, nestedKey] : nestedKey), nestedValue)];
            }
        }
    } else if ([value isKindOfClass:[NSArray class]]) {
        NSArray *array = value;
        for (id nestedValue in array) {
            [mutableQueryStringComponents addObjectsFromArray:FIQueryStringPairsFromKeyAndValue([NSString stringWithFormat:@"%@[]", key], nestedValue)];
        }
    } else if ([value isKindOfClass:[NSSet class]]) {
        NSSet *set = value;
        for (id obj in [set sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            [mutableQueryStringComponents addObjectsFromArray:FIQueryStringPairsFromKeyAndValue(key, obj)];
        }
    } else {
        [mutableQueryStringComponents addObject:[[FIQueryStringPair alloc] initWithField:key value:value]];
    }
    
    return mutableQueryStringComponents;
}

@end
