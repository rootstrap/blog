
## Introduction to Android Architecture Components

According to https://developer.android.com:
"Android architecture components are a collection of libraries that help you design robust, testable, and maintainable apps. Start with classes for managing your UI component lifecycle and handling data persistence."

Android Architecture Components are focused to solve many problems that Android developers face on a project. It focuses on a clean and easy to maintain architecture such as MVVM, and trying to take advantage of all the capabilities of the Android framework and how it is structured.

![ArchComponets](images/arch_componets.png)

This post is to give a brief introduction to Android Architecture Components, in later posts we will delve deeper into each of these libraries aiming to show the capabilities of each one.

Let's start:

- ### Life cycle:

Android introduce lifecycle as a way to avoid memory leaks and keep a cleaner code, and each activity|fragment|lifecycle-owner can be abstracted from the behavior of an object at each stage of its life cycle, that object can subscribe to the activity|fragment lifecycle implementing the interface androidx.lifecycle in order to execute certain actions in each state:

![LifeCycle](images/lifecycle.jpg)

To subscribe to a lifecycle state you can use annotations like:

``` kotlin
  @OnLifecycleEvent(Lifecycle.Event.ON_RESUME)
  fun yourOnResumeActionListener() {
	...	
  }
```

Eache states:
ON_RESUME,ON_START,ON_STOP,ON_DESTROY,ON_PAUSE,ON_CREATE
Note: Each activity|fragment|lifecycle-owner needs to add the object to his own lifecycle observers:

``` kotlin 
    this.getLifecycle().addObserver(objectWithLifeCycleListener)
```

- ### Live Data:

This concept is not new for android, this is a new way to see and observable object that was previously introduced with "androidx". With live data they introduce it a owner in order to know when to notify data depending of the owner lifecycle in order to manage consistent data and avid memory leaks. 
A classic example: for an app it is important to keep the user data updated, if the user changes the name, avatar, permissions, etc... you can observe it and notify the app for those changes.

- ### View Model:

Is the one with the responsibility of provide and keep data save for the UI in each state of the lifecycle of the view or the app for example screen rotations or when the app gone to background or is sleeping, is the one who "talk" with the repository subscribe to  the repository response with LiveData, each view(Activity|Fragment not custom views or Adapters) should have a view model example:
MainActivity.kt
MainActivityViewModel.kt

Nota that you needs to setup the view model with the View in order to register the view as the LifeCycle owner:
In the view(this case MainActivity):

``` kotlin
val viewModel = ViewModelProviders.of(this)
    .get(MainActivityViewModel::class.java)
```

- ### Room database:

Android always use Sqlite to storage|manage data but the use of Sqlite required write a lot of code or the use of unsafety third party libraries, also Sqlite didn't check the sql queries at compile time, they created Room to solve that problem and keep data safe and integrated it with LiveData to provide a clean wait to provide data to the ViewModel, to create a db entity all you have to do is add @Entity to a Model class and a create a @Dao interface to manage that entity values:

``` kotlin
@Entity
class Person {
    @PrimaryKey
    var id: Long? = null
    var name: String? = null
    var lastName: Long? = null
}

@Dao
interface PersonDAO {
    @Insert( onConflict = OnConflictStrategy.REPLACE )
    fun insertPerson(person: Person): Long
 
    @Query("SELECT * FROM person WHERE id = :arg0")
    fun findById(id: Long): LiveData<Person>
}

// Setup the DB:
@Database( entities = arrayOf(Person::class), version = 1)
abstract class Database : RoomDatabase() {
    abstract fun personDAO(): PersonDAO
}
```

- ### Managing your UI components:

Android introduced a Data Binding library to provide us a new way to set up the view, as passing all data or livedata to the xml file:


``` xml
<layout xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:app="http://schemas.android.com/apk/res-auto">
    <data>
        <variable
            name="viewmodel"
            type="com.rootstrap.viewmodel.ProfileActivityViewModel" />
    </data>
    <ConstraintLayout ...>
        <TextView
            ...
            android:text="@{viewmodel.profile.name}" />
  </ConstraintLayout>
</layout>
```

Also the added binding adapters in order to create custom properties or listeners for each layout for example:

``` kotlin
@BindingAdapter("app:addPersonAdapter")
fun personAdapter(view: RecyclerView, adapter: PersonAdapter) {
	view.apply {
	    it.layoutManager = LinearLayoutManager()
	    It.adapter = adapter
    }
}
```

The view:

``` xml
    ...
    <variable
            name="viewmodel"
            type="com.rootstrap.viewmodel.ProfileActivityViewModel" />
    </variable>
    ...
    <RecyclerView
        ...
        add:addPersonAdapter="@{viewmodel.personAdapter}" />
```

Also we can integrate DataBinding with Live data but that's for another post.

- ### Conclusions: 

As we have observed, these libraries come to help us obtain a cleaner, faster, more scalable and easier to maintain code, as I mentioned earlier, in later posts we will delve deeper into each of these components in order to provide a better understanding of each one.
