Objective-C Reflection Framework 
==============

Objective-C Reflection Framework adds Java like reflections to Objective-C. 

Objective-C Reflection Framework makes it possible to: 
- Describes all instance variables declared by a class;
- Get/sets the value of any (private/public) instance variable in an object at runtime;
- Copy non NSCopying objects.

Usage
==============

```objective-c
#import <MOReflection.h>

@interface Foo : NSObject

@end

@implementation Foo
{
    int _myVeryPrivateInstanceVariable;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"_myVeryPrivateInstanceVariable = %d",_myVeryPrivateInstanceVariable];
}

@end

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        //Show all (public/private) Foo instance variables
        MOClass *fooClass = [MOClass classWithClassName:@"Foo"];
        for(MOVariable *var in [fooClass instanceVariables]){
            NSLog(@"%@",var.name);
        }
        
        //Dynamically allocate memory for fooClass object
        Foo *foo = [[fooClass allocateInstance] init];
        //Get PRIVATE ivar
        MOVariable *privateVariable = [[foo moClass] instanceVariable:@"_myVeryPrivateInstanceVariable"];
        //Modify private ivar
        [privateVariable setIntValue:13 forObject:foo];
        
        //Copy non NSCopying object
        Foo *foo2 = MOCopyObject(foo);
        NSLog(@"%@",foo2);
    }
    return 0;
}
```
