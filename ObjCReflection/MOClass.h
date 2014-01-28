//
//  MOClass.h
//  ObjCReflection
//
//  Created by Marcin Olawski on 11-08-04.
//  Copyright (c) 2014 Marcin Olawski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOType.h"
#import "MOVariable.h"

@interface MOClass : MOType

@property (nonatomic,readonly) NSArray* instanceVariables;
@property (nonatomic,readonly) MOClass* superClass;

#pragma mark - init/dealloc

-(id)initWithClass:(Class)aClass;
-(id)initWithClassName:(NSString*)className;

#pragma mark - Convenience methods

+(id)classWithClass:(Class)aClass;
+(id)classWithClassName:(NSString*)className;
+(id)classWithEncoding:(NSString*)encoding;

#pragma mark -

- (MOVariable*)instanceVariable:(NSString*)variableName;
- (NSArray*)instanceVariables;
- (id)allocateInstance;


@end


#pragma mark - NSObject Extension

@interface NSObject (MO)

@property(nonatomic,readonly) MOClass* moClass;


@end
