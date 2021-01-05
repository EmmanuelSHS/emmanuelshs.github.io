---
layout: post
title: "[读书笔记] Effective Python 高效Python| Part I"
date: 2020-11-11
---

# 简介
## 关于本书

标题: Effective Python: 90 Specific Ways to Write Better Python, 2nd Edition

作者: Brett Slatkin

## 总体评价

本书概括了Python3面世以来的很多新功能，补全了我个人对于现代Python在面向对象设计、API设计和python类型的理解。

可以说这本书让我更从容调用Python庞杂的各种库，类型和元类，避免重复造轮子，写出更清晰的代码。

笔记较多，因此分了两部分。另有英文版文章已经发布，我会尽量借中文版修改的机会发布一些新的笔记，或者删去冗余。原文就不再翻译，欢迎指正讨论。

<!-- more -->
# 笔记
## 1. Pythonic Thinking

> * Another surprise is that the else block runs immediately if you loop over an empty sequence:

> * for/else means “Do this if the loop wasn’t completed.” In reality, it does exactly the opposite. Using a break statement in a loop actually skips the else block:

for-else实在是很少见的一种语法，开发中如果容易出现歧义，应当避免，或者加注释

> * If you don’t expect the lengths of the lists passed to zip to be equal, consider using the zip_longest function from the itertools built-in module instead:

> * zip consumes the iterators it wraps one item at a time, which means it can be used with infinitely long inputs without risk of a program using too much memory and crashing.

> * All of the same options from the new format built-in mini language are available after the colon in the placeholders within an f-string, as is the ability to coerce values to Unicode and repr strings similar to the str.format method:

> * don’t help reduce the redundancy of repeated keys from problem #4 above

> * leaving your code difficult to read when you need to make small modifications to values before formatting them

> * With C-style format strings, you need to escape the % character (by doubling it) so it’s not interpreted as a placeholder accidentally. With the str.format method you need to similarly escape braces

> * The second problem with C-style formatting expressions is that they become difficult to read when you need to make small modifications to values

> * Importantly, str instances do not have an associated binary encoding, and bytes instances do not have an associated text encoding. To convert Unicode data to binary data, you must call the encode method of str.

> * Always use absolute names for modules when importing them, not names relative to the current module’s own path. For example, to import the foo module from within the bar package, you should use from bar import foo, not just import foo.

## 2. Lists and Dictionaries

> * If you’re creating a dictionary to manage an arbitrary set of potential keys, then you should prefer using a defaultdict

If you prefer error early (a lot of the time you would), consider built-in dict. Otherwise consider clearly stating function returns an `error-or-object` result.

> * If you need to handle a high rate of key insertions and popitem calls (e.g., to implement a least-recently-used cache), OrderedDict may be a better fit than the standard Python dict type

> * Starting with Python 3.6, and officially part of the Python specification in version 3.7, dictionaries will preserve insertion order

> * The sort method doesn’t work for objects unless they define a natural ordering using special methods, which is uncommon.

> * because a starred expression is always turned into a list, unpacking an iterator also risks the potential of using up all of the memory on your computer and causing your program to crash.

> * unpack arbitrary iterators with the unpacking syntax

> * But it is possible to use multiple starred expressions in an unpacking assignment statement, as long as they’re catch-alls for different parts of the multilevel structure being unpacked.

> * You also can’t use multiple catch-all expressions in a single-level unpacking pattern:

> * However, to unpack assignments that contain a starred expression, you must have at least one required part, or else you’ll get a SyntaxError

> * Python also supports catch-all unpacking through a starred expression.

> * But it will break when Unicode data is encoded as a UTF-8 byte string:

## 3. Functions

> * When you apply it to the wrapper function, it copies all of the important metadata about the inner function to the outer function:

> * use the wraps helper function from the functools built-in module. This is a decorator that helps you write decorators.

> * The value returned by the decorator—the function that’s called above—doesn’t think it’s named fibonacci

> * The / symbol in the argument list indicates where positional-only arguments end

Anything w/o a name shouldn’t be required.

> * Now, I can be sure that the first two required positional arguments in the definition of the safe_division_d function are decoupled from callers. I won’t break anyone if I change the parameters’ names again.

> * Now, calling the function with positional arguments for the keyword arguments won’t work:

> * The * symbol in the argument list indicates the end of positional arguments and the beginning of keyword-only arguments

> * With complex functions like this, it’s better to require that callers are clear about their intentions by defining functions with keyword-only arguments.

## 4. Comprehensions and Generators

> * combinations_with_replacement is the same as combinations, but repeated values are allowed:

> * combinations returns the unordered combinations of length N with unrepeated items from an iterator:

> * permutations returns the unique ordered permutations of length N with items from an iterator:

> * product returns the Cartesian product of items from one or more iterators,

> * accumulate folds an item from the iterator into a running value by applying a function that takes two parameters

> * filterfalse, which is the opposite of the filter

> * dropwhile, which is the opposite of takewhile

> * takewhile returns items from an iterator until a predicate function returns False for an item

> * islice to slice an iterator by numerical indexes without copying

> * zip_longest

> * Use tee to split a single iterator into the number of parallel iterators specified by the second parameter. The memory usage of this function will grow if the iterators don’t progress at the same speed since buffering will be required to enqueue the pending items:

> * A better way to provide exceptional behavior in generators is to use a class that implements the __iter__ method along with methods to cause exceptional state transitions.

> * except MyError:
        print('Got MyError!')

Somehow this would break method/interface boundary

> * throw method for re-raising Exception instances within generator functions.

> * The send method can be used to inject data into a generator by giving the yield expression a value that can be assigned to a variable.

> * The send method can be used to provide streaming inputs to a generator at the same time it’s yielding outputs.

> * yield from expression. This advanced generator feature allows you to yield all values from a nested generator before returning control to the parent generator.

> * You create a generator expression by putting list-comprehension-like syntax between ()

> * Beware of functions and methods that iterate over input arguments multiple times. If these arguments are iterators, you may see strange behavior and missing values

> * if isinstance(numbers, Iterator): # Another way to check
        raise TypeError('Must supply a container')

> * This works because the sum method in normalize calls ReadVisits.__iter__ to allocate a new iterator object. The for loop to normalize the numbers also calls __iter__ to allocate a second iterator object. Each of those iterators will be advanced and exhausted independently

> * When Python sees a statement like for x in foo, it actually calls iter(foo). The iter built-in function calls the foo.__iter__

> * This behavior occurs because an iterator produces its results only a single time. If you iterate over an iterator or a generator that has already raised a StopIteration exception, you won’t get any results the second time around:

> * It’s better not to leak loop variables, so I recommend using assignment expressions only in the condition part of a comprehension.

## 5. Classes and Interfaces

> * built-in collections.abc module defines a set of abstract base classes that provide all of the typical methods for each container type. When you subclass from these abstract base classes and forget to implement required methods, the module tells you something is wrong:

> * Compose mix-ins to create complex functionality from simple behaviors.

Prefer chaining different ones than inheritance

> * The solution is to override the BinaryTreeWithParent._traverse method to only process values that matter

Basically not too useful because you now have exceptional implementation

> * Mix-in classes don’t define their own instance attributes nor require their __init__ constructor to be called.

> * A mix-in is a class that defines only a small set of additional methods for its child classes to provide.

> * When you need a function to maintain state, consider defining a class that provides the __call__ method instead of defining a stateful closure.

> * The __call__ special 
