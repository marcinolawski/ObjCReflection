//
//  MOType.m
//  ObjCReflection
//
//  Created by Marcin Olawski on 11-08-05.
//  Copyright (c) 2011 Marcin Olawski. All rights reserved.
//

#import "MOType.h"
#import "MOClass.h"

@implementation MOType


#pragma mark - init/dealloc

- (id)initWithEncoding:(NSString *)encoding{
    if (self = [super init]){
        _encoding = [encoding copy];
    }
    return self;
}

- (id)initWithCEncoding:(const char *)encoding{
    self = [self initWithEncoding:[NSString stringWithUTF8String:encoding]];
    return self;
}

#pragma mark Convenience methods

+ (id)typeWithEncoding:(NSString *)encoding{
    if( [encoding hasPrefix:@"@"] )
        return [MOClass classWithEncoding:encoding];
    else{
        if ([encoding isEqualToString:@"i"])
            return [MOType integerType];
        else if ([encoding isEqualToString:@"I"])
            return [MOType unsignedIntegerType];
        else
            return [[MOType alloc]initWithEncoding:encoding];
    }
}

+ (id)typeWithCEncoding:(const char*)encoding{
    return [MOType typeWithEncoding:[NSString stringWithUTF8String:encoding]];
}

#pragma mark -

- (BOOL)isEqual:(id)anObject{
    if (anObject==self)
        return YES;
    
    if (![anObject isKindOfClass:[MOType class]])
        return NO;
    
    return [_encoding isEqualToString:[(id)anObject encoding]];
}

- (BOOL)isPrimitive{
    return ![_encoding hasPrefix:@"@"];
}

#pragma mark - Primitive types

+ (MOType*) integerType{
    static MOType* constType = nil;
    if (!constType)
        constType = [[MOType alloc]initWithCEncoding:@encode(NSInteger)];
    return constType;
}

+ (MOType*) unsignedIntegerType{
    static MOType* constType = nil;
    if (!constType)
        constType = [[MOType alloc]initWithCEncoding:@encode(NSUInteger)];
    return constType;
}


@end
