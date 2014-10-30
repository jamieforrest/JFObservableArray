//
//  JFObservableArrayTests.m
//  JFObservableArrayTests
//
//  Created by Jamie Forrest on 10/29/14.
//  Copyright (c) 2014 Jamie Forrest. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <JFObservableArray/JFObservableArray.h>
#import <OCMock/OCMock.h>

@interface DummyObserver : NSObject

@property (nonatomic, strong) NSDictionary *change;

@end

@implementation DummyObserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.change = change;
    NSLog(@"%@.%@ changed to %@", object, keyPath, change);
}

@end

@interface JFObservableArrayTests : XCTestCase

@property (nonatomic, strong) JFObservableArray *array;
@property (nonatomic, strong) DummyObserver *observer;
@property (nonatomic, strong) id observerMock;


@end

@implementation JFObservableArrayTests

- (void)setUp
{
    [super setUp];
    self.array = [[JFObservableArray alloc] initWithArray:@[]];
    self.observer = [DummyObserver new];
    [self addObserver:self.observer forKeyPath:@"array.self" options:NSKeyValueObservingOptionNew context:nil];
    self.observerMock = OCMPartialMock(self.observer);
}

- (void)tearDown
{
    [self removeObserver:self.observer forKeyPath:@"array.self"];
}

- (void)testObjectsCount
{
    JFObservableArray *array = [[JFObservableArray alloc] initWithArray:@[[NSObject new], [NSObject new], [NSObject new], [NSObject new]]];
    XCTAssertEqual(array.count, 4);
}

- (void)testAddObject
{
    JFObservableArray *array = [[JFObservableArray alloc] initWithArray:@[]];
    XCTAssertEqual(array.count, 0);
    NSObject *obj = [NSObject new];
    [array addObject:obj];
    XCTAssertEqual(array.count, 1);
    XCTAssertEqual([array objectAtIndex:0], obj);
}

- (void)testRemoveObject
{
    NSObject *obj1 = [NSObject new];
    NSObject *obj2 = [NSObject new];
    
    JFObservableArray *array = [[JFObservableArray alloc] initWithArray:@[obj1, obj2, [NSObject new], [NSObject new]]];
    
    [array removeObject:obj1];
    XCTAssertEqual(array.count, 3);
    XCTAssertEqual([array objectAtIndex:0], obj2);
}

- (void)testInsertObject
{
    NSObject *obj1 = [NSObject new];
    NSObject *obj2 = [NSObject new];
    NSObject *obj3 = [NSObject new];
    
    JFObservableArray *array = [[JFObservableArray alloc] initWithArray:@[obj1, obj3, [NSObject new]]];
    [array insertObject:obj2 atIndex:1];
    
    XCTAssertEqual([array objectAtIndex:0], obj1);
    XCTAssertEqual([array objectAtIndex:1], obj2);
    XCTAssertEqual([array objectAtIndex:2], obj3);
}

- (void)testReplaceObject
{
    NSObject *obj1 = [NSObject new];
    JFObservableArray *array = [[JFObservableArray alloc] initWithArray:@[[NSObject new], [NSObject new], [NSObject new], [NSObject new]]];
    [array replaceObjectAtIndex:1 withObject:obj1];
    XCTAssertEqual(array.count, 4);
    XCTAssertEqual([array objectAtIndex:1], obj1);
}

- (void)testKvoTriggersOnNewArray
{
    self.array = [[JFObservableArray alloc] init];
    [self verifyKvo];
}

- (void)testKvoTriggersOnAddObject
{
    [self.array addObject:[NSObject new]];
    [self verifyKvo];
    
    XCTAssertEqual([[self.observer.change valueForKey:NSKeyValueChangeIndexesKey] firstIndex], 0);
    
    
    [self.array addObject:[NSObject new]];
    XCTAssertEqual([[self.observer.change valueForKey:NSKeyValueChangeIndexesKey] firstIndex], 1);
    XCTAssertEqual([[self.observer.change valueForKey:NSKeyValueChangeKindKey] integerValue], NSKeyValueChangeInsertion);
}

- (void)testKvoTriggersOnRemoveObject
{
    NSObject *obj = [NSObject new];
    self.array = [[JFObservableArray alloc] initWithArray:@[[NSObject new], [NSObject new], obj, [NSObject new]]];
    [self.array removeObject:obj];
    [self verifyKvo];
    XCTAssertEqual([[self.observer.change valueForKey:NSKeyValueChangeIndexesKey] firstIndex], 2);
    XCTAssertEqual([[self.observer.change valueForKey:NSKeyValueChangeKindKey] integerValue], NSKeyValueChangeRemoval);
}

- (void)testKvoTriggersOnInsertObject
{
    NSObject *obj = [NSObject new];
    self.array = [[JFObservableArray alloc] initWithArray:@[[NSObject new], [NSObject new], [NSObject new]]];
    [self.array insertObject:obj atIndex:1];
    [self verifyKvo];
    XCTAssertEqual([[self.observer.change valueForKey:NSKeyValueChangeIndexesKey] firstIndex], 1);
    XCTAssertEqual([[self.observer.change valueForKey:NSKeyValueChangeKindKey] integerValue], NSKeyValueChangeInsertion);
}

- (void)testKvoTriggersOnReplaceObject
{
    NSObject *obj = [NSObject new];
    self.array = [[JFObservableArray alloc] initWithArray:@[[NSObject new], [NSObject new], [NSObject new]]];
    [self.array replaceObjectAtIndex:1 withObject:obj];
    [self verifyKvo];
    XCTAssertEqual([[self.observer.change valueForKey:NSKeyValueChangeIndexesKey] firstIndex], 1);
    XCTAssertEqual([[self.observer.change valueForKey:NSKeyValueChangeKindKey] integerValue], NSKeyValueChangeReplacement);
}

- (void)verifyKvo
{
    OCMVerify([self.observerMock observeValueForKeyPath:@"array.self"
                                               ofObject:self
                                                 change:OCMOCK_ANY context:nil]);
}

@end
