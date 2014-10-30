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
- (NSArray *)objectsCopy;
- (NSUInteger)count;
- (NSArray *)objectsMatchingPredicate:(NSPredicate *)predicate;
- (id)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id)anObject;
- (void)addObject:(id)anObject;
- (void)removeObject:(id)anObject;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end
