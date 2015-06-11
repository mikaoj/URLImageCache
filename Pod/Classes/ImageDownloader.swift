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

internal class ImageDownloader {
    private static let sharedDownloader = ImageDownloader()
    private var pendingTasks = [Int: NSURLSessionDownloadTask]()
    private let pendingTasksQueue = dispatch_queue_create("se.backslashed.imagecache", DISPATCH_QUEUE_CONCURRENT)
    
    /**
    Download an image to the cache
    - parameter imageURL: URL for the image
    - parameter completion: The block to be called when completion finished/failed
    */
    class func downloadImage(imageURL: NSURL, completion: (image: UIImage?) -> ()) -> Int {
        let taskIdentifier = imageURL.hashValue
        
        let task = NSURLSession.sharedSession().downloadTaskWithURL(imageURL) { (location: NSURL?, response: NSURLResponse?, error: NSError?) -> Void in
            // Remove from pending tasks
            dispatch_barrier_async(sharedDownloader.pendingTasksQueue, { () -> Void in
                sharedDownloader.pendingTasks.removeValueForKey(taskIdentifier)
            })
            
            if let location = location, let data = NSData(contentsOfURL: location), let image = UIImage(data: data) {
                // Store image in cache
                ImageCache.cacheImage(image, forURL: imageURL)
                
                // Call completion block
                completion(image: image)
            } else {
                // Failed to download image
                completion(image: nil)
            }
        }
        
        // Add to pending tasks
        if let task = task {
            dispatch_barrier_async(sharedDownloader.pendingTasksQueue, { () -> Void in
                sharedDownloader.pendingTasks[taskIdentifier] = task
            })
            
            // Start download
            task.resume()
        } else {
            // Failed to create task, call completion with nil image
            completion(image: nil)
        }
        
        // And return identifier
        return taskIdentifier
    }
    
    /**
    Cancel an ongoing image download
    - parameter identifier: The identifier returned when download started
    */
    class func cancelImageDownload(identifier: Int) {
        dispatch_barrier_async(sharedDownloader.pendingTasksQueue, { () -> Void in
            if let task = sharedDownloader.pendingTasks[identifier] {
                task.cancel()
            }
        })
    }
}
