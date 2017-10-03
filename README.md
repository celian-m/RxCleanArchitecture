# Rx Clean Swift

This repository provides XCode templates for Clean Archtiecture using RxSwift.

## Classes

Here is the global interaction schema:

![Interactions](https://mouce.fr/static/CleanSwift.001.jpeg)

* **Router**

The router is the only entity able to instantiate / prepare the Scene.
Typycally it creates the *Presenter*, *Interactor* and *Controller* and returns *Controller* 

All navigation should be invoked to the Router using `router.go(to : Route)`

* **Controller**

Controller is an object ( typically ViewController ) responsible for transforming ViewModel into View.
It should also forward all intents to the *Interactor*

* **Presenter**

The *Presenter* subscribes to the *Controller* intents ( declared throught an interface ) and map them to Use Cases ( contained in *Interactor* )

* **Interactor**

The *Interactor* is used to fecth repositories and transform shared models to specific models for a specific Use Case ( Like Sorting items, filter, etc... )

* **Repository**

The *Repository* is the object fetching the data ( WebService, DataBase, MemoryCache... ). This is the only class shared among Scenes.

## Usage

You need following pods :

```ruby
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxTest' #Add only to you test target
```

Using Xcode 8/9 you have to copy the `Viper` folder into :

` ~/Library/Developer/Xcode/Templates/File\ Templates/`

Then (after restarting XCode) you can create a `New File / Viper / Scene`.

![NewFile](https://mouce.fr/static/Viper-new.png)


## Dependency 

Here is the global architecture schema:

![Architecture](https://mouce.fr/static/CleanSwift.002.jpeg)


## Unit Test

The differents models/classes are designed to be testable ( Using RxTest ). You can sublass the *Controller/Repository* and mock the *Router* as they are structures.

In order to well-test your code, you should probably focus on the *Presenter* class, trying to generate some odd scenarii ( sending *.onError()*, sending lot of UI interactions, etc. )

You can find sample of Presenter Tests in [GitHubSampleTests/GitHubSampleTests.swift](https://github.com/celian-m/RxCleanArchitecture/blob/master/Sample/GitHubSample/GitHubSampleTests/GitHubSampleTests.swift)



