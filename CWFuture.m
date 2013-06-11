/*
//  CWFuture.m
//  ObjC_Playground
//
//  Created by Colin Wheeler on 2/26/13.

Copyright (c) 2013, Colin Wheeler
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

 - Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

 - Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import "CWFuture.h"

typedef id (^CWFutureBlock)(void);

@interface CWFuture ()
@property (nonatomic, copy) CWFutureBlock future_block;
@property (nonatomic, retain) id resolvedValue;
@end

@implementation CWFuture

+(id)futureWithBlock:(CWFutureBlock)block {
	/**
	 Designated method for returning new CWFuture instances. 
	 As such if the block is nil then there is no point in 
	 returning a new future instance.
	 */
	if(block == nil) {
		NSLog(@"%s %s %i: Block argument is nil! Returning nil",
			  __PRETTY_FUNCTION__,__FILE__,__LINE__);
		return nil;
	}
	CWFuture *future = [[CWFuture alloc] initWithFutureBlock:block];
	return future;
}

-(id)initWithFutureBlock:(CWFutureBlock)block {
	self = [super init];
	if(self == nil) return nil;
	
	_future_block = block;
	
	return self;
}

-(id)resolveFuture {
	static dispatch_once_t once;
	dispatch_once(&once, ^{
		self.resolvedValue = self.future_block();
		self.future_block = nil;
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
