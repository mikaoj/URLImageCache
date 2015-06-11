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

public extension UIImageView {
    /**
    Set image
    - parameter imageURL: Image URL
    - parameter placeholder: Optional image to be used while fetching imageURL
    */
    func bs_setImageWithURL(imageURL: NSURL, placeholder: UIImage? = nil) {
        // Cancel any pending downloads
        ImageDownloader.cancelImageDownload(tag)
        
        // Check if we have a cached image
        if let image = ImageCache.imageForURL(imageURL) {
            self.image = image
        } else {
            // No image in cache
            // Set placeholder if we have one
            if let placeholder = placeholder {
                self.image = placeholder
            }
            
            // Download image
            let identifier = ImageDownloader.downloadImage(imageURL, completion: { [weak self] (image) -> () in
                if let image = image {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self?.image = image
                    })
                }
            })
            
            // Set download identifier as tag. So we can cancel it when reusing
            tag = identifier
        }
    }
}
