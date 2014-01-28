//
//  MOClass.m
//  ObjCReflection
//
//  Created by Marcin Olawski on 11-08-04.
//  Copyright (c) 2014 Marcin Olawski. All rights reserved.
//

#import "MOClass.h"
#import <objc/runtime.h>


@implementation MOClass
{
    Class _class;
}

#pragma mark - init

-(id)initWithClass:(Class)aClass{
    NSString* enc = [NSString stringWithFormat:@"@\"%@\"",NSStringFromClass(aClass)];
    if (self = [super initWithEncoding:enc])
        _class = aClass;
    return self;
}

- (id)initWithClassName:(NSString*)className{
    self = [self initWithClass:objc_getClass([className UTF8String])];
    return self;
}

- (id)initWithEncoding:(NSString *)encoding{
    encoding = [encoding stringByReplacingOccurrencesOfString:@"@" withString:@""];
    encoding = [encoding stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    self = [self initWithClassName:encoding];
    return self;
}

-(id)initWithCEncoding:(const char *)encoding{
    self = [self initWithEncoding:[NSString stringWithUTF8String:encoding]];
    return self;
}

#pragma mark - Convenience methods

+(id)classWithClass:(Class)aClass{
    return [[MOClass alloc]initWithClass:aClass];
}

+(id)classWithClassName:(NSString *)className{
    return [[MOClass alloc]initWithClassName:className];
}

+(id)classWithEncoding:(NSString *)encoding{
    return [[MOClass alloc]initWithEncoding:encoding];
}

#pragma mark -

- (NSArray*)instanceVariables{
    unsigned int numVariables = 0;
    Ivar* ivars = class_copyIvarList(_class, &numVariables);
    NSMutableArray* variables = [NSMutableArray arrayWithCapacity:numVariables];
    for(unsigned int i=0;i<numVariables;i++){
        MOVariable* variable = [[MOVariable alloc]initWithIvar:ivars[i]];
        [variables addObject:variable];
    }
    free(ivars);
    return variables;
}

- (MOVariable*)instanceVariable:(NSString *)variableName{
    Ivar ivar = class_getInstanceVariable(_class, [variableName UTF8String]);
    if (ivar==NULL)
        [NSException raise:@"CRunTimeException" format:@"Undefined variable"];
    return [[MOVariable alloc]initWithIvar:ivar];
}

- (MOClass*)superClass{
    return [MOClass classWithClass:class_getSuperclass(_class)];
}

- (id)allocateInstance{
    return [_class alloc];
}

- (NSString*)description{
    return NSStringFromClass(_class);
}


@end

#pragma mark - NSObject Extension

@implementation NSObject (MO)

- (MOClass*)moClass{
    return [MOClass classWithClass:self.class];
}

@end
