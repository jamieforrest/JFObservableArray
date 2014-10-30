# JFObservableArray

[![Version](https://img.shields.io/cocoapods/v/JFObservableArray.svg?style=flat)](http://cocoadocs.org/docsets/JFObservableArray)
[![License](https://img.shields.io/cocoapods/l/JFObservableArray.svg?style=flat)](http://cocoadocs.org/docsets/JFObservableArray)
[![Platform](https://img.shields.io/cocoapods/p/JFObservableArray.svg?style=flat)](http://cocoadocs.org/docsets/JFObservableArray)

## Usage

To run the tests, clone the repo, and run `pod install` from the Example directory first.

## Installation

`JFObservableArray` is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "JFObservableArray"

## Usage

`JFObservableArray` is a KVO-compliant array wrapper that informs observers of changes to the array's underlying structure. Clients can set up KVO as follows:
```
JFObservableArray *array = [JFObservableArray new];
[array addObserver:self forKeyPath:@"self" options:NSKeyValueObservingOptionNew context:nil];
```
And the changes can be observed as follows:
```
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    switch ([change[NSKeyValueChangeKindKey] integerValue]) {
        case NSKeyValueChangeInsertion: {
            // data was inserted at the indexes in change[NSKeyValueChangeIndexesKey]
            break;
        }
        case NSKeyValueChangeRemoval: {
            // data was removed at the indexes in change[NSKeyValueChangeIndexesKey]
            break;
        }
        case NSKeyValueChangeReplacement: {
            // data was replaced at the indexes in change[NSKeyValueChangeIndexesKey]
            break;
        }
        default:
            break;
        }
}
```

## Author

Jamie Forrest

## License

JFObservableArray is available under the MIT license. See the LICENSE file for more info.

