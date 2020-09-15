# Hash functions in daily life - part I

I want to talk about passwords. Like the ones used to log into email accounts.

Hence I will talk a bit about ... laundry

## Doing the laundry with a hash function

Many years ago I moved to a new neighborhood and I used to do the laundry in a
store nearby.

I used to give the order number to the cashier and she would look upon all the
laundry bags for the one with the matching number.

The store was quite crowded and handled a lot of orders. Picking the laundry was
a pretty slow process.

During the time it took to find the laundry bag I used to think about how the search
could be improved.

I'll propose a possible optimization in the sections that follow.

## The orders grid

Each laundry bag was kept in a shelf made of boxes, like the one below


                  -------------------
                  |  |  |  |  |  |  |
                  -------------------
                  |  |  |  |  |  |  |
                  -------------------
                  |  |  |  |  |  |  |
                  -------------------

Each box could contain 0 or more bags.

The grid was filled by choosing the first empty space and storing the laundry bag
in it.

                  -------------------------
                  |   |   |   |   |   |   |
                  -------------------------
                  | . | . | . |   |   |   |
                  -------------------------
                  | . | . | . | . | . | . |
                  -------------------------


The first empty space was either an empty box or a partially filled box with
enough space for another bag.

If the grid had no space left the bags were stacked aside.

                  -------------------------
                  | . | . | . | . | . | . |
                  -------------------------
                  | . | . | . | . | . | . |
                  -------------------------
                  | . | . | . | . | . | . |
                  -------------------------   ...


To find the bag with a matching order number the cashier performed a lookup upon
all the bags in the grid.

That's a linear lookup. It's O(N), meaning that, let N be the number of
laundry bags stored in the grid, the lookup would take an average of N comparisons
to find the searched one.

Actually it would take an average of N/2 comparisons but the order of magnitude
between N and N/2 is the same and it´s said to be O(N) for simplicity.

To find a given bag could take less or more than N/2 but on average, given an evenly
distributed set of bags, it would take N/2 comparisons.

## Meet a hash function

Each laundry order number was a sequential integer number. The number was created
at the time of leaving the laundry in the store and was printed on the ticket.

The order number had around 10 digits.

The last digit of each order number was a number between 0 and 9.

That last digit could be used to optimize the lookup.

To make the optimization the grid might be divided into different boxes.

Some boxes would have a label assigned with a digit between 0 and 9.

For example

          -------------------------
          |   |   |   |   |   |   |
          -------------------------
          | 7 | 8 | 9 | 0 |   |   |
          -------------------------
          | 1 | 2 | 3 | 4 | 5 | 6 |
          -------------------------

At the time of storing the laundry, the cashier would look at the order number and
take its last digit only. If the box corresponding to the last digit had empty
space the bag would go into that box.

If the box had not enough space for a new bag the bag would go to the first box
with space among the unlabeled boxes.


The lookup of a bag would apply the same algorithm. First she would look for the
bag in the box corresponding to the last digit of the order. It the bag wasn't
there she would look for it in the unlabeled boxes.

That lookup is still O(N) in its worst case but in the average case it's O(1),
meaning that, on average, the lookup would take only a constant number of comparisons.

O(1) doesn't mean that it would take exactly one comparison. It means that the
number of comparisons is a constant number and it does not depend on the total
number of bags. In this case, the constant number would be the number of bags that
could fit in a single box.

As an example, if a box had enough space for 4 bags the average lookup would take
up to 4 comparisons regardless of the number of bags the rest of the shelf stored
at that time.

## Maps

This algorithm is widely used in computer science and it's known as a hash table
lookup.

It's used to arrange items in such a way that a given item can be found in O(1)
time.

If you ever used a Map, a Dictionary or a Hash then you might have already used one.

Map objects are commonly implemented as hash lookup tables.

## Hash functions

Taking the last digit from the order number is known as applying a hash function
to the order number.

A generalization of a hash function would take an infinite set, for instance, the set
of all integer numbers, and map each element to a finite set, for instance,
the numbers between 0 and 9.

For this hash function to make an actual improvement on the search time the
laundry order numbers would also need to meet some statistical conditions.

The order number last digit would need to be evenly distributed among all orders.
Otherwise, the number of hash collisions would be too high and it would end up
requiring a linear lookup on every search. Such a distribution is known as a
Normal or Gaussian distribution.

If the hash function is good for the statistical distribution of its domain set
it's said to be a good hash function. If it's not it's said not to be a good hash
function.

The goodness of a hash function depends on the domain set, on the mapped set and
on how the hash function would be used.


Of course I never mentioned anything related to hash functions, lookup algorithms
or statistical distributions to the cashier. It was a lovely laundry store and I
wanted to keep going there.

## Summary

The article gave an informal definition of what a hash function is.
It showed a concrete example of a simple hash function and it explained how to
use it to optimize a problem that, at a first glance, did not seem to be related
to a computational algorithm.
