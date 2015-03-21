**CleanFrameView** is a content view for borderless NSWindow, that allows you to precisely control it appearance.

Here is the sample. First window uses standart borderless appearance:

![Standart borderless NSWindow](https://raw.github.com/dmitrynikolaev/CleanFrameView/master/standart.png)

Next window uses CleanFrameView, so you can adopt shadow intensity and stroke length for it:

![CleanFrameView](https://raw.github.com/dmitrynikolaev/CleanFrameView/master/cleanframeview.png)

### How to use CleanFrameView

1\. Import the framework:
```swift
@import CleanFrameView
```
2\. Set up `CleanFrameView` as a content view for your window:

```swift
self.contentView = CleanFrameView(frame: NSZeroRect)
```

### License

The MIT License (MIT)

Copyright (c) 2015 Dmitry Nikolaev http://dmitrynikolaev.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
