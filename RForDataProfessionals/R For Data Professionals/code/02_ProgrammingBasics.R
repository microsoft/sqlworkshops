# 02_ProgrammingBasics.py
# Purpose: General Programming exercises for R 
# Author: Buck Woody
# Credits and Sources: Inline
# Last Updated: 27 June 2018

# <TODO> - 2.1 Getting Help

### Start the HTML interface to on-line help (using a web browser available at your machine). OPen help this way and briefly explore the features of this facility with the mouse:

### Show one example of the help function. Is there more than one way to do that?

### Show the R version:

### Show all system environment settings:

#  Code Syntax and Structure


## Programming and Flow
x <- 1
if (x > 1) "Higher than 1" else "Not higher than 1"

0xFFFF

### loop types
i <- 5
repeat { if (i > 25) break else { print(i); i <- i + 5; }}

i <- 5
while (i <= 25) { print(i); i <- i + 5; }

for (i in seq(from = 5, to = 25, by = 5))
    print(i)

# Variables (Objects)

# <TODO> - Add a line below x<-3 that changes the object x from int to a string
x <- 3
typeof(x)

# <TODO> - Write code that prints the string "This class is awesome" using variables:
x <- "is awesome"
y <- "This Class"

# Operations and Functions

# <TODO> - Use some basic operators to write the following code:
# Assign two variables
# Add them
# Subtract 20 from each, add those values together, save that to a new variable
# Create a new string variable with the text "The result of my operations are: "
# Print out a single string on the screen with the result of the variables 
#   showing that result. 

# EOF: 02_ProgrammingBasics.R