# Queues

A computer can execute just a few instructions at the same time. Some might even process just a single instruction at a time.

The how do computers manage themselves to accomplish multitasking?

## Processors

A processor does calculations by ticks. On each tick a processor executes a single instruction like adding two numbers.

On one tick the computer prepares the numbers to add, in the next tick the processor does the addition and in a third tick the computer assigns the result to a variable.

A computer have just a few processors or even a single one. That means the they can execute one or just a few instructions per tick.

Let's see how they manage to execute many processes at the same time.

## Multitasking

To handle several concurrent processes a computer has a queue of running processes.

On each tick only one process uses the processor to execute an instruction but the operative system alternates the use of the processor among the processes in the queue.

For example the operative system would assign the use of the processor to process A, then to process B, then to process C and so forth.

By splitting the use of the processor among the queued processes in an interval of time it accomplish concurrent processing even if at a single tick only one process works on the processor.


## Priority queues

A simple yet naif implementation of the process queue could just assign the use of the processor once to each queued process.

That strategy to pick the next process to execute is called Round Robin.

In practice that strategy usually is not feaseable because not all processes have the same priority.

For example a process of the operative system probably needs a higher priority than one of an application because it handles the structure needed by that application.

For that reason processes have priorities and the use of the processor is assigned with a strategy consideres that priority in the assignment.

So to pick a process from the queue it could just pick the one with higher priority, right?

Well, not quite so.

That strategy has its own problems one of which is making the processes with lower priority to never get picked.

That problem is called starvation.

## The waiting room

Suppose there's a health clinic to treat patients without a previous date. For example an emergency room.

Patients arrive, announce themselves and wait to be called by the next available specialist.

One strategy to call each patient could be their arrival order. Whoemever arrives first gets called first.

That is somewhat similar to the Round Robin strategy and has its very same problem.

If patient A, B and C arrive first and then a patiend D comes with a critical urgence he would have to wait until the other patiens get called which could put its health in danger.

Now let's try the other way around.

Suppose that each patient is asked what the consultation is for and they are assigned a priority when they announce themselves in.

Every time a specialist is available (what in the processor would be a tick) the patient with the higher priority gets called.

That works pretty well to treat critical urgencies but has the same starvation problem than processes do.

If patient A has the lowest priority of all possible consultation and another patient arrives before he gets called he would never get called even. Not even if the other consultations are not urgent.

## A different solution

There is a branch of the computer science dedicated to the study of the priority queues and there exist many different strategies to pick the next process or patient from a queue.

Let's see a couple of them.

One is to assign to each patient a number n and to calculate the priority like

```
   priority + n
```

What value should have n have?

Whan a patien arrives it's

```
n = 0
```

Then every time a new patient arrives (every tick) n increases by 1 on all the patientes already waiting.

```
when a new patient arrives
n = n + 1
```

That makes the priority of each patient to increase in time during its waiting.

So if a patient A arrives with priority 1 and in the next tick a second patient B arrives with priority 5, patient B will be called first.

However if the same happens after 6 ticks A will have a priority of 6 and a new patient C with priority 5 will not be called before A this time.

The problem with that strategy is that it is not possible for the patient to have upfront an upper bound to how much he would have to wait for because it depends on non deterministic events.

Another strategy is to assign an arrival number to each patient and call them by that number, which would be a Round Robin strategy, but with ranges of numbers.

The priority is divided in 3 different types, say A, B, C. A has higher priority over B and C, and B over C.

When a patient arrives he's asked for the consulation and depending on his priority he's is assigned a number as follows:

A = the next number between 1 and 15
B = the next number between 16 and 25
C = the next number between 26 and 30

A patient with priority A might receive a number between 1 and 15 and he would only had to wait for other patients with priority A.

On the other hand a patient C will receive a number between 26 and 30 and will have to wait for all As, Bs and Cs before him.

But in no case he would have to wait more than 30 numbers.

This stragegy gives a defined and clear upfront limit to how many ticks a patient will have to wait on the worst case and in average case he will be called before that since not all A and B numbers might be assigned before he is called.

Once the number 15 is called the new range of numbers to assign become from 31 to 60 and the ones that were not assigned yet are discarded.

## Other use cases

The last strategy can be applied in not critical treatments where children may arrive like a vaccination room.

If an adult arrives and gets a call for 29 ticks later he can deal with it. Explaining a child that he would have to wait that long is not that easy and for that reason children get the first 0 to 15 numbers.

Of course there is no need to explain each patient how numbers are assigned but numbers do get called in strict upfront order and all patient expectations are fullfilled.

Another example would be the assigment of tasks in a multiple tasks environment like writing both programs and articles.

If the writing the this article is assigned a marginal priority compared with other tasks this article might never get writen because there will always be another task with highier priority, even if that priority is low, and the writing will starve.

Different would be the case of assigning a marginal amount of time, yet defined upfront, to dedicate to writing articles or to any other task making sure that during that period of time no other task will interrumpt it.
