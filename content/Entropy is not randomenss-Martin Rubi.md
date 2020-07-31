# Entropy is not randomness

I will talk a little about the difference between the concepts of randomness and entropy.

## Randomness

Given a variable and a set of possibles values the variable can have randomness would be not to be able to know in advance nor predict with probability 1.0 what will the next value be.

It will be one of its possibles values but I could not know which one.

Randomness is also non deterministic, meaning that if I ask for the variable value in the same conditions I might get a different value each time.

## Entropy

Given a variable and a set of possibles values the variable can have entropy would make the value to change a lot event if the conditions at the time of asking it changes a little.

But given the exact same conditions the value would be the same.

In practice it's very difficult to reproduce the very same conditions because of instruments precision and rounding errors during calculations for example.

In some processes those small variations in the initial conditions lead to small variations in the result as well. For example to predict where an object will fall if I drop it. If I move the object a little it will fall near the place I predict it will.

In other processes a small variation in the initial conditions lead to a very large variation in the result. It does not have to be a complex system but a system with much entropy.

## Why would any this matter anyway?

Cryptographic algorithms injects entropy to make it difficult for an attacker to guess the original message.

The original message and some paramters would be the initial condition of the system and the cyphered message would be the result.

An algorithm that maps A to B, B to C, C to D is a cryptographic algorithm. It´s not a good though.
It´s too easy to guess the original message by trying out different messages and analysins its results. It lacks of enough entropy to make that guessing more difficult.

Good cryptographic algorithms try to add a lot of entropy.

That means that even if I change only the first letter of a message the chypered messages changes a lot. So much that the original message is not guessable by comparing the differences in the result.


The problem is that introducing entropy is expensive in terms of computation and time to cypher and dechyper messages.

To chyper a message in a few seconds might be ok for a static document but not to cypher frames during a real time communication.

## Shifting entropy by randomess

Is there a way to avoid having to spend the cost of adding entroy to cypher the message?

Maybe.

Let's say that instead of putting the effort in making the algorithm to add entropy we use a dead simple algorithm that maps each occurrence of each unit in the original message to a random unit in the cyphered message.

For example it would map A to a random letter, B to a random letter, C to a random letter.

If the mapping is truly random there should not be any correlation between letters and mappings in the same cyphered message and for that reason it would not even need to add entropy.

Entropy would be replace by randomness to make the cypher hard to guess.

But how would I dechyper the message from a bunch of random letters?

Well the mapping should be random but it also should be documented to both the origin and destination of transmition.

## The algorithm

Let's say that both the sender and the receiver in the communication have a list of mappings of units of some kind. Not just one mapping but a list of many mappings.

For example they might 100 keyboards with different disposition of its keys.

One keyboard would the regular keyboard and all the others would be shiftings of the original keyboard.

These shifting would not need to be random, they might be generated in a deterministic way.

For example the mappings could be a 1Mb of 1 and 0 in some particular order. And they would have a lot of this 1Mb mappings.

To cypher the message, say a frame of a video, the sender and receiver would use a secure channel to agree an ordered sequence of this mappings to use. A list of integers between [1 ... #mappings generated].

Once the handshake is made through a secure channel the communication can begin.

The sender would chyper each part of each frame with a simple bitwise XOR operation between the original frame and one of those mappings.

The receiver would decypher it in the very same way.

For example the might agree to use the map 42 for the first 10 bytes, the map 3893 for the following 10 bytes, the map 323 for the following 10 bytes and so forth.

XOR is one of the less expensive operations a computer can do. All it does is to change a 1 for 0 or a 0 for a 1 in depending on the second parameter.

But since the second parameter is picked at random between the sender and the receiver and different mappings are used in different parts of the message it would not be easy to guess neigher the mappings nor the original message. And the cypher and decypher would be lighting fast.

## Where did the computational effort went?

The entropy is still there but the effort to add it is shifted from using it to chyper the message to using to create the keys, in this case the mappings.
