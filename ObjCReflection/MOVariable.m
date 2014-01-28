//
//  MOVariable.m
//  ObjCReflection
//
//  Created by Marcin Olawski on 11-08-05.
//  Copyright (c) 2014 Marcin Olawski. All rights reserved.
//

#import "MOVariable.h"

@implementation MOVariable
{
    Ivar _ivar;
}

- (id)initWithIvar:(Ivar)ivar{
    if (self = [super init])
        _ivar = ivar;
    return self;
}

- (NSString*)name{
    return [NSString stringWithUTF8String:ivar_getName(_ivar)];
}

- (NSString*)encoding{
    return [NSString stringWithUTF8String:ivar_getTypeEncoding(_ivar)];
}


#pragma mark - Read Values

- (void*) pointerToVariable:(id)object{
    return (void*)((__bridge void*)object + ivar_getOffset(_ivar));
}

- (id)idValue:(id)object{
    return object_getIvar(object, _ivar);
}

- (NSInteger) integerValue:(id)object{
    return *((NSInteger*)[self pointerToVariable:object]);
}

- (NSUInteger) unsignedIntegerValue:(id)object{
    return *((NSUInteger*)[self pointerToVariable:object]);
}

#pragma mark - Set Values

- (void)setIdValue:(id)value forObject:(id)object{
    object_setIvar(object, _ivar, value);
}

- (void)setIntValue:(int)value forObject:(id)object{
    int* v = [self pointerToVariable:object];
    *v = value;
}

#pragma mark Copying

- (void)copyPrimitiveValueFrom:(id)sourceObject to:(id)destinationObject{
    void* src = [self pointerToVariable:sourceObject];
    void* dest= [self pointerToVariable:destinationObject];
    MOType* type = [self type];
    
    if([type isEqual:[MOType integerType]]){
        *((int*)dest) = *((int*)src);
    }else
        [NSException raise:@"CRunTimeException" format:@"copyPrimitiveValueFrom:to:, unsupported type: %@",self.encoding];
}

- (void)copyValueFrom:(id)sourceObject to:(id)destinationObject{
    if(self.type.isPrimitive){
        [self copyPrimitiveValueFrom:sourceObject to:destinationObject];
        return;
    }
    
    id srcVal = [self idValue:sourceObject];
    id dstVal;
    [self idValue:destinationObject];
    if ([srcVal conformsToProtocol:@protocol(NSCopying)])
        dstVal = [srcVal copy];
    else
        dstVal = srcVal;
    [self setIdValue:dstVal forObject:destinationObject];
}

#pragma mark - Properties

- (MOType*) type{
    return [MOType typeWithEncoding:self.encoding];
}

#pragma mark -

- (NSString*)description{
    return self.name;
}


@end
