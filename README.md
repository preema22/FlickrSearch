# Flickr Search
Created by Preema DSouza

This project is implemented using Xcode 11.7 and Swift 5 and follow MVVM design pattern.
This project is about fetching and presenting photos based on user input search text. It uses the pod SdWebImage to assist download of images. The project also provides a history of past search terms by using Core Data.
Please open FlickrSearch.xcworkspace as opposed to FlickrSearch.xcodeproj due to existence of pod.

## View Controllers
There are two view controllers, **PhotosViewController** and **HistoryViewController**

### PhotosViewController
A _ViewController_ that contains a _SearchController_ to perform the search  and a _CollectionView_ to display the results

### HistoryViewController
A _ViewController_ that contains the list of past search terms in a _TableView_

## Service
A singleton instance that is responsible for getting the search result from the API

## Models
There are two models: **Photos** and **Photo**

### Photos
Decodable struct that represents the result returned by the API

### Photo
Decodable struct that represents a single Photo  entry

## Views

### PhotoCollectionViewCell
This is a _UICollectionViewCell_ which is responsible for displaying a product with the help of  **PhotoViewModel**

## ViewModels

### PhotosViewModel
View Model for **PhotosViewController**. It is also responsible for persisting search term to the corresponding Entity

### PhotoViewModel
View Model for **PhotoCollectionViewCell**

### HistoryViewModel
View Model for **HistoryViewController**

## Core Data

### PersistenceService 
Core Data Stack for the project. Has the save and fetch methods

### Managed Objects
_History+CoreDataClass_ and _History+CoreDataProperties_

### DataManager
Helper to save search term

### HistoryEntityHandler
Data entity handler. Helps _DataManager_  fetch existing entires and eliminate duplicates 

## Tests

### PhotosViewModelTests
Tests for _PhotosViewModel_ validations

### PhotoViewModelTests
Tests for _PhotoViewModel_ validations

### HistoryViewModelTests
Tests for _HistoryViewModel_ validations


