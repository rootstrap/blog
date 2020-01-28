## Scope functions in Kotlin
![Kotlin](images/kotlin.png)

#### Description:
When and how to use scope functions `run, let, apply, also, with` in Kotlin in order to improve 
our productivity writing a clean, readable and easy to maintain code.

## Table of Contents
* [Objectives](#objectives)
* [run](#run)
* [let](#let)
* [apply](#apply)
* [also](#also)
* [with](#with)
* [Combining scope functions](#combining-scope-functions)
* [Summary](#summary)

------------------------

#### Objectives.
. Work with the same scope.
. Write clean, readable and easy to maintain code

#### run:
Receives 'this' as an instance of the current object and returns a final value.
It is recommended for execute actions over the same scope.
```
val dog = Dog()
val result = dog.run { //this as instance of the object dog
	jump() // same as dog.jump() also you can use this.jump()
	sit()
  eat()
	sleep() // returns
}
```
Without "run" the code looks like:
```
dog.jump()
dog.sit()
dog.eat()
val result = dog.sleep()
```

#### let:
Receives 'it' as an instance of the current object and returns a final value, 
It is recommended for use the object scope several times with others functions.
```
val owner = dog?.let { 
  renameDog(it)
  paintDog(it, red)

  if(it.race == null) {
    it.race = generateRace()
  }

  assignOwner(it) // returns 
} ?: Dog().let{
  assignOwner(it) // returns 
}
```

#### apply:
Receives 'this' as an instance of the current object and returns the object,
It is recommended for change the scope function data:
```
dog.apply {
  name = "Canelo"
  color = "Red"
  size = "Big"	
}
```

#### also
Receives 'it' as an instance of the object, returns the same scope(object) as result.
It is recommended for execute a code after a creation of the object or parameters assignations:
```
fun getInstance() : Dog {
  return instance ?: Dog().also {
    instance = it
    // returns 'Dog()' not 'instance'
  }
}
```

Also, you can chain with 'apply':
```
val selected = dog.apply {
  name = "Canelo"
  color = "Red"
  size = "Big"	
}.also {
  if(it.race == Race.PitBull) {
    it.size = big
  }
  // return dog
}
```

#### with:
Similar to let, but using 'this' as scope.
It is recommended if you know the object is not null for example:
```
val dog = Dog()
with(dog) {
  println(name) //same as 'println(this.name)'
  eat() // this.eat()
}
```

If you need to check the object’s nullability you should use ‘let’ instead of ‘with’:
```
dog?.let {
  ...
}
```

#### Combining scope functions
Imagine you have two objects and you need to nest scope functions.
In this case you need to specify the name of the scope to avoid overlapping.
```
dog1.let { // it as instance of dog1
  dog2.let { d2 -> // you need use different names for the variable
    it.isBrotherOf(d2) //it stell an instance of dog1
    doSomething(arrayListOf(it,d2))
  }
  // d2 don't exist in this scope
  it.jump()
}
```

#### Summary:
Should be use scope functions depending on your needs, there is not a specific rule for each one, 
they are used in order to have a clean and easy to maintain code, and since Kotlin is a compiled 
language with the use of those functions you can get better performance of your apps.

#### Learn more
[Kotlin Scope Functions](https://kotlinlang.org/docs/reference/scope-functions.html) 
[Kotlin](https://kotlinlang.org)
