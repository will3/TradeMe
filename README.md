## Trade Me App

Created for Trade Me iOS Developer technical test

Documentation(All internal classes): [link](https://will3.github.io/TradeMe/docs/)

![image1](https://raw.githubusercontent.com/will3/TradeMe/master/preview1.gif)

### To Run

First install dependencies using CocoaPods, cd to project root and run ```Pod install``` in terminal.  
Open TradeMe.xcworkspace and run the TradeMe target.  
Unit Tests can be run from the same target.

### UI Tests
Run Target "TradeMeUITests" in test configuration

### Generate documentation:

Documentations are generated from code comments using [jazzy](https://github.com/realm/jazzy)  
Install jazzy, then run  

```bash
chmod 775 ./gendoc
gendoc
```

### Overview
Project architecture is good old MVC, I used [PromiseKit](http://promisekit.org/) extensively for async calls. Dependency Injection was done using [AppInjector](https://github.com/will3/AppInjector)

I based the design off the existing Trade Me app, as an excercise to duplicate the look and feel.

Some features include:

- Instant search  
Listings are updated as you type

- Auto expand  
View expands when user scroll down, similar to the Safari App

UI Tests were written using the Page pattern where Automation details are encapsulated and exposed through a nice, chainable 'Page' interface, for e.g.

```swift
HomePage(app)
	.showCategoryPage()
	.select(category: "Property")
	.done()
	.search("Treasure")
	.select(listingAtIndex: 0)
	.wait()
```

If I had more time, I would build in authentication, instead of using a generated header

[link to cv](http://will3.github.io/cv)