![](graphics/solutions-microsoft-logo-small.png)

# Python for Data Professionals

## 02 Programming Basics

<p style="border-bottom: 1px solid lightgrey;"></p>

<dl>
  <dt>Course Outline</dt>
  <dt>1 - Overview and Course Setup</dt>
  <dt>2 - Programming Basics <i>(This section)</i></dt>
    <dd>2.1 - Getting help</dd>
    <dd>2.2 Code Syntax and Structure</dd>
    <dd>2.3 Variables<dd>
    <dd>2.4 Operations and Functions<dd>
  <dt>3 Working with Data</dt>
  <dt>4 Deployment and Environments</dt>
<dl>

<p style="border-bottom: 1px solid lightgrey;"></p>

## Programming Basics Overview

From here on out, you'll focus on using Python in programming mode - you'll write code that you run from an IDE or a calling environment, not interactively from the command-line. As you work through this explanation, copy the code you see and run it to see the results. After you work through these copy-and-paste examples, you'll create your own code in the Activities that follow each section.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>2.1 - Getting help</b></p>

The very first thing you should learn in any language is how to get help. You can [find the help documents on-line](https://docs.python.org/3/index.html), or simply type
 
`help()`
 
in your code. For help on a specific topic, put the topic in the parenthesis:
 
 `help(str)`

 To see a list of topics, type 

 `help(topics)`

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>2.2 Code Syntax and Structure</b></p>

Let's cover a few basics about how Python code is written. (For a full discussion, check out the [Style Guide for Python, called PEP 8](https://www.python.org/dev/peps/pep-0008/) ) Let's use the "Zen of Python" rules from Tim Peters for this course:

<pre>

    Beautiful is better than ugly.
    Explicit is better than implicit.
    Simple is better than complex.
    Complex is better than complicated.
    Flat is better than nested.
    Sparse is better than dense.
    Readability counts.
    Special cases aren't special enough to break the rules.
    Although practicality beats purity.
    Errors should never pass silently.
    Unless explicitly silenced.
    In the face of ambiguity, refuse the temptation to guess.
    There should be one-- and preferably only one --obvious way to do it.
    Although that way may not be obvious at first unless you're Dutch.
    Now is better than never.
    Although never is often better than right now.
    If the implementation is hard to explain, it's a bad idea.
    If the implementation is easy to explain, it may be a good idea.
    Namespaces are one honking great idea -- let's do more of those!
    --Tim Peters

</pre>

In general, use standard coding practices - don't use keywords for variables, be consistent in your naming (camel-case, lower-case, etc.), comment your code clearly, and understand the general syntax of your language, and follow the principles above. But the most important tip is to at least read the PEP 8 and decide for yourself how well that fits into your Zen.

There is one hard-and-fast rule for Python that you *do* need to be aware of: indentation. You **must** indent your code for classes, functions (or methods), loops, conditions, and lists.  You can use a tab or four spaces (spaces are the accepted way to do it) but in any case, you have to be consistent. If you use tabs, you always use tabs. If you use spaces, you have to use that throughout. It's best if you set your IDE to handle that for you, whichever way you go.

Python code files have an extension of `.py`.  

Comments in Python start with the hash-tag: `#`. There are no block comments (and this makes us all sad) so each line you want to comment must have a tag in front of that line. Keep the lines short (80 characters or so) so that they don't fall off a single-line display like at the command line.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkbox.png"><b>2.3 Variables</b></p>

Variables stand in for replaceable values. Python is not strongly-typed, meaning you can just declare a variable name and set it to a value at the same time, and Python will try and guess what data type you want. You use an `=` sign to assign values, and `==` to compare things.

Quotes \" or ticks \' are fine, just be consistent.

`# There are some keywords to be aware of, but x and y are always good choices.`

`x = "Buck"    # I'm a string.`

`type(x)`

`y = 10        # I'm an integer.`

`type(y)`

To change the type of a value, just re-enter something else:

`x = "Buck"    # I'm a string.`

`type(x)`

`x = 10        # Now I'm an integer.`

`type(x)`

Or cast it By implicitly declaring the conversion:

`x = "10"`

`type(x)`

`print int(x)`

To concatenate string values, use the `+` sign:

`x = "Buck"`

`y = " Woody"`

`print(x + y)`

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkbox.png"><b>2.4 Operations and Functions</b></p>

Python has the following operators:

    Arithmetic Operators
    Comparison (Relational) Operators
    Assignment Operators
    Logical Operators
    Bitwise Operators
    Membership Operators
    Identity Operators

You have the standard operators and functions from most every language. Here are some of the tokens:

<pre>

    !=                  *=                  <<                  ^  
    "                   +                   <<=                 ^= 
    """                 +=                  <=                  `
    %                   ,                   <>                  __
    %=                  -                   ==                     
    &                   -=                  >                   b" 
    &=                  .                   >=                  b' 
    '                   ...                 >>                  j  
    '''                 /                   >>=                 r" 
    (                   //                  @                   r' 
    )                   //=                 J                   |'
    *                   /=                  [                   |= 
    **                  :                   \                   ~  
    **=                 <                   ]                      

</pre>

Wait...that's it? That's all you're going to tell me? *(Hint: use what you've learned):*

`help('symbols')`

Walk through each of these operators carefully - you'll use them when you work with data in the next module.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity - Programming basics</b></p>

Open the **02_ProgrammingBasics.py** file and run the code you see there. The exercises will be marked out using comments:

`# <TODO> - Section Number`

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/thinking.jpg"><b>For Further Study</b></p>

- The PEP - https://www.python.org/dev/peps/pep-0008/
- Introduction to the Python Coding Style - http://stackabuse.com/introduction-to-the-python-coding-style/
- The Microsoft Tutorial and samples for Python - https://code.visualstudio.com/docs/languages/python 
- Coding requirements and standards - PEP - https://www.python.org/dev/peps/pep-0008/
- Another free online self-paced course - https://www.w3schools.com/python/default.asp 

Next, Continue to *03 Working with Data*