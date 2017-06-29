# Subjuster | TDD guide for Software Engineers in OOP
<img src="images/tdd.png" width="100">
A command line tool to adjust your movie subtitle files while while playing audio 
and subtitle do not sync with each other. Normally it lags/gains by a few seconds/milliseconds. 
You will be able to adjust and generate a new subtitle file or update the existing one.

<!-- TOC START min:1 max:3 link:true update:true -->
- [Subjuster | TDD guide for Software Engineers in OOP](#subjuster--tdd-guide-for-software-engineers-in-oop)
  - [Intention / Purpose](#intention--purpose)
  - [Steps to TDD](#steps-to-tdd)
    - [Requirement Gathering](#requirement-gathering)
    - [Phase One: UML Drawing and Research](#phase-one-uml-drawing-and-research)

<!-- TOC END -->



## Intention / Purpose
I am writing this software for two of the main reasons  
- Teach TDD to emerging Software Engineers
  - The problem with new Engineers is, they find the concept of Testing 
    and Specially **TDD** mind bothering. 
  - This guide is supposed to guide them via the process.
  
> **Note**: If you feel that this doc/repo needs some modifications to help it 
better meet its purpose, please feel free to send a **Pull Request**. 
I would be very much pleased to merge it after reviewing.

## Steps to TDD
### Requirement Gathering
<img src="images/requirements.png" width="100"> Before you start a software project, 
there should be a problem somewhere in world in the first place which will you be solving. 
You gotta understand everything possible about the problem. Next will be, you figuring out 
ways to solve this problem. You are not supposed to the ultimate solution which is not gonna 
change ever; It's not possible, your solution should be robust and always changeable because 
**Requirements** always change down the road.

### Phase One: UML Drawing and Research
When you've thought of solutions, you grab notebook and pen; start making rough 
sketches(UML diagrams). Think of what your software does and list out separate 
tasks/actions to perform.  
#### Example(1) in our case:-  
1. Takes input from the users; may be from CLI or via STDIN(Keyboard)
   Inputs will be `filename.srt` and `number_of_seconds` | +ve or -ve
2. Parse the file supplied into some data-structure like `Hash`
3. Modify hash with required adjustments
4. Export or Generate the adjusted file to FileSystem.

Now, you draw Use Case diagram if possible. Its simple, go through some online blogs and 
start drawing. After that, you need to draw Class Diagram. This necessary to 
figure out what components your software is gonna compose. 

Lets do that: Extract out **nouns** from the list in Example(1).
1. UserInput
2. Parsertoc
3. Modifier / Adjuster
4. Exporter / Generator


>**Rule:** According to 
[`Single Responsibility Principle(SRP)`](https://en.wikipedia.org/wiki/Single_responsibility_principle) 
of Object Oriented Design from 
[`SOLID`](https://en.wikipedia.org/wiki/SOLID_(object-oriented_design)), 
one class/module/function should not take more than one responsibility.

![Use Case diagram of subjuster](images/use_case_diagram.png)

We comply to the rules and decide to have 4 modules doing individual tasks and collaborate with each other sending messages. Now we draw Class Diagram of our first thought. 
#### UML Design in Brief
![Class diagram in brief](images/class_diagram_brief.png)
> **Question:** What is this `Subjuster` module doing here?

This module is a wrapper to tie your application components together like `Namespace`. This module will facilitate your application; which we will cover in later topics. 

[Read this document in Class Diagrams](https://en.wikipedia.org/wiki/Class_diagram) and learn the meaning of `arrows` and boxes. This will help you in you career as well. Keep in mind that you don't have to learn UML and gain expertise to learn TDD; you only have to be able to draw boxes and name them. You can use [Draw.io](https://www.draw.io/) to draw UML diagrams; it's open source and free.


#### UML Designs in Detail
![Class diagram and use case diagram of subjuster](images/class_diagram.png)

#### Is it complicated?
If you feel lost, then no worries, forget about the relationship between modules; we will learn later. For now, focus on the boxes and its properties.


<!-- ![Class diagram and usecase diagram of subjuster](images/uml_diagram_2.png) -->