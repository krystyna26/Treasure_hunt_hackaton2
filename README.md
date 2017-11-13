# treasureHunt

### Get Started

1) Open terminal and navigate to a directory where you want to keep the project
2) Clone project `git clone https://github.com/nmohel/treasureHunt.git`
3) Go into project directory `cd treasureHunt`
4) Make sure you have CocoaPods installed if not: `sudo gem install cocoapods`
5) `pod init` to create pod file
6) Change Podfile to look like this:

```
 source 'https://github.com/CocoaPods/Specs.git'
 target ‘TreasureHunt’ do
  pod 'GoogleMaps'
  pod 'GooglePlaces'
 end
```
 
 7) `pod install` to add dependencies for Google Maps
 8) Close XCode and project
 9) Open project using __TreasureHunt.xcworkspace__
 10) Only use the .xcworkspace file to open project from now on
