# HelloSign integration with React and Ruby on Rails

<img src="images/hellosign.png" alt="HelloSign" />

## What is HelloSign?

HelloSign allows you to electronically request and add legally valid signatures to any document, from new-hire agreements to loans, to NDAs. HelloSign is available in an intuitive web interface, a developer-friendly API, or as a Salesforce add-on.

## Ways of using HelloSign

There are two ways in which you can use HelloSign:

	1. Using your interface
	2. Using HelloSign website

The first one refers to integrating your API with HelloSign. This enables you to request signatures in multiple ways and in a wide range of technologies like PHP, Ruby, Java, Node.js, among others. The other alternative grants you the ability to send the legal document(s) to a person's email. 

In this article, we are going to talk about using your interface.

## Templates

Templates are reusable signature documents, ideal for commonly used forms like NDAs, Offer Letters, or Sales Agreements. Set them up once, save them as templates, and reuse the next time you need them.

How are they created? At HelloSign dashboard, there's a section called Create Template. There you can upload a document, set roles for each signer (e.g: Client, Me, Manager). Then, you can start adding fields to be filled out or field labels (read only). It's of utmost importance to write those fields the same way they are populated by the API (these are case sensitive).

## Backend

### To begin with

It's understood before diving into the backend implementation, that you already have a HelloSign account and at least one template created.

### HelloSign Ruby SDK

HelloSign provides a [Ruby SDK](https://github.com/HelloFax/hellosign-ruby-sdk) through which you're able to communicate with their API. It's pretty simple to get it up and running, the only thing you need to do other than bundling the gem, is configure the `api_key`, which you can find or create in the HelloSign web app under Settings > API. 

### Usage

Using the HelloSign client is dead simple. 

```
@client = HelloSign::Client.new(api_key: ENV['HELLOSIGN_API_KEY'])
```

That's it. Now through `@client` you're able to communicate with the HelloSign API. So what now? Let's create a document a user can sign.

To do this, there's a couple things we need to know:

	-**template_id**: this is the identifier of the template we created under our HelloSign account
	-**test_mode**: useful flag to let know the API we're just testing, it won't validate you're making the request from a valid URL
	-**client_id**: client_id which can be found in the HelloSign web app
	-**signers**: array of users that will ultimately sign the document
	-**signing_redirect_url**: this url is where the user will be redirected after he signed the document
	-**custom_fields**: since the document may be loaded with different information for different users, here is where this information should be passed to HelloSign, so a new document with the corresponding information is rendered. An object should be passed here, with the keys named exactly as it was set up in the template.

Next you can see an example of a call to create a new document:

```
def create_signature_request
	test_mode = ENV.fetch('HELLOSIGN_PRODUCTION_MODE', 'false') == 'true' ? 0 : 1

	signature_request = client.create_embedded_signature_request_with_template(
		test_mode: test_mode
		template_id: <template_id>,
		client_id: ENV.fetch('HELLOSIGN_CLIENT_ID'),
		signers: [
			{
				name: <signer_name>,
				email_address: <signer_email>
			}
		],
		signing_redirect_url: <callback_url>,
		custom_fields: <custom_fields>
	)

	@client.get_embedded_sign_url(signature_id: signature_id).sign_url
end
```

So with this last bit of code we created an embedded signature request. In the response from the API we can find some useful information, for instance, the `sign_url`. You need to send this to the frontend of your application so the document can be embedded.

And that's it! After the frontend of your application renders the document and the user signs, he'll be redirected to the callback url and will continue with the flow. 

But what if you want to validate if the document was in fact signed? Easy, HelloSign webhooks.

### Webhooks

HelloSign provides webhooks which you can configure to hit an endpoint in your API, and you'll start receiving different events. You can find thorough documentation regarding webhooks and events [here](https://app.hellosign.com/api/eventsAndCallbacksWalkthrough). You just need to listen for the events you need, and do stuff accordingly.

## Frontend

### HelloSign Embedded

HelloSign provides a [Javascript library for React](https://github.com/hellosign/hellosign-embedded) that allows embedding the documents to sign in your own application with minimal effort. In their repo, linked above, you can find the steps to install it. 

## Usage

To begin with, we must instantiate the HelloSign client. 

```
const helloSignClient = new HelloSign({ clientId: HELLOSIGN_CLIENT_ID })
```

Next thing we need, is get the urls of the documents to sign. This should be provided by the backend, as we mentioned above. Once we get these urls, we can show them. In order to display a document, we need to have a `<div>` with a specific id. 

```
<div id="hellosign-document-container" />
```

Then, the document can be displayed in said container. This is the way to do that:

```
const showContract = signingUrl => {
	helloSignClient.open(signingUrl, {
		allowCancel: false, 
		container: document.getElementById('hellosign-document-container'),
		skipDomainVerification: process.env.HELLOSIGN_PRODUCTION_MODE !== 'true'
	});
};
```

You are able also to handle the clients events, such as `sign` for instance.

```
helloSignClient.on('sign', () => {
	yourRandomFunctionToDoRandomStuff();
});
```

You can find more about events to handle [here](https://github.com/hellosign/hellosign-embedded/wiki/API-Documentation-(v2)#events)

## Conclusion

HelloSign is an easy way to allow the users of your application to legally sign documents, in a pretty straight forward way, and with minimum effort for the developers thanks to the out-of-the-box solution they provide.