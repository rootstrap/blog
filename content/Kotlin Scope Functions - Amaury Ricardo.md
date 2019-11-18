## Scope functions in Kotlin
![Kotlin](images/kotlin.png)

### Objectives.
. Work with the same context.
. Write clean, readable and easy to maintain code

### Scope functions:
. run
. let
. apply
. also
. with

### How and where to use:
1. run:
Receive 'this' as an instance of the current context and return a final value, should be used to execute actions over the same context.
```
val dog = Dog()
val result = dog.run { //this as instance of the object dog
	jump() // same as dog.jump() also you can use this.jump()
	sit()
  eat()
	sleep() // the final return value
}
```
Without "run" the code looks like:
```
dog.jump()
dog.sit()
dog.eat()
val resutl = dog.sleep()
```

2. let:
Receive 'it' as an instance of the current object and return a final value, should be used to use the object context several times
```
dog.let { 
  renameDog(it, "Canelo")
  paintDog(it, red)
}
```

3. apply:
Receive 'this' as an instance fo the current context, return the object context, should be used to change context data:
```
dog.apply {
    name = "Canelo"
    color = "Red"
    size = "Big"	
}
```

4. also
Receive 'it' as an instance of the object, return the same context as result, should be used to execute a code after a creation of the object or parameters assignations:
```
val dog = Dog().also {
	selectedDog = it 
}
```

Also, you can combine with 'apply':
```
dog.apply {
  name = "Canelo"
  color = "Red"
  size = "Big"	
}.also {
  selectedDog = it
}
```

5. with:
Similar to let, but using 'this' as context, should be used if you know the object is not null for example:
```
val dog = Dog()
with(dog) {
  renameDog(this, "Canelo")
  eat() 
}
```
But if you need to check the object nullability you should be used 'let' as instance of with:
```
dog?.let {
  ...
}
```

### Combining scope functions
Imagine you have two objects and you need to use a scope function inside another, you need to specify the name of the context to avoid context overlapping.
```
dog1.let { // it as instance of dog1
  dog2.let { d2 -> // you have to rename the context for dog2
    it.isBrotherOf(d2) //it stell an instance of dog1
    doSomething(arrayListOf(it,d2))
  }
  // d2 don't exist in this context
  it.jump()
}
```

### Summary:
You should be used the scope functions depending on your needs, there is not a specific rule for each one, they are used in order to have a clean and easy to maintain code, and since Kotlin is a compiled language with the use of those functions you can get better performance of your apps.

### Learn more
[Kotlin Scope Functions](https://kotlinlang.org/docs/reference/scope-functions.html) 
[Kotlin](https://kotlinlang.org)
