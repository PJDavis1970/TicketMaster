# TicketMaster
Ticket Master Swift Test

## Pods Used

I have used 4 libraries for this test.

- alamofire : Is used for networking
- SDWebImage : Is used for image downloading and caching
- ReachabilitySwift : Is used for reachability
- RealmSwift : is used for persisted data

## Views

There are 2 ViewControllers in the app.  

- EventBrowserVC : This is the main tableview for all events.  I have created this in storyboard
- EventBrowserInfoVC : This is the info screen for the event.  I created this in code rather than storyboard to have a conbination of both for demonstration purposes.

## Networking

I have created the networking as modula objects.  This allows for easier unit testing to test API endpoints.  I was going to add multiple endpoints for better network data usage however due to time restrictions and not being able to figure out how to achive some aspects of what I wanted to achive with the API's I have ended up with a single API call which is found in APIGetEventList.  As stated this object can be used in UnitTesting with ease.

In an ideal world I would query the backend for just event id's and then compare these with locally stored id's.  Any events that are not stored locally would result in another network call to obtain the rest of the events data.  This would minimise the amount of data used when fresh calls to the backend made and duplicate data passed. However I could not figure out how to obtain a list of events with only their id's returned.

I have created some test filtering in the networking which in a real world app would be passed into the networking from view selection.

## Data Models

I have created the basic models for data needed for this demo.  I did create extensions for image handling to allow the ImageView itself control on which image is used depending on the actual views size.

## Unit Tests

- NetworkApiTests : Here you can check the endpoints are getting a response and we have corect urls and permissions to access server
- ViewModelTest : Here we can test the models are being created ok from the API's.  All models will have there own test.  In our case we have EventBrowserViewModelTests.  This will check model is being setup correctly from response JSON.

## UI Tests

Unfortunatly I ran out of time to impliment these.

## Moving Forward and Improvements

Given more time I would have created a data manager to control all databases.  The data manager would have control over all downloading and caching of model databases.  The view models would then query the data manager for all data needed for that view model.


