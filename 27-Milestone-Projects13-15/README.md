# Milestone Projects 13-15 - Event contacts

https://www.hackingwithswift.com/100/swiftui/77 and https://www.hackingwithswift.com/100/swiftui/78

This milestone project is in 2 parts:
- Part1 allows adding a contact from a picture in the photo library, displaying a list of contacts, and displaying details of a contact
- Part2 adds retrieving and storing location when the contact is added, displaying location on a map, and taking a picture from the camera
  
#### Note

Both File system and Core Data implementations are provided. See Implementation.swift in "Model" to switch from one to the other.

#### Credits

Photos by [Austin Wade](https://unsplash.com/@austin_wade?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText), [Daniel Höhe](https://unsplash.com/@beyondxphotography?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText),  [Nathaniel Vala](https://unsplash.com/@spydernaz?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText), [David Rotimi](https://unsplash.com/@davidrotimi?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText), [Johan De Jager](https://unsplash.com/@vividd?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText), [Anastasia Vityukova](https://unsplash.com/@anastasiavitph?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/collections/9256441/faces-full-neutral-suitable-for-auto-gen?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)

## Challenges

#### 1. Photo Library

From [Hacking with Swift](https://www.hackingwithswift.com/guide/ios-swiftui/6/3/challenge):
>Have you ever been to a conference or a meetup, chatted to someone new, then realized seconds after you walk away that you’ve already forgotten their name? You’re not alone, and the app you’re building today will help solve that problem and others like it.
>
>Your goal is to build an app that asks users to import a picture from their photo library, then attach a name to whatever they imported. The full collection of pictures they name should be shown in a List, and tapping an item in the list should show a detail screen with a larger version of the picture.
>
>Breaking it down, you should:
>
>Wrap UIImagePickerController so it can be used to select photos.
Detect when a new photo is imported, and immediately ask the user to name the photo.
Save that name and photo somewhere safe.
Show all names and photos in a list, sorted by name.
Create a detail screen that shows a picture full size.
Decide on a way to save all this data.
We’ve covered how to save data to the user’s photo library using UIImageWriteToSavedPhotosAlbum(), but saving an image to disk requires a small extra step: you need to convert your UIImage to Data by calling its jpegData() method
>
>[...]
>
>The compressionQuality parameter can be any value between 0 (very low quality) and 1 (maximum quality); something like 0.8 gives a good trade off between size and quality.
>
>You can use Core Data for this project if you want to, but it isn’t required – a simple JSON file written out to the documents directory is fine, although you will need to add a custom conformance to Comparable to get array sorting to work.
>
>If you do choose to use Core Data, make sure you don’t save the actual image into the database because that’s not efficient. Core Data or not, the optimal thing to do is generate a new UUID for the image filename then write it to the documents directory, and store that UUID in your data model.

#### 2. MapKit

From [Hacking with Swift](https://www.hackingwithswift.com/100/swiftui/61):
>[...] Your boss has come in and demanded a new feature: when you’re viewing a picture that was imported, you should show a map with a pin on that marked where they were when that pin was added. It might be on the same screen side by side with the photo, it might be shown or hidden using a segmented control, or perhaps it’s on a different screen – it’s down to you. Regardless, you know how to drop pins, and you also know how to use the center coordinate of map views, so the only thing left to figure out is how to get the user’s location to save alongside their text and image.
>
>[...]
>
>Tip: If you want to make your app really useful, try setting the sourceType property of your image picker controller to .camera so that it lets user take new photos rather than import existing ones.

## Screenshots

![screenshot1](screenshots/screen01.png)
![screenshot2](screenshots/screen02.png)
![screenshot3](screenshots/screen03.png)
![screenshot4](screenshots/screen04.png)
