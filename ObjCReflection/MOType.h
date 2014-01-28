//
//  MOType.h
//  ObjCReflection
//
//  Created by Marcin Olawski on 11-08-05.
//  Copyright (c) 2011 Marcin Olawski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOType : NSObject

@property (nonatomic,readonly) NSString* encoding;
@property (nonatomic,readonly) BOOL isPrimitive;

#pragma mark - init/dealloc

- (id)initWithEncoding:(NSString *)encoding;
- (id)initWithCEncoding:(const char *)encoding;

#pragma mark Convenience methods

+ (id)typeWithEncoding:(NSString*)encoding;
+ (id)typeWithCEncoding:(const char*)encoding;

#pragma mark - Primitive types

+ (MOType*) integerType;
+ (MOType*) unsignedIntegerType;


@end
