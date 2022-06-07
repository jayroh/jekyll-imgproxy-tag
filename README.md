jekyll-imgproxy-tag
===================

`jekyll-imgproxy-tag` is a jekyll plugin that provides a Liquid tag that
generates a fully secure, fully qualified url to an image asset served via the
[imgproxy] tool.

Example tag:

```
{% imgproxy_url path: "/path/to/image.jpg", resizing_type: 'fill', width: 800, format: "webp" %}
```

[imgproxy]: https://imgproxy.net/

What's *imgproxy*?
------------------

> "imgproxy is the blazing fast and secure image processing tool".

It is an image optimizer written in Go that you can self-host as an alternative
to the larger commercial image optimization services like Imgix, Filestack,
Cloudinary, et al.

More information can be found on the [imgproxy docs website].

[imgproxy docs website]: https://docs.imgproxy.net/

Ok, how do I start with this?
-----------------------------

Step 1: have imgproxy running somewhere. For now, this library assumes you are generating
secure addresses to the images you are serving, so you will need to take note of the **salt**
and **key** that you are setting for your imgproxy instance. Typically these are ENV's set
with the `IMGPROXY_KEY` and `IMGPROXY_SALT` keys.

Cool. I wrote those down
------------------------

I hope you didn't actually write those down because that's not very secu...

I DIDN'T WRITE THEM ON A PIECE OF PAPER. SHEESH. Continue.
----------------------------------------------------------

Oops. Ok. cool.

In your Gemfile, add this gem:

```ruby
gem 'jekyll-imgproxy-tag'
```

And do the `bundle install` dance.

***

Add the plugin to Jekyll's `_config.yml` file:

```yaml
plugins:
  - jekyll-imgproxy-tag
```

*ALSO* add some required imgproxy config to that same `_config.yml` file:

```yaml
imgproxy:
  base_url: https://url-to-your-imageproxy-server.com
  key: the-very-long-KEY-that-is-set-in-your-imgproxy-instance
  salt: the-very-long-SALT-that-is-set-in-your-imgproxy-instance
  aws_bucket: your-s3-bucket-name
```

If you're checking that config file into source control then you might not want
to save that sort of sensitive information in your repo. As a result, this plugin
supports fetching environment variables by prepending `ENV_` in the values before
the name of your ENV's. If you use something like Netlify this is pretty handy.

```yaml
imgproxy:
  base_url: https://url-to-your-imageproxy-server.com
  key: ENV_IMGPROXY_KEY
  salt: ENV_IMGPROXY_SALT
  aws_bucket: ENV_AWS_BUCKET
```

How do I *USE* this?
--------------------

Now you're ready to use this in your pages and/or posts. The most base liquid
tag usage is `{% imgproxy_url path: '/path/AFTER/your/bucket/dot.jpg' %}`. If
the sample object is in S3 bucket at `s3://my-bucket/images/photos/puppy.jpg`
then your path would be `/images/photos/puppy.jpg`. Woof 🐶.

The options you may pass in to transform and optimize your image, and the
corresponding information on their significance in imgproxy's docs, are as
follows:

* `resizing_type` [🔗📝](https://docs.imgproxy.net/generating_the_url?id=resizing-type)
* `width` [🔗📝](https://docs.imgproxy.net/generating_the_url?id=width)
* `height` [🔗📝](https://docs.imgproxy.net/generating_the_url?id=height)
* `gravity` [🔗📝](https://docs.imgproxy.net/generating_the_url?id=gravity)
* `quality` [🔗📝](https://docs.imgproxy.net/generating_the_url?id=quality)
* `max_bytes` [🔗📝](https://docs.imgproxy.net/generating_the_url?id=max-bytes)
* `cache_buster` [🔗📝](https://docs.imgproxy.net/generating_the_url?id=cache-buster)
* `format` [🔗📝](https://docs.imgproxy.net/generating_the_url?id=format)

Examples:

* `{% imgproxy_url path: '/image.jpg', width: 300, height: 400, format: 'avif' %}`


Are there any gotchas?
----------------------

Hey, I'm glad you asked. There are!

***Coming Soon***

Development
===========

1. Clone this repo
2. `bundle`
3. `bundle exec rake`

New features should be paired with appropriate test coverage. (Please, and thank you.)

Currently not implemented but I would be thrilled to receive PR's or feedback on:

- [ ] Support for [plain source URL's](https://docs.imgproxy.net/generating_the_url?id=plain).
- [ ] Support for unsafe (unsigned) paths.
- [ ] Support for [serving local files](https://docs.imgproxy.net/serving_local_files?id=serving-local-files).
