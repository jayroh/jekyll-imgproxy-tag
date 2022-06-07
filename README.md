jekyll-imgproxy-tag
===================

`jekyll-imgproxy-tag` is a jekyll plugin that provides a Liquid tag that
generates a fully secure, fully qualified url to an image asset stored on Amazon S3, and served via the [imgproxy] tool.

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

More information can be found on the [imgproxy website].

[imgproxy website]: https://www.imgproxy.net/

Ok, how do I start with this?
-----------------------------

Step 1: have imgproxy running somewhere. For now, this library assumes you are generating
secure addresses to the images you are serving, so you will need to take note of the **salt**
and **key** that you are setting for your imgproxy instance. Typically these are ENV's set
with the `IMGPROXY_KEY` and `IMGPROXY_SALT` keys.

Cool. I wrote those down. Now what?
-----------------------------------

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

Ok. Now ... how do I *USE* this?
--------------------------------

Now you're ready to use this in your pages and/or posts. The most base liquid
tag usage is `{% imgproxy_url path: '/path/AFTER/your/bucket/dot.jpg' %}`. If
the sample object is in S3 bucket at `s3://my-bucket/images/photos/puppy.jpg`
then your path would be `/images/photos/puppy.jpg`. Woof 🐶.

The options you may pass in to transform and optimize your image, and the
corresponding information on their significance in imgproxy's docs, are as
follows:

* `resizing_type`
  * example: `{% imgproxy_url path: '/path/image.jpg', resizing_type: 'fill' %}`
  * Sample resizing types: `fit`, `fill`, `fill-down`, `force`, `auto`. Refer to the ...
  * [imgproxy docs](https://docs.imgproxy.net/generating_the_url?id=resizing-type)
* `width`
  * example: `{% imgproxy_url path: '/path/image.jpg', width: 960 %}`
  * [imgproxy docs](https://docs.imgproxy.net/generating_the_url?id=width)
* `height`
  * example: `{% imgproxy_url path: '/path/image.jpg', height: 400 %}`
  * [imgproxy docs](https://docs.imgproxy.net/generating_the_url?id=height)
* `gravity`
  * example: `{% imgproxy_url path: '/path/image.jpg', gravity: 'sm' %}`
  * Note, there are many options. Provided option, `sm`, means "smart gravity".
  * Please refer to the [imgproxy docs](https://docs.imgproxy.net/generating_the_url?id=gravity)
* `quality`
  * example: `{% imgproxy_url path: '/path/image.jpg', quality: '85' %}`
  * Note, this the resulting quality represented in percentage, from 0 to 100.
  * [imgproxy docs](https://docs.imgproxy.net/generating_the_url?id=quality)
* `max_bytes`
  * example: `{% imgproxy_url path: '/path/image.jpg', max_bytes: '100000' %}`
  * Note, these are ***BYTES***, not Kilobytes. (100000 bytes == 100kB)
  * [imgproxy docs](https://docs.imgproxy.net/generating_the_url?id=max-bytes)
* `cache_buster`
  * example: `{% imgproxy_url path: '/path/image.jpg', cache_buster: 'string' %}`
  * [imgproxy docs](https://docs.imgproxy.net/generating_the_url?id=cache-buster)
* `format`
  * example: `{% imgproxy_url path: '/path/image.jpg', format: 'webp' %}`
  * Sample formats: `png`, `jpg`, `webp`, `avif`, `gif`, etc. More info at ...
  * [imgproxy docs](https://docs.imgproxy.net/generating_the_url?id=format)


Are there any gotchas?
----------------------

Hey, I'm glad you asked. There are!

1. Currently **this plugin only works with assets that exist in Amazon S3**. Imgproxy needs to be set up to access.
2. Ensure that your instance of imgproxy has **sufficient (IAM) access to your S3 bucket(s) via the aws key and secret**.
3. If you're serving very large images, you may run into some issues. You can increase the max source image resolution via an environemt variable at your running imgproxy instance. For example `IMGPROXY_MAX_SRC_RESOLUTION=22.0` would allow for up to 22 megapixels. If it helps, there's [an online megapixels calculator here](https://toolstud.io/photo/megapixel.php?compare=video&calculate=uncompressed&width=1920&height=1080).
4. Setting `IMGPROXY_DEVELOPMENT_ERRORS_MODE=1` on your imgproxy instance will provide more detailed error messages.

For those of you setting up imgproxy yourself [there are many facets for configuration](https://github.com/imgproxy/imgproxy/blob/master/docs/configuration.md).


Development
===========

1. Clone this repo
2. `bundle`
3. `bundle exec rake`
4. New features should be paired with appropriate test coverage. (Please, and thank you.)

*** 

Currently not implemented but I would be thrilled to receive PR's or feedback on:

- [ ] Support for [plain source URL's](https://docs.imgproxy.net/generating_the_url?id=plain).
- [ ] Support for unsafe (unsigned) paths.
- [ ] Support for [serving local files](https://docs.imgproxy.net/serving_local_files?id=serving-local-files).

And, I'm always open for feedback - [@jayroh](https://twitter.com/jayroh) 🐦.
