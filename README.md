# URLImageCache

[![CI Status](http://img.shields.io/travis/Joakim Gyllstrom/URLImageCache.svg?style=flat)](https://travis-ci.org/Joakim Gyllstrom/URLImageCache)
[![Version](https://img.shields.io/cocoapods/v/URLImageCache.svg?style=flat)](http://cocoapods.org/pods/URLImageCache)
[![License](https://img.shields.io/cocoapods/l/URLImageCache.svg?style=flat)](http://cocoapods.org/pods/URLImageCache)
[![Platform](https://img.shields.io/cocoapods/p/URLImageCache.svg?style=flat)](http://cocoapods.org/pods/URLImageCache)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.<br />
Fetch an image:
```swift
URLImageCache.imageForURL(imageURL, completion: { (image) -> () in
  // Do something with image?
})
```

Using the UIImageView extension
```swift
import URLImageCache
// Set image with an URL
imageView.bs_setImageWithURL(imageURL)

// Use an optional placeholder while fetching
imageView.bs_setImageWithURL(imageURL, placeholder: UIImage(named: "troll"))
```


## Requirements

## Installation

Using cocoapods...if I push the podspec to trunk.

## Author

Joakim Gyllström, joakim@backslashed.se

## License

URLImageCache is available under the MIT license. See the LICENSE file for more info.
