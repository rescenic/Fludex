# Fludex
A very basic manga reader made using flutter and mangadex API. It uses the [mangadex_library package](https://pub.dev/packages/mangadex_library).

## A few things to remember

- The app only supports windows at the moment. Android and other platforms can be compiled too, just remember that it's never tested on those devices so, it might become a nightmare when you look at it. Good luck to your eyes, honestly.

- The app is in a very early stage of development and hence bugs are expected including some incomplete code that I still can't figure out (for example the page navigation still doesn't work properly) it also doesn't have much functionality except for login, searching manga and reading manga. Some mangas even tend to break the app.

- The app is open source and not to be used for any commercial purposes, it's just a project for both the flutter and the mangadex community to showcase the future revolution flutter can bring in.

- I might not be able to always be there to keep adding features to this one, however everyone's welcome to contribute to the project.

## Releases
The first realse version has been finally uploaded and can be found on the [releases](https://github.com/Riktam-Santra/Fludex/releases) page, if you are looking ahead to try the app.

## Compiling the App
- Add the /bin directory of your flutter installation to your system PATH
- Next you will have to [enable desktop support](https://flutter.dev/desktop)
- Install both the [Dart](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code) and the [Flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter) plugin installed in your IDE. Visual Studio Code was used for this project.

## Running the App

Open up the **main.dart** file in the /lib directory and press F5. It should say 'building windows application', in that case the app should launch in around 60 seconds.

![](https://i.imgur.com/rgBrEkJ.gif)

## Known bugs

Search bar
 - after searching for a title, you must clear the search box then press enter so that the search bar is not selected anymore to search for another title.

Manga Reader
 - Unnessary space between pages.
 - Sometimes, while scrolling back up, all the pages will reload causing the current position of the view to get disoriented.

## Crashes
  The app crashes under the following circumstances
  - If there is no internet
  - On request timeouts
  - If rate limit is exceeded <br><br>
I'll try to fix these soon.

## Things coming next
 - Read chapters other than only the first chapter.
 - A better search function.
