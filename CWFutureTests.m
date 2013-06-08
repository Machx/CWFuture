/*
//  CWFutureTests.m
//  ObjC_Playground
//
//  Created by Colin Wheeler on 2/28/13.

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

#import "CWFutureTests.h"
#import "CWFuture.h"

CWFuture *future = nil;

SpecBegin(CWFuture)

beforeAll(^{
	future = [CWFuture futureWithBlock:^id{ return @(3 + 1); }];
	
	it(@"should return NO when the future value hasn't been resolved", ^{
		expect([future futureResolved]).to.beFalsy();
	});
});

it(@"+futureWithBlock should return nil when passed nil", ^{
	expect([CWFuture futureWithBlock:nil]).to.beNil();
});

it(@"should capture an expression and return its result", ^{
	expect([future resolveFuture]).to.equal(@4);
});

it(@"should return the class of the resolved future value", ^{
	expect([future class] != [CWFuture class]).to.beTruthy();
});

it(@"should return the hash of the resolved future", ^{
	expect([future hash] == [[future resolveFuture] hash]).to.beTruthy();
});

it(@"should return if the resolved future is a member of a class", ^{
	expect([future isMemberOfClass:NSClassFromString(@"__NSCFNumber")]).to.beTruthy();
});

it(@"should return if the resolved future is a kind of a class", ^{
	expect([future isKindOfClass:NSClassFromString(@"NSNumber")]).to.beTruthy();
});

afterAll(^{
	it(@"should return YES when the future value has been resolved", ^{
		expect([future futureResolved]).to.beTruthy();
	});
});

SpecEnd
