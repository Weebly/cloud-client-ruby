# Weebly Cloud Client: Ruby

## Installation
To install the Weebly cloud client run:

	$ gem install weeblycloud

## Getting Started
To use the Weebly Cloud client libraries require `weeblycloud` and configure your API keys.

```ruby
require weeblycloud

Weeblycloud::CloudClient::configure(API_KEY, API_SECRET)
```

All future calls will use that API key and secret pairing.

## Resources

### Using and Modifying Resources
- The method **`resource.get_property(name)`** of a resource will return the property **name** of **resource**. If the property does not exist it will return **nil**.
- The method **`resource.set_property(name, value)`** will set the propety **name** of **resource** to **value** and returns **true**. If the property does not exist, it will return **false**. Changes will not be saved until the **`resource.save()`** method is called. The Weebly Cloud API does not suppot modifying every resource type nor every property of resource types it supports. For more information, reference the [Cloud API Documentation](https://cloud-developer.weebly.com/about-the-rest-apis.html) for the resource in question's `PUT` method.
- The method **`resource.id()`** will return the resource ID.
- Use the **`to_s`** method to print a JSON representation of the resource's property (i.e. `account.to_s`). To get the resources properties as a hash, use `resource.properties`.

### Optional parameters
Requests that take serveral optional parameters (i.e. filters or object properties) can have them passed with a options hash.

For instance, to sort all pages by title:

```python
site.list_pages("filterby" => "title", "fitlerfor" => "menu")
```

And to create a new site:

```python
user.create_site("example.com", 4, "brand_name" => "Brand Name")
```

### Account
[API Documentation](https://cloud-developer.weebly.com/account.html)

- **`create_user(email, properties={})`** Creates a `User`. Requires the user's **email**, and optionally accepts keyword arguments of additional properties. Returns a `User` resource on success.
- **`get_user(user_id)`** Return the `User` with the given ID.
- **`list_plans()`** Returns a list of all `Plan` resources.
- **`get_plan(plan_id)`** Return the `Plan` with the given ID.

### User
[API Documentation](https://cloud-developer.weebly.com/user.html)

- **`enable()`** Enables a user account after an account has been disabled. Enabling a user account will allow users to log into the editor. When a user is created, their account is automatically enabled.
- **`disable()`** Disables a user account. When a user account is disabled, the user will no longer be able to log into the editor. If an attempt to create a login link is made on a disabled account, an error is thrown.
- **`login_link()`** Generates a one-time link that will direct users to the editor for the last site that was modified in the account. This method requires that the account is enabled and that the account has at least one site.
- **`list_themes(filters={})`** Returns a list of `Theme` resources for a given user subject to filters.
- **`list_sites(filters={})`** Returns a list of `Site` resources for a given user subject to filters.
- **`get_site(site_id)`** Return the `Site` with the given ID.
- **`create_theme(name, zip_url)`** Creates a `Theme` with name **name**. Requires a **zip_url** and returns a `Theme` object.
- **`create_site(domain)`** Creates a `Site`. Requires the site's **domain** and optionally accepts keyword arguments of additional properties. Returns a `User` resource.

### Site
[API Documentation](https://cloud-developer.weebly.com/site.html)

- **`delete()`** delete the site.
- **`publish()`** Publishes the site.
- **`unpublish()`** Unpublishes the site.
- **`login_link()`** Generates a one-time link that will direct users to the site specified. This method requires that the account is enabled.
- **`set_publish_credentials(options={})`** Sets publish credentials to fields set in keyword arguments. If a user's site will not be hosted by Weebly, publish credentials can be provided. When these values are set, the site will be published to the location specified.
- **`restore(url)`** When a site is restored the owner of the site is granted access to it in the exact state it was when it was deleted, including the Weebly plan assigned. Restoring a site does not issue an automatic publish
- **`disable()`** Suspends access to the given user's site in the editor by setting the suspended parameter to true. If a user attempts to access the site in the editor, an error is thrown.
- **`enable()`** Re-enables a suspended site by setting the suspended parameter to false. Users can access the editor for the site. Sites are enabled by default when created.
- **`list_pages(filters={})`** Returns a list of `Page` resources for a given site subject to filters.
- **`list_members(filters={})`** Returns a list of `Member` resources for a given site subject to filters.
- **`list_groups(filters={})`** Returns a list of `Group` resources for a given site subject to filters.
- **`list_forms(filters={})`** Returns a list of `Form` resources for a given site subject to filters.
- **`list_blogs(filters={})`** Returns a list of `Blog` resources for a given site subject to filters.
- **`get_page(page_id)`** Return the `Page` with the given id.
- **`get_member(member_id)`** Return the `Member` with the given id.
- **`get_group(group_id)`** Return the `Group` with the given id.
- **`get_form(form_id)`** Return the `Form` with the given id.
- **`get_blog(blog_id)`** Return the `Blog` with the given id.
- **`get_plan()`** Returns the `Plan` resource for the site.
- **`set_plan(plan_id, term=None)`** Sets the site's plan to **plan_id** with an optional **term** length. If no term is provided the Weebly Cloud default is used (check API documentation).
- **`set_theme(theme_id, is_custom)`** Sets the site's theme to **theme_id**. Requires a parameter **is_custom**, distinguishing whether the theme is a Weebly theme or a custom theme.
- **`create_member(email, name, password, properties={})`** Creates a `Member`. Requires the member's **email**, **name**, **password**, and optionally accepts hash of additional properties. Returns a `Member` resource.
- **`create_group(name)`** Creates a `Group`. Requires the group's **name**. Returns a `Group` resource.

### Theme
[API Documentation](https://cloud-developer.weebly.com/theme.html)

> There are no `Theme` specific methods.

### Blog
[API Documentation](https://cloud-developer.weebly.com/blog.html)

- **`list_blog_posts(filters={})`** Returns a list of `BlogPost` resources for a given blog subject to filters.
- **`get_blog_post(blog_post_id)`** Return the `BlogPost` with the given id.
- **`create_blog_post(post_body, properties={})`** Creates a `BlogPost`. Requires the post's **body** and optionally accepts a hash of additional properties. Returns a `BlogPost` resource.

### BlogPost
[API Documentation](https://cloud-developer.weebly.com/blog-post.html)

- **`delete()`** delete the blog post.

### Form
[API Documentation](https://cloud-developer.weebly.com/form.html)

- **`list_form_entries(filters={})`** Returns a list of `FormEntry` resources for a given form subject to filters.
- **`get_form_entry(form_entry_id)`** Return the `FormEntry` with the given id.


### FormEntry
[API Documentation](https://cloud-developer.weebly.com/form-entry.html)

> There are no `FormEntry` specific methods.

### Page
[API Documentation](https://cloud-developer.weebly.com/page.html)

- **`change_title(title)`** Changes the title of the page to **title**. Does not require calling the `save()` method.

### Plan
[API Documentation](https://cloud-developer.weebly.com/plan.html)

> There are no `Plan` specific methods.

### Group
[API Documentation](https://cloud-developer.weebly.com/group.html)

- **`delete()`** Delete the group.

### Member
[API Documentation](https://cloud-developer.weebly.com/member.html)

- **`delete()`** Delete the Member.

### Examples

#### Creating a user and site, get a login link

```ruby
account = Weeblycloud::Account.new
user = account.create_user("test@email.com")
site = user.create_site("domain.com", "site_title" => "My Website")
puts site.login_link()
```

#### Printing the name of all pages in a site matching the query "help"

```ruby
pages = site.list_pages("query" => "help")

pages.each { |i| puts page.get_property("title") }
```

## Making Raw API Calls
Not every resource has a cooresponding resource class. It is possible to make a raw API call using a `CloudClient` object.

```ruby
client = weeblycloud::CloudClient.new
```
Using that client, call `get`, `post`, `put`, `patch`, or `delete`  which takes the endpoint and a hash of optional parameters:

- **content:** a hash of the request's body.
- **params:** a hash of query string parameters.
- **page (`get` only):** page of results to get
- **page_size (`get` only):** page size of results *(default is 25)*

#### Request examples

##### Get cloud admin account account
```ruby
# Create client
client = weeblycloud::CloudClient.new

# Request the /account endpoint
client.get("account")
```

##### Update a page title
```ruby
# Create client
client = weeblycloud::CloudClient.new

# build endpoint with parameters
endpoint = "user/#{USER_ID}/site/#{SITE_ID}/page/#{PAGE_ID}"

# Make the request
client.patch(endpoint, :content => {"title":"New Title"})
```

##### Get all sites for a user (with filters)
```ruby
# Create client
client = weeblycloud::CloudClient.new

# build endpoint with parameters
endpoint = "/user/#{USER_ID}/site"

# Make the request
client.get(endpoint, :params => {"role":"owner"})
```


### Handling Responses
All requests return a `WeeblyCloudResponse` object or raise an Exception (see error handling). Accessing the response is easy:

```ruby
response = client.get("account") # Make a request
puts response.to_s # get the response as a JSON string
# or
puts response.to_hash # get the response as a hash
```

If the results of a get request are paginated, then `response.paginated?` will be `true`.

- `response.max_page` contains the total number of pages.
- `response.current_page` contains the current page number.
- `response.records` is the number of total results.

###Pagination example
```ruby
client = weeblycloud::WeeblyCloud.new
response = client.get("user/#{USER_ID}/site")

# Print a list of site titles
puts response.map { |site| site['site_title'] }

```

## Error Handling
If a request is unsuccessful, a `ResponseError` exception is raised. This can be caught as follows:

```ruby
begin
	account = Weeblycloud::Account.new
	user = account.create_user("test@email.com")
	site = user.create_site("domain.com", "site_title" => "My Website")
	puts site.login_link()
rescue Weeblycloud::ResponseError => err
	puts err.code # Prints the error code
	puts err.message # Prints the error message
end
```

If a pagination method is called on a `WeeblyCloudResponse` that isn't paginated, a `PaginationError` exception is raised.

##Questions?

If you have any questions or feature requests pertaining to the Weebly Cloud Client, please open up a new issue. For general API questions, please contact us at [dev-support@weebly.com](dev-support@weebly.com), and we'll be happy to lend a hand!
