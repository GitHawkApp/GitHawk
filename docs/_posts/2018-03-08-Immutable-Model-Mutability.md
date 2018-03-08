---
layout: post
author: ryannystrom
title: Immutable Model Mutability
---

GitHawk is powered by an architecture and a [few](https://github.com/GitHawkApp/FlatCache) [libraries](https://github.com/Instagram/IGListKit) that shine when fed with _immutable models_.

Why? Because once a model is initialized it cannot be changed, making it safe to read its values across threads and contexts.

Imagine we're building an employee management app with the following model:

```swift
Person {
  let name: String
  let job: String?
}
```

We can toss this simple, lightweight model to different threads and controllers without concern for crashes, bugs, or performance issues.

However sometimes we need to change a model's values. Say this app has a feature that lets you update an employee's job title.

```swift
let me = Person(name: "Ryan", job: "Engineer")
me.job = "Manager" // ERROR
```

## New Mutated Models

Instead of changing the model instance, we can initialize a _new instance_ with the updated values.

```swift
let me = Person(name: "Ryan", job: "Engineer")
let newJob = Person(name: me.name, job: "Manager")
```

Hurray! We have a new _immutable_ model with our updated values.

However that's a lot of code to change a single value. What happens if we add a new property?

```swift
Person {
  let name: String
  let age: Int // new
  let job: String?
}
```

We're going to spend the rest of the day chasing down compiler errors. Boo!

## Less Code with Default Values

We can take advantage of Swift's default parameter values by adding a function:

```swift
func update(
  name: String? = nil,
  age: Int? = nil
  ) -> Person {
  return Person(
    name: name ?? self.name,
    age: age ?? self.age,
    job: self.job
  )
}
```

Not only does this save us from refactor-headaches when adding new properties, but its also less boilerplate when updating a single value!

```swift
let me = Person(name: "Ryan", age: 29, job: "Engineer")
let birthday = me.update(age: 30)
print(birthday.name) // "Ryan"
```

We didn't include `job` in the parameters because it's **optional**. If someone wanted to change `job` to `nil`, then `job ?? self.job` would maintain the _old_ value instead of setting it to `nil`.

We can solve this by creating a function for each optional value:

```swift
func with(job: String?) -> Person {
  return Person(
    name: self.name,
    age: self.age,
    job: job
  )
}
```

Bear in mind that `Person` only has 3 properties. If this were a more complex model, just imagine how much code we'd have to write! 😱

## Saved by Sourcery

_Full disclosure, this is the first time I've ever used Sourcery._

Saving time from writing boilerplate code is _exactly_ what [Sourcery](https://github.com/krzysztofzablocki/Sourcery) was made for.

We need a template that does two things:

1. Create an `update(...)` function with every non-optional property as a parameter.
2. Create a `with(...)` function for every optional property.

We add a new, empty protocol to tell Sourcery which models to run this template on:

```swift
protocol AutoMutatable {}
```

Then our Stencil template creates the `update(...)` and each `with(...)` function based on the type's variables:

```
{% raw %}
{% for type in types.implementing.AutoMutatable %}
extension {{ type.name }} {
  func update(
  {% for variable in type.storedVariables where not variable.isOptional %}
    {{ variable.name }}: {{ variable.typeName }}? = nil{% if not forloop.last %},{% endif %}
  {% endfor %}
    ) -> {{ type.name }} {
    return {{ type.name }}(
    {% for param in type.storedVariables %}
      {{ param.name }}: {% if not param.isOptional %}{{ param.name}} ?? {% endif %}self.{{ param.name }}{% if not forloop.last %},{% endif %}
    {% endfor %}
    )
  }

  {% for variable in type.storedVariables where variable.isOptional %}
  func with({{ variable.name}}: {{ variable.typeName}}) -> {{ type.name }} {
    return {{ type.name }}(
    {% for param in type.storedVariables %}
      {{ param.name }}: {% if not param.isOptional %}self.{% endif %}{{ param.name }}{% if not forloop.last %},{% endif %}
    {% endfor %}
    )
  }
  {% endfor %}
}
{% endfor %}
{% endraw %}
```

When Sourcery runs, we get an auto-generated extension that looks like this:

```swift
extension Person {
  func update(
    name: String? = nil,
    age: Int? = nil
    ) -> Person {
    return Person(
      name: name ?? self.name,
      age: age ?? self.age,
      job: self.job
    )
  }

  func with(job: String?) -> Person {
    return Person(
      name: self.name,
      age: self.age,
      job: job
    )
  }
}
```

Now any time we make a change to the `Person` model or add new `AutoMutatable` models, Sourcery will create mutation methods while keeping our app architecture safe from _actual_ mutable models.

## Where to now?

GitHawk isn't actually using Sourcery yet. We have some big [IGListKit changes](https://github.com/Instagram/IGListKit/pull/1081) that have to land, and then embark on some model refactors. However we've been using this [immutable-model-mutability architecture](https://github.com/rnystrom/GitHawk/blob/master/Classes/Issues/IssueResult.swift) for a little while with [great results](https://github.com/rnystrom/GitHawk/blob/45335eb4a0822c07abfb10e9b6f8bc5d1d85282b/Classes/Issues/Merge/GithubClient%2BMerge.swift#L36-L39)!