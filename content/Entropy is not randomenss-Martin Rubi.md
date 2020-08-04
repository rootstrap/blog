# Entropy is not randomness

In this post I will talk a bit about the difference between the concepts of randomness and entropy.

## Randomness

Given a variable and a set of possible values for it randomness would be not to be able to predict with probability of 1.0 what will the next value be.

It will be one of its possibles values but it's not possible to know which one.

Also randomness is non deterministic, meaning that if I ask for the variable value many times in the very same conditions I might get a different value each time.

## Entropy

Given a variable and a set of possible values for it entropy would make the variable value to change a lot even if the conditions at the time of asking it change a little

Given the exact same conditions the value would be the same. [1]

In practice it's very hard to reproduce the very same initial conditions because of instruments precision and rounding errors during calculations.

In some processes a small variation in the initial conditions leads to a small variation in the result as well. For example a ball falling throgh a wall with not obstacles is a system with low entropy. If the initial point changes a little the ball will fall near the place I predict it will.

In other processes a small variation in the initial conditions leads to a very large variation in the result. It does not have to be a complex system but a system with high entropy.

For example a ball falling through a wall with many nails (like a pinball) is a system with high entropy.

## Why would any of this matter anyway?

Cryptographic algorithms inject entropy to make it difficult for an attacker to guess the original message.

The original message and some parameters would be the initial condition of the system and the cyphered message would be the result.

An algorithm that maps A to B, B to C, C to D is a cryptographic algorithm. It´s not a good though.

It´s too easy to guess the original message by trying out different messages and analisyng its results. It lacks of enough entropy to make the guessing more difficult.

Good cryptographic algorithms try to add a lot of entropy.

That means that even if I change only the first letter of a message the cyphered message changes a lot. So much that the original message is not guessable by comparing the differences in the result.


The problem is that introducing entropy is expensive in terms of computation and time to cypher and dechyper messages.

To cypher a message in a few seconds might be ok for a static document but not to cypher video frames during a real time communication.

## Switching entropy by randomness

Is there a way to avoid having to spend the cost of adding entropy to cypher the message?

There might be.

Let's say that instead of puting the effort in making the algorithm to add entropy during the cypher of the message we use a deadly simple algorithm that maps each occurrence of each unit in the original message to a random unit in the cyphered message.

For example it would map first occurrence of an A to a random letter, the first occurrence of a  B to a random letter, C to a random letter.

If the mapping is truly random there should not be any correlation between letters and mappings in the same cyphered message. For that reason it would not even need to add entropy. The relation between the plain and the cyphered message would be as indepedent and random as it gets.

Entropy would be replaced by randomness to make the cypher hard to guess.

But how would I decypher the message from a bunch of random symbols?

The mapping should be random but it also should be documented to both the origin and destination of the transmition.

## The algorithm

Let's say that both the sender and the receiver in the communication have a list of mappings of units of some kind. Not just one mapping but a list of many mappings. A lot of mappings.

For example they might have 100 keyboards with its keys layed out differently.

One keyboard would be the regular keyboard and all the others would be shiftings and swappings of the original keyboard.

These keyboards would not need to be random, they might be generated in a deterministic way.

Another example of mappings could be a 1Mb of 1s and 0s in some particular order. And we would have a lot of this 1Mb mappings.

To cypher the message, say a frame of a video, the sender and receiver would use a secure channel to agree an ordered sequence of this mappings to use. A list of integers between [1 ... #mappings generated].

Once the handshake is made through a secure channel the communication can begin.

The sender would cypher each part of each frame with a simple bitwise XOR operation between the original frame and one of those mappings.

The receiver would decypher it in the very same way.

For example they might agree to use the map 42 for the first 10 bytes, the map 3893 for the following 10 bytes, the map 323 for the following 10 bytes and so forth.

XOR is one of the less expensive operations a computer can do. All it does is to change a 1 for 0 or a 0 for a 1 depending on the second parameter. And its a revertible operation.

But since the second parameter is picked at random between the sender and the receiver and different mappings are used in different parts of the message it would not be easy to guess neither the mappings nor the original message. And the cypher and decypher would be lightling fast.

## Where did the computational effort went?

The entropy is still there but the effort to add it is shifted from using it to cypher the message to using to create the cypher key. In this case the mappings.


[1] Fun fact about deterministic and closed systems.
Given any function with lost of information, say the shift function which multiples by 2 and drops the first bit, given a value it's possible to know the result of the next shift but not the value from the previous shift.
In a deterministic system (and perhaps in all systems?) it's more possible to predict the future than to know the past.
