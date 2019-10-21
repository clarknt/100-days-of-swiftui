# Project 4 - BetterRest

https://www.hackingwithswift.com/100/swiftui/26

Includes solutions to the [challenges](https://www.hackingwithswift.com/books/ios-swiftui/betterrest-wrap-up).

## Topics

Machine Learning, Dates (DatePicker, DateComponents, DateFormatter) Stepper, navigationBarItems()

## Challenges

From [Hacking with Swift](https://www.hackingwithswift.com/books/ios-swiftui/betterrest-wrap-up):
>1. Replace each VStack in our form with a Section, where the text view is the title of the section. Do you prefer this layout or the VStack layout? It’s your app – you choose!
>2. Replace the “Number of cups” stepper with a Picker showing the same range of values.
>3. Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely.

### Note for challenge 2
After solving, the Picker was replaced by the original Stepper, that takes less space and is more responsive. Code for challenge is still in the source file, though commented, or here below.
```swift
Picker("Coffee intake", selection: $coffeeAmount) {
    ForEach(1...20, id: \.self) { i in
        Text("\(i) \(i == 1 ? "cup" : "cups")")
    }
}
.id("coffee")
.labelsHidden()
.pickerStyle(WheelPickerStyle())
```

## Screenshots

![screenshot1](screenshots/screen01.png)
