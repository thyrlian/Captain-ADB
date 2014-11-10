![](https://github.com/thyrlian/Captain-ADB/blob/master/public/img/captain_android.png)

Captain-ADB
===========

Providing simple web API and view for Android Debug Bridge (adb).  Free your imagination, use it as the way you want.

##Requirement:
* Android SDK is configured as environment variable in your ***.bash_profile*** or ***.bashrc***
  * `ANDROID_HOME=[YourAndroidSdkDir]`
  * `export PATH=$PATH:$ANDROID_HOME/platform-tools`
* Ruby ( >= 1.9.3  strongly suggest using [RVM](http://rvm.io/) )
* Bundler - manages Ruby app's dependencies (`gem install bundler`)

##Setup:
1. Clone this project, and go to project directory
2. Run `bundle install`
3. Run `rackup` (or `bundle exec rackup`)
4. Open a browser, type in this URL [http://localhost:9292/](http://localhost:9292/)

##API:
###Schema
All API is accessed from the `http://yourdomain.com/api/`, and all data is sent and received as JSON.
###REST APIs
GET `devices.json`  
GET `devices/:device_sn/packages.json`  
GET `devices/:device_sn/packages/:package_name`  
DELETE `devices/:device_sn/packages/:package_name`  
DELETE `devices/:device_sn/packages/:package_name/data`  
POST `devices/:device_sn/screenshots`  
PUT `devices/:device_sn`  
```
{
    "language": "en",
    "country": "us"
}
```
