# Data demystified - Part 1/4
We've all seen a massive trend around data in the last times. Data "experts" are becoming the best-paid individuals in the industry, and every single company wants to surf the wave of data capabilities. 

The goal of this article is painting a picture of what these buzzwords mean, what can and can't be done, and what are the leading technologies that you should explore if you are jumping on this journey. 

You are reading the first of 4 articles about data analysis. It'll start with some foundational knowledge and then step-by-step building up the necessary Knowledge to build more sophisticated and robust systems (both computational and thinking processes) to achieve outstanding breakthroughs. 

## DIKW pyramid
I believe that introducing this concept can help to shape the way we think. This pyramid is a well-known concept, yet not a lot of people understands where they are at, and the right interpretation. 

![DKIW Pyramid](images/dkiw.png)

According to Jennifer Rowley (2007), "Typically information is defined in terms of data, knowledge in terms of information, and wisdom in terms of knowledge."

**Data** is just a set of signals or symbols. It's useless and just noise. It can be server logs or user behavior events. If we don't know what it means, it's futile. It's unorganized and unprocessed. It's inert.

You have **Information** when you start to make data useful. When we apply systems to organize and classify data, we can transform this unstructured noise into Information. The "What", "When" and "Who" question should be answered at this stage. In short, Information is data with meaning.  This "meaning" can be useful but does not have to be.

**Knowledge** is the next step in the journey, and probably the most significant leap. It implicitly requires learning. It means that we can take data, categorize and process it generating Information, and organize all this Information in a way that it can be useful. Whereas Information can help us to understand relations, Knowledge will help us to detect patterns. It's the foundation that will allow us to build predictive models. A definition that I like is that Knowledge is a mental structure, made from accumulated learning and systematic analysis of Information. 

**Wisdom** is the final frontier. It allows us to predict the future correctly, not only by detecting and understanding patterns but also deeply comprehending the "Why". Wisdom is all about the future. It relies on Knowledge and models but even helps to shape your "gut feeling" and intuition, giving you an exponential competitive advantage. Knowledge ages quickly because of the reality changes, but wisdom will remain more rigid. For now, this is a pure human skill, but AI is catching up fast. When AI wisdom becomes better than human wisdom, the outcomes are just unpredictable. 

The following image exemplifies perfectly this mental model:

![DKIW](images/data_information_knowledge_insight_wisdom.jpg)

## A dummy example
**Data**: It's raining

**Information**: The temperature dropped 5 degrees, the humidity went up by 5% in one hour and then it started raining at 3 pm. 

**Knowledge**: An quick increase in the humidity, accompanied by a temperature drop caused by lower pressure areas, will likely to make the atmosphere unable to hold the moisture and rain. 

**Wisdom**: Based on the observations and maths model, we can predict why and when it will rain in the future, and we can do it so fast and systematically that won't require a lot of analysis. We already have an understanding of all the interactions that happen between raining, evaporation, air currents, temperature gradients, changes, and raining.

## Bonus points
**Representativeness heuristic** is used by our brain to infer patterns. Our brain uses a vast percentage of its capacity to create patterns and is obsessed with trying to understand and predict the world successes. We have to be careful and not jumping to conclusions too soon. Knowing that we have this tendency to chase and see patterns everywhere, can help us to slow down when it comes to inferring patterns. This is a topic for another article, but I just wanted to bring it to the table.

**Availability Bias** is somewhat related to the previous concept. It's a mental shortcut that relies on immediate, urgent Information, and tries to generalize the findings. Under this bias, people tend to heavily weigh their judgments toward more recent Information, making new opinions biased toward that latest news. 

### Origin of the DIKW hierarchy
It's not data sciences. Not even the engineering field. The origin of this mental framework is poetry. The poet T.S.Eliot was the first to mention the "DIKW hierarchy" without even calling it by that name. In 1934 Eliot wrote in "The Rock":

```
Where is the Life we have lost in living? 
Where is the wisdom we have lost in Knowledge? 
Where is the Knowledge we have lost in Information?  
```

Though this is the first mention of the hierarchy in the arts, it is not the only one. Before management and information science caught on, Frank Zappa alluded to the hierarchy in 1979:

```
Information is not Knowledge, 
Knowledge is not wisdom, 
Wisdom is not truth, 
Truth is not beauty, 
Beauty is not love, 
Love is not music, 
and Music is THE BEST
```

### References
1. Russell .L. Ackoff, "From Data to Wisdom," Journal of Applied Systems Analysis 16 (1989): 3-9. 
2. Milan Zeleny, "Management Support Systems: Towards Integrated Knowledge Management," Human Systems Management 7, no 1 (1987): 59-70. 
3. M. Cooley, Architecture or Bee? (London: The Hogarth Press, 1987). 
4. Harland Cleveland, "Information as Resource," The Futurist, December 1982, 34-39. 
5. T.S. Eliot, The Rock (Faber & Faber 1934). 
6. Frank Zappa, "Packard Goose" in album Joe's Garage: Act II & III (Tower Records, 1979).
7. Nikhil Sharma, "The Origin of Data Information Knowledge Wisdom (DIKW) Hierarchy", (Google Inc, February 2008).