//
//  JFObservableArray.h
//  JFObservableArray
//
//  Created by Jamie Forrest on 10/29/14.
//  Copyright (c) 2014 Jamie Forrest. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for JFObservableArray.
FOUNDATION_EXPORT double JFObservableArrayVersionNumber;

//! Project version string for JFObservableArray.
FOUNDATION_EXPORT const unsigned char JFObservableArrayVersionString[];

@interface JFObservableArray : NSObject

- (instancetype)initWithArray:(NSArray *)array;
- (instancetype)initWithCapacity:(NSUInteger)numItems;

- (NSArray *)objectsCopy;
- (NSUInteger)count;
- (id)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id)anObject;

#pragma mark - Adding Objects
- (void)addObject:(id)anObject;
- (void)addObjectsFromArray:(NSArray *)array;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;

#pragma mark - Removing Objects
- (void)removeObject:(id)anObject;

#pragma mark - Replacing Objects
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

#pragma mark - Filtering Objects
- (NSArray *)filteredArrayUsingPredicate:(NSPredicate *)predicate;

@end
