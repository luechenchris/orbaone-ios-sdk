# orbaone-ios-sdk
Orba One's Document and Video Capture for Identity Verification in Swift.

## 1. Platform Requirements

The SDK supports the following configurations:
- SDK supports iOS 13+
- SDk supports Xcode 11.5+
- SDK supports the following presentation styles:
    - Fullscreen for iPhones
    - Fullscreen and Form Sheet for iPads


## 2. Install as a CocoaPod

To install the SDK using CocoaPods, add the following to the application's podfile:

```
pod 'OrbaOneSdk'
```

Then run `pod install` to retrieve the sdk.

## 3. App Permissions

The Orba One SDK requires that the following permissions be added to the application's `info.plist` file:

```
<key>NSCameraUsageDescription</key>
<string>Required for Facial and Document capture.</string>
<key>NSMicrophoneUsageDescription</key>
<string>Required for Audio capture.</string>
```

## 4. Configuring the SDK

The Orba One SDK uses a **publishable api key** and an **applicant id** that you can obtain from your vendor dashboard. Your publishable api key will be needed in order to initialize the SDK in your mobile app. A sample implementation is shown below.

```swift
import OrbaOneSdk

let config = OrbaOneConfig().setApiKey("publishable-api-key").setApplicantId("applicant-id").setFlow([.INTRO, .ID, .FACESCAN]).build()
do {
    let sdk = try OrbaOneFlow(configuration: config).with(responseHandler: {response in
        switch response {
        case .success(let result):
            print("Flow completed successfully: \(result)")
        case .failure(let error):
            print("Flow cancelled by the user: \(error)")
        case .start:
            print("Flow started.")
        case .error(let error):
            print("Flow encounterd an error: \(error)")
        }
    })

    var presentationStyle: UIModalPresentationStyle = .fullScreen
            
    if UIDevice.current.userInterfaceIdiom == .pad {
        presentationStyle = .formSheet
    }
    
    try sdk.startVerification(origin: self, style: presentationStyle)
} catch let error {
    print("Flow not started. Error: \(error)")
}
```

## 5. SDK Responses

The Orba One SDK exposes four callbacks to the mobile app. Each can be used to coordinate user feedback at various stages of the SDK's lifecycle.

```swift
{response in
        switch response {
        case .success(let result):
            // The mobile app user has completed all the required steps and is returned to the view that initiated the SDK.
            print("Flow completed successfully: \(result)")
        case .failure(let error):
            // The mobile app user cancelled the verification flow by returning to view that initiated the SDK.
            print("Flow cancelled by the user: \(error)")
        case .start:
            // A new verification flow was started by the user.
            print("Flow started.")
        case .error(let error):
            // An attempt was made to begin the verification flow but it failed.
            print("Flow encounterd an error: \(error)")
        }
    }
```
## 6. Customizing the Flow

To customize the verification flow, you can make use of the SDK's config builder function. All customization must be done before starting the verification.

```swift

let flowSteps: [Step] = [
  Step.INTRO, // Welcome step - gives your user a short overview of the flow. [Optional, Default].
  Step.ID, // Photo ID step - captures the user's identification document. [Default].
  Step.FACESCAN, // Selfie Video step - captures a video of the user for liveness detection. [Default].
]

let config = OrbaOneConfig().setApiKey("publishable-api-key").setApplicantId("applicant-id").setFlow(flowSteps).build()
let sdk = try OrbaOneFlow(configuration: config)
try sdk.startVerification(origin: self)
```

## 7. Customizing the Document Capture Step
To customize the document capture step, you can simply make use of the sdk's DocumentCaptureConfig builder class. By using this builder class, you are able to exclude specified documents and countries from the capture flow. All customization must be done before starting the flow.

``` swift
let documentStep = DocumentCaptureConfig()
    .excludeDocumennt([
        .PASSPORT, // this will remove the Passport option
        .DRIVERSLICENSE, // this will remove the Driver's License option
        .NATIONALID // this will remove the National ID option
    ])
    .excludeCountry([
        .JM, // this will remove Jamaica from the list of available countries
        .US // this will remove the United States from the list of available countries
    ]).build()
let config = OrbaOneConfig()
    .setApiKey("publishable-api-key")
    .setApplicantId("applicant-id")
    .supportsDocument(documentStep)
    .build()
let sdk = try OrbaOneFlow(configuration: config)
try sdk.startVerification(origin: self)
```

## 8. Customizing the Theme

To ensure that Orba One fits in to your app's existing user experience, you can customize various colors by specifying a theme configuration.

```swift
let appearance = Theme(
    colorPrimary: <UIColor>,
    colorTextPrimary: <UIColor>,
    colorButtonPrimary: <UIColor>,
    colorButtonPrimaryText: <UIColor>,
    colorButtonPrimaryPressed: <UIColor>,
    enableDarkMode: <true | false>)

let config = OrbaOneConfig().setAppearance(appearance).build()
```

```colorPrimary```: Defines the primary accent color for bullet points and highlights.\
```colorTextPrimary```: Defines the text color of Titles.\
```colorButtonPrimary```: Defines the background color of Primary Buttons and the text color of Secondary Buttons.\
```colorButtonPrimaryText```: Defines the text color of Primary Buttons.\
```colorButtonPrimaryPressed```: Defines the background color of Primary Buttons when pressed.\
```enableDarkMode```: Defines the dark mode allowed setting for the SDK.\

## Sample App
A sample app demonstrating the Orba One SDK's implementation has been included. See the SampleApp directory for the Swift implementation.

## Support

Please post all issues through [Github](https://github.com/orbaone/orbaone-ios-sdk/issues). If your query involves sensitive information, you may contact us at dev@orba.io with the subject `IOS ISSUE: `.

Copyright 2021 Orba Technology Holdings Ltd. All rights reserved.
