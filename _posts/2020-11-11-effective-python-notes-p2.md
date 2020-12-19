---
layout: post
title: "[Reading Notes] Effective Python | Part II"
date: 2020-11-11
---

# Notes 
cont'd

## 6. Metaclasses and Attributes

> * A class decorator is a simple function that receives a class instance as a parameter and returns either a new class or a modified version of the original class

This could be best practice unless it breaks class API contract, since decorator is easily interchangeable and the details are hidden from class code. So user can easily observe no compatible upgrades w/o notice.

<!-- more -->

> * Metaclasses can’t be composed together easily, while many class decorators can be used to extend the same class without conflicts

> * Define __set_name__ on your descriptor classes to allow them to take into account their surrounding class and its property names

Dynamic typing / meta should be used w/ care. Namely, they should be properly/fully covered by test + raise early (don't swallow, else weird usage can happen)

> * Avoid memory leaks and the weakref built-in module by having descriptors store data they manipulate directly within a class’s instance dictionary

> * Prefer __init_subclass__ over standard metaclass machinery because it’s clearer and easier for beginners to understand

Prefer adding simple clean contract (like a simple mixin, or if just dynamically adding class properties) to this.

> * Be sure to call super().__init_subclass__ from within your class’s __init_subclass__ definition to enable validation in multiple layers of classes and multiple inheritance.

> * Python 3.6 introduced simplified syntax—the __init_subclass__ special class method—for achieving the same behavior while avoiding metaclasses entirely

> * metaclass receives the contents of associated class statements in its __new__ method

> * A metaclass is defined by inheriting from type

> * __getattribute__. This special method is called every time an attribute is accessed on an object, even in cases where it does exist in the attribute dictionary

> * If a class defines __getattr__, that method is called every time an attribute can’t be found in an object’s instance dictionary:

> * The foo attribute is not in the instance dictionary initially, so __getattr__ is called the first time. But the call to __getattr__ for foo also does a setattr, which populates foo in the instance dictionary. This is why the second time I access foo, it doesn’t log a call to __getattr__

> * The unique behavior of WeakKeyDictionary is that it removes Exam instances from its set of items when the Python runtime knows it’s holding the instance’s last remaining reference in the program.

> * The Grade instance for this attribute is constructed once in the program lifetime, when the Exam class is first defined, not each time an Exam instance is created.

> * The descriptor protocol defines how attribute access is interpreted by the language. A descriptor class can provide __get__ and __set__ methods that let you reuse the grade validation behavior without boilerplate.

> * Ensure that @property methods are fast; for slow or complex work—especially involving I/O or causing side effects—use normal methods instead.

> * Use @property to define special behavior when attributes are accessed on your objects, if necessary.

## 7. Concurrency and Parallelism

> * asyncio.run_coroutine_threadsafe function provides the same functionality across thread boundaries.

> * The run_until_complete method of the asyncio event loop enables synchronous code to run a coroutine until it finishes.

> * The awaitable run_in_executor method of the asyncio event loop enables coroutines to run synchronous functions in ThreadPoolExecutor pools

> * Python provides asynchronous versions of for loops, with statements, generators, comprehensions, and library helper functions

> * asyncio.run function to execute the simulate coroutine in an event loop and carry out its dependent I/O

> * The gather function from the asyncio built-in library causes fan-in.

> * it returns a coroutine instance that can be used with an await expression at a later time

> * async def instead of def

> * Once a coroutine is active, it uses less than 1 KB of memory until it’s exhausted. Like threads, coroutines are independent functions that can consume inputs from their environment and produce resulting outputs

> * The difference is that coroutines pause at each await expression and resume executing an async function after the pending awaitable is resolved

> * Although ThreadPoolExecutor eliminates the potential memory blow-up issues of using threads directly, it also limits I/O parallelism by requiring max_workers to be specified upfront.

> * ThreadPoolExecutor enables simple I/O parallelism with limited refactoring, easily avoiding the cost of thread startup each time fanout concurrency is required.

> * Python includes the concurrent.futures built-in module, which provides the ThreadPoolExecutor class.

> * Threads require a lot of memory—about 8 MB per executing thread. On many computers, that amount of memory doesn’t matter for the 45 threads I’d need in this example. But if the game grid had to grow to 10,000 cells, I would need to create that many threads,

> * Be aware of the many problems in building concurrent pipelines: busy waiting, how to tell workers to stop, and potential memory explosion.

> * The simplest and most useful of them is the Lock class, a mutual-exclusion lock (mutex).

## 8. Robustness and Performance

> * A memoryview can also be used to wrap a bytearray. When you slice such a memoryview, the resulting object can be used to assign data to a particular portion of the underlying buffer. This eliminates the copying costs from above that were required to splice the bytes instances back together after data was received from the client

> * bytearray type in conjunction with memoryview. One limitation with bytes instances is that they are read-only and don’t allow for individual indexes to be updated

> * The best part about memoryview instances is that slicing them results in another memoryview instance without copying the underlying data.

> * The power of multiprocessing is best accessed through the concurrent.futures built-in module and its simple ProcessPoolExecutor class.

## 9. Testing and Debugging

> * tracemalloc built-in module provides powerful tools for understanding the sources of memory usage

> * gc module can help you understand which objects exist, but it has no information about how they were allocated

> * tracemalloc makes it possible to connect an object back to where it was allocated

> * Python 3.4 introduced a new tracemalloc built-in module for solving this problem.

> * Use the cProfile module instead of the profile module because it provides more accurate profiling information.

> * extract statistics about its performance by using the pstats built-in module and its Stats class.

> * Python provides two built-in profilers: one that is pure Python (profile) and another that is a C-extension module (cProfile). The cProfile built-in module is better because of its minimal impact on the performance of your program while it’s being profiled.

> * Pass str instances to the Decimal constructor instead of float instances if it’s important to compute exact answers and not floating point approximations.

> * Decimal class is ideal for situations that require high precision and control over rounding behavior, such as computations of monetary values.

> * copyreg built-in module with pickle to ensure backward compatibility for serialized objects

> * After registration, serializing and deserializing works as before

pickle gives power over customized serial/deserial function

> * register these functions with the copyreg built-in module

> * define the unpickle_game_state helper. This function takes serialized data and parameters from pickle_game_state and returns the corresponding GameState object.

> * The copyreg module lets you register the functions responsible for serializing and deserializing Python objects, allowing you to control the behavior of pickle and make it more reliable.

> * The pickle module’s serialization format is unsafe by design

> * The purpose of pickle is to let you pass Python objects between programs that you control over binary channels.

> * The value yielded by context managers is supplied to the as part of the with statement. It’s useful for letting your code directly access the cause of a special context.

## 10. Collaboration

> * It can be useful to apply type hints to the most complex and errorprone parts of your codebase that aren’t part of an API

> * Type hints are most important at the boundaries of a codebase, such as an API you provide that many callers (and thus other people) depend on.

> * It’s going to slow you down if you try to use type annotations from the start when writing a new piece of code. A general strategy is to write a first version without annotations, then write tests, and then add type information where it’s most valuable

> * In production, you can replicate warnings into the logging module to ensure that your existing error reporting systems will capture warnings at runtime.

> * The warnings module can be used to notify callers of your API about deprecated usage. Warning messages encourage such callers to fix their code before later changes break their programs.

> * Having a root exception in a module makes it easy for consumers of an API to catch all of the exceptions that were raised deliberately

Extremely useful! I recently need to take care of catching a retryable error from external library. It turns out that method returns `RuntimeError` of a special error string. So I have to compare error message on top of catching that exception..

Another point here for API developer is that you should consider proper subclass: when user has to exam error msg and does an `if-else`, it's probably time to split that exception class.