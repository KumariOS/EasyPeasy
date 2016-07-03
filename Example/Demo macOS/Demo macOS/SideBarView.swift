// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import AppKit
import EasyPeasy

class SideBarView: NSView {
    
    private lazy var profileImageView: NSImageView = {
        let imageView = NSImageView(frame: CGRectZero)
        return imageView
    }()
    
    private lazy var composeImageView: NSImageView = {
        let imageView = NSImageView(frame: CGRectZero)
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.setup()
    }
    
    override func drawRect(dirtyRect: NSRect) {
        NSColor.easy_backgroundBlue().setFill()
        NSRectFill(dirtyRect)
        super.drawRect(dirtyRect)
    }
    
    override func layout() {
        super.layout()
        self.profileImageView.layer?.cornerRadius = 4.0
        self.profileImageView.layer?.masksToBounds = true
    }
    
    // MARK: Public methods
    
    func configure(with profileImage: String, tabs: String...) {
        self.restore()
        self.profileImageView.image = NSImage(named: profileImage)
        self.composeImageView.image = NSImage(named: "icon-compose")
        
        var previousItem: NSView = self.profileImageView
        var topPadding: CGFloat = 20.0
        
        for tabImage in tabs {
            let tab = NSImageView(frame: CGRectZero)
            tab.image = NSImage(named: tabImage)
            
            self.addSubview(tab)
            tab <- [
                Size(33.0),
                CenterX(0.0),
                Top(topPadding).to(previousItem)
            ]
            
            previousItem = tab
            topPadding = 14.0
        }
    }
    
    // MARK: Private methods
    
    private func setup() {
        self.addSubview(self.profileImageView)
        self.profileImageView <- [
            Size(46.0),
            Top(60.0),
            CenterX(0.0)
        ]
        
        self.addSubview(self.composeImageView)
        self.composeImageView <- [
            Size(33.0),
            Bottom(20.0),
            CenterX(0.0)
        ]
    }
    
    private func restore() {
        let tabs = self.subviews.filter { $0 !== self.profileImageView  && $0 !== self.composeImageView }
        for tab in tabs {
            tab.removeFromSuperview()
        }
    }
    
}
