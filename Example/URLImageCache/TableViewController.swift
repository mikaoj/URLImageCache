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

import UIKit
import URLImageCache

class TableViewController: UITableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("randomCell", forIndexPath: indexPath) as! ImageTableViewCell
        
        let imageSize = cell.largeImageView.bounds
        cell.largeImageView.image = nil
        
        if let imageURL = NSURL(string: "http://placehold.it/\(Int(imageSize.width*4)+indexPath.row)x\(Int(imageSize.height*4)+indexPath.row)") {
            cell.largeImageView?.bs_setImageWithURL(imageURL, placeholder: UIImage(named: "troll"))
        }
        
        return cell
    }
}

