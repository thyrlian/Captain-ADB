<img src="https://github.com/thyrlian/Captain-ADB/blob/master/public/img/captain_android.png" width="200">

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
3. Run `rackup -p <PORT> -o 0.0.0.0` (or `bundle exec rackup -p <PORT> -o 0.0.0.0`)
4. Open a browser, type in this URL http://localhost:PORT

##API:
###Schema
All API is accessed from the `http://yourdomain.com/api/`, and all data is sent and received as JSON.
###REST APIs
POST `adb/action/restart`  
GET `devices`  
GET `devices/:device_sn/packages`  
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
POST `devices/:device_sn/deeplinks`  
```
{
    "packageName": "com.example.android",
    "deepLink": "https://www.android.com/example"
}
```

##License
Copyright (c) 2016 Jing Li. See the LICENSE file for license rights and limitations (MIT).

##Thanks:
Special thanks to my frontend specialist - [**Miguel**](http://henrique.pt/)  twitter:[@lordcracker](https://twitter.com/lordcracker)  github:[@ellite](https://github.com/ellite)

##Attribution:
[Icon](http://www.flaticon.com/free-icon/photo-camera_68906) made by [Freepik](http://www.freepik.com) from [Flaticon](http://www.flaticon.com) is licensed under [CC BY 3.0](http://creativecommons.org/licenses/by/3.0/)

[Icon](http://www.flaticon.com/free-icon/rubbish-bin_63260) made by [Icon Works](http://icon-works.com) from [Flaticon](http://www.flaticon.com) is licensed under [CC BY 3.0](http://creativecommons.org/licenses/by/3.0/)

[Icon](http://www.flaticon.com/free-icon/delete-database_51504) made by [Freepik](http://www.freepik.com) from [Flaticon](http://www.flaticon.com) is licensed under [CC BY 3.0](http://creativecommons.org/licenses/by/3.0/)
