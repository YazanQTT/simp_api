# SimpApi

A simp and easy package to use REST Api in **Flutter**.

The simp_api package is a library for building RESTful APIs in Dart and Flutter applications. It provides a simple and intuitive interface for defining API endpoints and handling HTTP requests and responses.

With simp_api, you can easily define your API routes, specify the HTTP methods, and handle incoming requests using functions that take in the request and return a response. The package also includes utilities for handling query parameters, request headers, and parsing JSON payloads.

The simp_api package is designed to be lightweight and easy to use, making it a great choice for small to medium-sized projects. Additionally, it supports both synchronous and asynchronous handling of requests, allowing you to choose the approach that works best for your application.

Overall, if you're building a Dart or Flutter application that requires a simple and straightforward way to define and handle RESTful APIs, simp_api is definitely worth checking out.

## Features 👇
- `Make HTTP requests 🔥`
- `Upload images 🔥`
- `Upload files 🔥`
- `Handle HTTP exceptions 🔥`


## Installing ✅
```yaml
dependencies:
  simp_api: ^<latest_version>
```

## Usage ⚒️
1. Making HTTP requests
##### *Create an instance of SimpApi*
```
final simp = SimpApi.instance;
```
##### *Call the sendRequest method to make HTTP requests*
```swift
final res = await simp.sendRequest(  
    requestType: RequestType.GET,  
    url: 'https://catfact.ninja/fact',  
);
```

>Note : header & body parameter are optional
> if header is null, it will default to
```swift
  final Map<String, String> _header = {  
	  'Content-type': 'application/json',  
	  'Accept': 'application/json',  
	  'Access-Control-Allow-Origin': '*',  
	};
```
> Note: requestType is enum
```swift
enum RequestType {GET, PUT, POST, DELETE}
```
2. Uploading images
##### *Call the  uploadImage method*
```swift
final res = await api.uploadImage(  
  filesRequestType: FilesRequestType.PUT,  
  url: '',  
  imageFile: File('image_path'),  
);
```
> Note: filesRequestType is enum
```swift
enum FilesRequestType {PUT, PATCH}
```
3. Uploading files
##### *Call the  uploadFiles method*
```swift
final res = await api.uploadFiles(  
  filesRequestType: FilesRequestType.PUT,  
  url: '',   
 files: [  
    File('file1_path'),  
	File('file2_path'),  
	File('file3_path'),  
	],  
);
```
> Note: filesRequestType is enum
```swift
enum FilesRequestType {PUT, PATCH}
```
4. Handling HTTP exceptions
   `SimpApi will handle all exceptions and give you a simp description of what went wrong.`
```swift
on UnauthorisedException {  
  throw UnauthorisedException('Check the requested URL');  
} on SocketException {  
  throw FetchDataException('Check your internet connection or a typo in $url');  
} catch (error) {  
  debugPrint('EasyApi error @ $url : $error');  
}
```
## Bugs/Requests 🔴
Feel free to reach out and open an issue if you encounter any problems.
If you feel the library is missing a feature, please raise a ticket on Github and I'll look into it.
Pull request are also welcome.
