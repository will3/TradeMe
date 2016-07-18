## Trade Me App

Created for Trade Me iOS Developer technical test

Documentation(All internal classes): [link]()

[image1]() [image2]() [image3]()

#### To Run

First install dependencies using CocoaPods, cd to project root and run ```Pod install``` in terminal.  
Open TradeMe.xcworkspace and run the TradeMe target.  
Unit Tests can be run from the same target.

#### UI Tests
Run Target "TradeMeUITests" in test configuration

#### Generate documentation:

Documentations are generated from code comments using [jazzy]()  
Install jazzy, then run  

```bash
chmod 775 ./gendoc
gendoc
```

#### Overview
Project architecture is good old MVC, I used [PromiseKit]() extensively for async calls. Dependency Injection is done using [AppInjector]()

I based the design off the existing Trade Me app, as an excercise to duplicate the look and feel.

Some features include:

- Instant search  
Listings are updated as you type

- Auto expand  
View expands when user scroll down, similar to the Safari App

Duplicating the API models manually was error-prone and tedius. If possible, I would add [OpenAPI]() on the server side and generate client side wrapper using [swagger-codegen](https://github.com/swagger-api/swagger-codegen)

UI Tests are written using the Page pattern. UI Automation details are encapsulated and exposed through a nice, chainable 'Page' interface, for e.g.
```swift
HomePage(app)
	.showCategoryPage()
	.select(category: "Property")
	.done()
	.search("Treasure")
	.select(listingAtIndex: 0)
	.wait()
```
preview:  
[image]()

If I had more time, I would build in authentication (instead of hard coding headers)

[link to cv](will3.github.io/cv)