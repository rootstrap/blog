
## Setting Up Firebase on Android.
### What's Firebase?

Firebase is a mobile platform that helps you quickly develop high-quality apps, grow your user base, and more. Firebase is made up of complementary features that you can mix-and-match to fit your needs, helping you to build apps fast, without managing infrastructure. Firebase gives you functionality like analytics, databases, messaging, and crash reporting so you can move quickly and focus on your users. [[from google]](https://developer.android.com/studio/write/firebase)

Was created by Envolved between 2011-2014, with just a couple o features (Realtime db, Hosting and Authentication) and was acquired by Google in 2014. A year later, in 2015, Google acquired Divshot, an HTML5 web-hosting platform, to merge it with Firebase, and integrated a lot of google services as well, in 2016 acquired LaunchKit a toolkit for mobile app development and in 2017 Fabric as analytics tool. Every year Google release at least one new functionality for Firebase in order to improve the mobile and web development.

### What can we do with Firebase?

Firebase provides a lot of tools that we will talk about in next posts but resuming Firebase allow as to:
- Push notifications
- Analytics
- A/B Testing
- Authentication
- Real time db
- App distributions
- Google cloud: Hosting, Storage
- Machine Learning

and a lot of others tools that I invited you to test.

### Setting up on Android

1. **Adding dependencies**

On your project  Gradle file "build.gradle"

    ```java
    repositories {
        google()
        jcenter()
        maven {
            url 'https://maven.fabric.io/public'
        }
    }

    dependencies {
    		....        
    		classpath 'com.google.gms:google-services:4.3.2'  // Google Services plugin
        classpath 'io.fabric.tools:gradle:1.31.2'  // Crashlytics plugin
    		....
    }

    ```

On your module (app) Gradle file "build.gradle"

    ```java
    apply plugin: 'com.android.application'

    android {
       ....
    }
    dependencies {
    		.....
    	// Add the Firebase SDK for Google Analytics
      implementation 'com.google.firebase:firebase-analytics:17.2.1'
    }

    // Add the following line to the bottom of the file
    apply plugin: 'com.google.gms.google-services'
    ```

2. **Create the project on your Firebase console**

    Open your [firebase console](https://console.firebase.google.com/)  and add a new project:

    ![Add firebase](images/fb1.png)

    Once you create the project in order to add a new Android app:

    ![Add android plattform](images/fb2.png)

    On the next steps enter the Android applicationId , you can found on the Gradle file:

    ```kotlin
    ....
    android {
        ....
        defaultConfig {
            applicationId "com.rootstrap.android"
    		....
    ```

    **Note: In case you configure several build types with different package names you need to add an Android app to the current Firebase console for each of them.**

    ```kotlin
    productFlavors {
            development {
                dimension "server"
    				//Fore this case you have to create a new Android app 
    				// in to your current Firabese console
    				// applicationId = com.rootstrap.android.dev
                applicationIdSuffix ".dev"
            }

            production {
                dimension "server"
            }
    }
    ```

Once you create the app, download the google-services.json file and copy on your module folder (app).

3. **Finally run your App, you should be able to see on your Project overview 1 daily active user (your current device or emulator)**

## That's it.

Firebase has several tools to improve your code and productivity in order to get better performance and user experience. Play around the console and use the ones you needed on your Project.

For more info please check:
[Firebase](https://firebase.google.com/)