# What's the meaning of server-less architecture?
If you are thinking of "Apps running without servers", the answer is NO. 

The terms refer to apps(web|mobile|games) that use a third-party service as a back-end with infrastructure already implemented instance of using a dedicated server. For example, Amazon with AWS Serverless Application Repository | AWS Lambdas, Google with Firebase, Microsoft with Azure Serverless, Node JS with RealmDB that use GraphQL and others.

### Traditional architecture: 
![](images/classic_arch.png)

### Serverlees architecture:
![](images/serverless_arch.png)

### Understanding the server-less architecture
Now, let’s see what the images above mean with two real application scenarios.
1. Imagine that we have a blog app and we want to create a new blog post.
 - **Using traditional architecture:**
We sent that information to the server, the server verifies that we have permissions to create a new post and saves the data into the database, the Front-End doesn’t care where or how the server is saving the data.
 - **Using server-less architecture:**
All we have to do is save the data into the database directly and the same database checks with the security rules if the data can be saved,  and the server-less service takes care of the security in both cases, so we don't have to take care of it.

2. In the same blog app, we now need to show the feed of posts.
 - **Using traditional architecture:**
We ask for the feed, the server verifies first that we have the authorization to call that endpoint, then we ask the database for the data and respond to the data in a certain format.
 - **Using server-less architecture:**
All we have to do is create a function to get the data or make a call to the database, and the server-less service takes care of the security in both cases, so we don't have to take care of it.
Note that in both cases when you are using a server-less solution the tests in the back-end are not needed, however with a traditional architecture we need to write a lot of tests besides coding the entire solution.

### Advantages:
- The service takes care of the infrastructure.
- They take care of maintenance.
- Have strong security rules that you can modify them if needed.
- You only have to focus on the application logic.
- SDKs for all platforms.
- Enhanced Latency(better user experience) & Geo-location.
- The cost depends on the usage*.
- The learning curve is quite fast.
- Less human resource cost.
- Horizontal scalability
- Services provide integration with other platform services.
- The server-less service uses its authentication service and integrations with other authentication tools like Google, Facebook, Apple, etc... 

### Disadvantages:
- Limitations with business logic.
- Scalability is limited to service capabilities.
- It's hard to debug functions or tasks.
- Sometimes the security rules are complicated.

**The cost depends on the usage:** Usually, the cost is cheaper than traditional cloud solutions, but you have to consider in your business analysis that the more you use the service the higher will be the price. If you have 2k users it will probably be free but if you have 200k users the cost will go up, depending on how many actions/functions you have, so just keep that in mind. Before selecting the service to use, take a look at the operational cost users/actions. Usually, all services have pricing calculation tools. With traditional architectures, you are billed monthly by the cloud provider, it doesn't matter if your application has traffic or not. In the case of a server-less solution you "pay as you go" so you don't have to worry about the extra billing.

### Use Cases:
- News apps, Blogs, Reservations, in general applications that only show information and with little or none business logic. Most of the business logic is in the Front-End.
- Chats, bots, customer services.
- Applications that share real-time data like the stock market, the weather, IoT applications, geo-location, games, and others.
- Social networks.
- Microservices.

In conclusion, server-less is a great option for applications that do not need complex business logic or need real-time data. Also, development time can be optimized, since you don't need to write any code for the back-end or deploy any solution and a single developer can take care of both the front-end and the back-end, which is a saving in human resource.
