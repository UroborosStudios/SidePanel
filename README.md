# SidePanel
Panels controllers for lateral menus

- [Features](#features)
- [Requirements](#requirements)
- [Communication](#communication)
- [Installation](#installation)
- [Usage](#usage)

## Features
- [x] Left and Right Panels
- [x] Navigation and TabBar controllers
- [x] Automatic control on close/open behaviours
- [x] Direct calls to controls without the need to import the module everywhere
- [x] Extensions for pop/dismiss controls

## Requirements
- iOS 8.0+ / macOS 10.10+
- Xcode 8.0+
- Swift 3.0+

## Communication
- If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/sidepanel). (Tag 'sidepanel')
- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/sidepanel).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build SidePanel 1.0.0.

To integrate SidePanel into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod ‘SidePanel’, :git => ‘https://github.com/UroborosStudios/SidePanel’, :tag => ‘1.0.0’
end
```

Then, run the following command:

```bash
$ pod install
```

## Usage

### Initilizing in App Delegate
To implement a left, right panel on your application you only have to put code like this on your **AppDelegate:didFinishLaunchingWithOptions**

```swift	
var left = UIStoryboard(name: "Name", bundle: nil).instantiateViewController(withIdentifier: "left") as? SideViewController
var right = UIStoryboard(name: "Name", bundle: nil).instantiateViewController(withIdentifier: "right") as? SideViewController
let main = UIStoryboard(name: "Name", bundle: nil).instantiateViewController(withIdentifier: "Main")
window = UIWindow(frame: UIScreen.main.bounds)
_ = ContainerViewController(window: &window!, rootView: main, navigationType: .Navigation, leftPanel: &left, rightPanel: &right)
```

You can set any UIViewController you want as **left** or **right** , the only thing you have to do is set the class on Storyboard as **SideViewController** . For the main VC. You only have to inherit from MainViewController and thats it.

### Toggle Panels
To open a panel, you only have to call the method **toggleLeft()** or **toggleRight()** from any ViewController.

### Special Controls
UROPanels are made to work with UINavigationControllers and UITabBarControllers, so we have some variations to the typical popViewController that you must implement, but don’t worry, you only have to call them by code like this:

```swift
	func close() {
		self.navigationController!.popViewControllerDismissingPanels(animated:true)
	}
```

And the same for other pop/dismiss of viewcontrollers. This was made in order to prevent weird behaviors when popping/dismissing views that were showing the panel. You can call them from the navigationController o tabBarController and in any place you want.

### Delegation
So you can do special stuff when panels **WILL** show/hide and they **DID** show/hide. There are 4 delegate functions that are called directly on your LEFT and RIGHT panels. If your panels  push or present other viewControllers; we highly encourage you to implement you logic in the **panelDidHide()** function. Additionaly, you have four functions Callbacks that you can set, called **notifyWillShow, notifyDidShow, notifyWillHide, notifyDidHide** that receives a dictionary of [String:AnyObject] so you can customize and send some info when the methods are called. 
