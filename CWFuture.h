/*
//  CWFuture.h
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

#import <Foundation/Foundation.h>

/**
 CWFuture is a class that carries a future value in the form of an expression 
 returned from a block passed to it.
 
 The future value is always nil until the future value is queried and then the 
 value is resolved and the block destroyed. Calling -class, -superclass,
 -isKindOfClass, -isMemberOfClass, -hash all resolve the future value and 
 return the result as if you called that on the future value itself.
 */

@interface CWFuture : NSProxy <NSObject>

/**
 Returns a new CWFuture instance copying the block
 
 This method is the designated method for returning new CWFuture
 instances. If the block passed to it is nil, then this method
 logs an error message and returns nil.
 
 @param block The expression returned from this becomes the future value
 @return a new CWFuture instance
 */
+(instancetype)futureWithBlock:(id (^)(void))block;

/**
 Resolves the future and returns the value from the Future
 
 @return the blocks return value which is resolve
 */
-(id)resolveFuture;

/**
 Returns a BOOl indicating if the future has been resolved or not
 
 @return YES if the future has been resolved, NO otherwise
 */
-(BOOL)futureResolved;

@end
