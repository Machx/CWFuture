//
//  CWFuture.m
//  ObjC_Playground
//
//  Created by Colin Wheeler on 2/26/13.
//  Copyright (c) 2013 Colin Wheeler. All rights reserved.
//

#import "CWFuture.h"

typedef id (^CWFutureBlock)(void);

@interface CWFuture ()
@property (nonatomic, assign) dispatch_once_t once;
@property (nonatomic, copy) CWFutureBlock future_block;
@property (nonatomic, retain) id resolvedValue;
@end

@implementation CWFuture

+(id)futureWithBlock:(id (^)(void))block {
	CWFuture *future = [CWFuture new];
	future.future_block = [block copy];
	return future;
}

-(id)resolveFuture {
	dispatch_once(&_once, ^{
		id returnedObject = self.future_block();
		self.resolvedValue = (returnedObject ?: nil);
		if (self.resolvedValue) self.future_block = nil;
	});
	return self.resolvedValue;
}

-(Class)class {
	return [[self resolveFuture] class];
}

-(Class)superclass {
	return [[self resolveFuture] superclass];
}

-(BOOL)isKindOfClass:(Class)aClass {
	return [[self resolveFuture] isKindOfClass:aClass];
}

-(BOOL)isMemberOfClass:(Class)aClass {
	return [[self resolveFuture] isMemberOfClass:aClass];
}

-(NSUInteger)hash {
	return [[self resolveFuture] hash];
}

-(BOOL)futureResolved {
	return ((BOOL)self.resolvedValue);
}

@end
