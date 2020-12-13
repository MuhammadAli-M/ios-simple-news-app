# Simple News App

## Architecture

Though this app, I used the MVC architecture pattern.

I have depended on two main view controller `OnBoardingVC` and `HeadlinesVC`.

I used the `HeadlinesVC` to support the `Search` feature too.

I used storyboard UI to save time. I kept some UI like navigation bar UI to be handled from code.

## Dark Mode

Dark mode is supported.

## Caching

I used the user defaults to cache the first-time launch information.

## Third-Party Libraries

I used the `Kingfisher` pod to fetch the headline's image of the `HeadlineTableViewCell`. Also, it caches the image.  

## Notes 

Some headlines may be repeated. This is as there as some common headlines between the selected categories. I also show the category beside the source newspaper. 
