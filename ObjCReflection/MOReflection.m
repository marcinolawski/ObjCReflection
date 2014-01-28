//
//  MOReflection.m
//  ObjCReflection
//
//  Created by Marcin Olawski on 11-08-05.
//  Copyright (c) 2011 Marcin Olawski. All rights reserved.
//

#import "MOReflection.h"


id MOCopyObject(id sourceObject){
    id (*NSObjectInit)(id, SEL);
    NSObjectInit = (id (*)(id, SEL))class_getMethodImplementation([NSObject class], @selector(init));
    id destinationObject = [[sourceObject moClass] allocateInstance];
    destinationObject = NSObjectInit(destinationObject,@selector(init));
    
    MOClass* nsObject = [MOClass classWithClass:[NSObject class]];
    MOClass* clazz = [sourceObject moClass];
    
    while( ![clazz isEqual:nsObject] ){
        for(MOVariable* var in clazz.instanceVariables){
            [var copyValueFrom:sourceObject to:destinationObject];
        }
        clazz = clazz.superClass;
    }
    
    return destinationObject;
}
