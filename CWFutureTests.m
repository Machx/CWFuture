//
//  CWFutureTests.m
//  ObjC_Playground
//
//  Created by Colin Wheeler on 2/28/13.
//  Copyright (c) 2013 Colin Wheeler. All rights reserved.
//

#import "CWFutureTests.h"
#import "CWFuture.h"
#import "CWBlockNotificationCenter.h"

CWFuture *future = nil;

SpecBegin(CWFuture)

beforeAll(^{
	future = [CWFuture futureWithBlock:^id{ return @(3 + 1); }];
	
	it(@"should return NO when the future value hasn't been resolved", ^{
		expect([future futureResolved]).to.beFalsy();
	});
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
