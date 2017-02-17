### Introduction
This is a simple weather app showing weather information.

### Functionality
Upon lauching the app, this app will load the City object from Coredata and display the weather of the most recently viewed city.

The weather information detail page is a mimic of Apple Weather app detail page. User could see current condition, 24 hour forecast and 10 day forecast from this page. User could scroll horizontally to see hourly data, scroll vertically to see 10-day data.

User could  tap the "Search" button on the right top corner of the information to view the weather information of other citys. The "Search" button would lead user to the SearchTableview which enable user search and view other citys' weather information. 

Some sample city has been loaded into coredata. User could tap these city name in the table to view the detail weatehr information. This will lead user back to the InfoView, with the weather data of the selected city.

User could also search a specific city by type it into search bar and hit "Search" button in the keyboard. This would also lead user back to information view, with the weather data of the selected city. If user search for a invalid city, a alertview would appear.