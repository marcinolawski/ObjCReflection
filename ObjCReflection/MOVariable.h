//
//  MOVariable.h
//  ObjCReflection
//
//  Created by Marcin Olawski on 11-08-05.
//  Copyright (c) 2014 Marcin Olawski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "MOType.h"

@interface MOVariable : NSObject

@property (nonatomic,readonly) NSString* name;
@property (nonatomic,readonly) NSString* encoding;
@property (nonatomic,readonly) MOType* type;

- (id)initWithIvar:(Ivar)ivar;

#pragma mark - Accessing Values

- (void*) pointerToVariable:(id)object;
- (id)idValue:(id)object;
- (NSInteger) integerValue:(id)object;
- (NSUInteger) unsignedIntegerValue:(id)object;

#pragma mark - Set Values

- (void)setIdValue:(id)value forObject:(id)object;
- (void)setIntValue:(int)value forObject:(id)object;

#pragma mark Copying

- (void)copyValueFrom:(id)sourceObject to:(id)destinationObject;

@end
