## Homework_2 IOS


Theme: Using UIKit and Auto-layout to grant simple wishes.


Objective: Learn how to never use Storyboard ever again. Gain experience with UIKit and auto-layout, constraints in particular.


## Questions


* What issues prevent us from using storyboards in real projects?

Storyboards tend to become more complex as the project grows, especially in large-scale applications with multiple screens and view controllers

Storyboards can introduce difficulties in writing and maintaining UI tests and unit tests.

Storyboards can make it challenging to reuse UI components 


* What is a safe area layout guide?

 This is a view without top bars panel.


* What does clipsToBounds mean?
  
It means that we can clip (edit) stack bounds.

* What is the valueChanged type? What is Void and what is Double? 
type - a function that takes a Double (floating point number) and returns nothing (i.e. Void) (that is, it is a kind of delegate)


* What is weak self on line 23 and why is it important?
  
If you leave self, a strong reference to the object calling the method will be created, and when the method exits, it will not be deleted, which will lead to a memory leak. 


* What does the code on lines 25 and 29 do?

25: disables automatic resizing of elements so that we can set a custom one 29: allows resizing of objects and generally displays the added view
