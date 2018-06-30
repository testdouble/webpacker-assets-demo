# Webpacker Assets Demo

In general, [rails/webpacker](https://github.com/rails/webpacker) is a
significant improvement over
[rails/sprockets](https://github.com/rails/sprockets) for managing JavaScript
assets, but it's generally just as capable at managing your fonts, CSS, and
image assets as well. The
[documentation](https://github.com/rails/webpacker/blob/master/docs/assets.md)
on how to accomplish this is probably not very clear to Rails developers without
prior experience using [Webpack](https://webpack.github.io).

## Set up

```
$ bundle
$ rails s
```

Once the server is running, visit [localhost:3000](http://localhost:3000). You
should see something like this:

<img width="1440" alt="screenshot of working app" src="https://user-images.githubusercontent.com/79303/42125886-144e01d4-7c4d-11e8-8c53-54404f3888d9.png">

## Loading an image

First, this repo demonstrates loading an image:

1. Storing an image where Webpack's
   [file-loader](https://github.com/webpack-contrib/file-loader/) can find it
   (`/app/javascript/images` in this case)
2. Importing that image from JavaScript being compiled by Webpack, which will
   add it to the
   [public/packs/manifest.json](http://localhost:3000/packs/manifest.json). This
   exposes the asset to helper methods in Rails like
   [asset_pack_path](https://github.com/rails/webpacker/blob/master/lib/webpacker/helper.rb#L13)
3. The value assigned by `import testDoubleSvg from '../images/test-double.svg'`
   will be the root-relative path of the file, including the hash fingerprint
   on the file name

Check out [this
commit](https://github.com/testdouble/webpacker-assets-demo/commit/d9c58850fb1666be9d620f22d545c79ef0835bb2)
for more detail.

## Compiling styles via Webpacker instead of Sprockets

Second, this repo shows how to compile your styles (SCSS in this case) using
Webpacker instead of Sprockets. I suspect doing this would help lots of teams
drop their Sprockets dependency, which in turn speed up `rake assets:precompile`
quite a bit at deploy-time, since `webpacker:compile` would overtake the command
outright.

1. Put your style entry point somewhere (I chose
   `app/javascript/css/application.css`)
2. Again, import the styles somewhere from your JavaScript. This is truly a
   silly step, but it's necessary in order to get it added to the manifest and
   thereby linkable from your ERB template. In
   `app/javascript/packs/application.js` this is as simple as `import
   '../css/application.scss'`. There's no point assigning the import to
   something since we're only loading it for the side effect (ugh)
3. Finally, we can reference the template from our layout with:
   `<%= stylesheet_pack_tag 'application' %>`

Here is the [relevant commit](https://github.com/testdouble/webpacker-assets-demo/commit/05465e61f67061c9708d929522aa9a3a3ffc4931).
