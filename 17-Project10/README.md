# Project 10 - Cupcakes Corner

https://www.hackingwithswift.com/100/swiftui/49

Includes solutions to the [challenges](https://www.hackingwithswift.com/books/ios-swiftui/cupcake-corner-wrap-up).

## Topics

Codable, URLSession, disabled()

## Challenges

From [Hacking with Swift](https://www.hackingwithswift.com/books/ios-swiftui/cupcake-corner-wrap-up):
>1. Our address fields are currently considered valid if they contain anything, even if it’s just only whitespace. Improve the validation to make sure a string of pure whitespace is invalid.
>2. If our call to placeOrder() fails – for example if there is no internet connection – show an informative alert for the user. To test this, just disable WiFi on your Mac so the simulator has no connection either.
>3. For a more challenging task, see if you can convert our data model from a class to a struct, then create an ObservableObject class wrapper around it that gets passed around. This will result in your class having one @Published property, which is the data struct inside it, and should make supporting Codable on the struct much easier.

## Screenshots

![screenshot1](screenshots/screen01.png)
![screenshot2](screenshots/screen02.png)
