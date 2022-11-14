
# World Countries App

A flutter based mobile app to get realtime information about all countries
in the world. 



## Features
- Search field to filter and display search results
- Adaptive thememode.
- Landscape and Portrait Mode
- Filter by region

## Codebase Description
It attempts to make use of the Model-View-ViewModel 
Architecture although for now, The business logic is
 in the repository folder. In order to avoid boilerplate code, 
the constant widgets, were separated and imported 
when needed. Also, The app should was written in a way 
that it can be easily extended with new features.
Models were created for the api's response, also the logic 
was structured in a way that effectively takes care of internet connection
and unforeseen errors. Also, Provider was used for effective state management

#How the app works
You can input the name of a country and search for the country, also, you can filter all countries 
by clicking on the filter button, select the regions and wait for the country list to be updated according 
to the filter. The thememode is adaptive and you can change the theme to what suits you.
For now, you can click on the change orientation to change the device orientation but the next update will include adaptive 
orientation.

## Packages/Libraries Used
They include:

- provider- A state management library
- http - A composable, Future-based library for making HTTP requests.
- carousel_slider - A carousel slider widget.
- smooth_page_indicator 
- flutter_easyloading - display error messages without context
## Challenges Faced
The biggest challenge faced was trying out localization to
enable users to make use of the app irrespective of their 
native languages, but is still a work in progress and will be fully 
resolved in the next update.

## Features to be added later
Due to the time constraint, these features will be implemented in the next update:
- Search filtering by currency, time

## Link to APK File
https://drive.google.com/file/d/1rUxr4tKLNoKkIAKwWzxhpurfYEh8UFW8/view?usp=sharing
## Link to Appetize
https://appetize.io/app/m4c2x7zzainppwj277piy5aa7a?device=pixel4&osVersion=12.0&scale=75
