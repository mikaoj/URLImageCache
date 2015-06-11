// The MIT License (MIT)
//
// Copyright (c) 2015 Joakim Gyllström
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

internal class ImageCache {
    private static let sharedCache = ImageCache()
    private let imageCache = NSCache()
    
    /**
    Fetches images for a given URL from the cache
    - parameter url: URL for the image
    */
    class func imageForURL(url: NSURL) -> UIImage? {
        return sharedCache.imageCache.objectForKey(url) as? UIImage
    }
    
    /**
    Caches an image for a given URL.
    - parameter image: The image to cache
    - parameter imageURL: URL for the image
    */
    class func cacheImage(image: UIImage, forURL imageURL: NSURL) {
        sharedCache.imageCache.setObject(image, forKey: imageURL)
    }
}
