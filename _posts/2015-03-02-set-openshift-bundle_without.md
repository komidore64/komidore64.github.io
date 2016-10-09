---
layout: post
title: set openshift bundle_without variable
---
I spent far too long trying to figure out how to set OpenShift's `BUNDLE_WITHOUT` variable to limit the gems installed on my OpenShift container.
I searched far and wide through OpenShift's [documentation](https://developers.openshift.com/index.html) for information on how to do so.
At the time, the small amount of relevant [helpdoc](https://developers.openshift.com/en/ruby-environment-variables.html) that existed turned out to not be particularly helpful, or I was doing something wrong.
There is some OpenShift [doc](https://developers.openshift.com/en/managing-environment-variables.html#custom-variables) explaining that you can set environment variables using the following command from the `rhc` tool.

{% highlight bash %}
rhc env set BUNDLE_WITHOUT='development test' --app 'maprys'
{% endhighlight %}

I could've done that, I guess, but I didn't want to.
I do most of this site's coding on [Nitrous.io](https://www.nitrous.io/join/Ne4RmyEvhD8?utm_source=nitrous.io&utm_medium=copypaste&utm_campaign=referral) and some stubborn part of me didn't want to eat up disk space with the `rhc` tool.
Pedantic, probably.

Anyways, I figured out a way to set environment variables without having to use the `rhc` tool.
I can checkout the code from anywhere, change/add/remove variables, and I don't have to install an additional tool to do so.
You should already have a `.openshift` directory with some stuff in there.
Create `.openshift/action_hooks/pre_build` and open it in your favorite editor.
Inside, you'll want to paste the following code.

{% highlight bash %}
#!/usr/bin/env bash

source $OPENSHIFT_CARTRIDGE_SDK_BASH

if [ "$(type -t set_env_var)" == "function" ]; then
    set_env_var 'BUNDLE_WITHOUT' 'development test' $OPENSHIFT_HOMEDIR/.env/user_vars
fi
{% endhighlight %}

Adding this code finally gave me the proper `bundle install` command in the container that I was looking for.

```
$ git push openshift master
...
remote: Waiting for stop to finish
remote: Force clean build enabled - cleaning dependencies
remote: Building git ref 'master', commit 1825024
remote: Building Ruby cartridge
remote: bundle install --deployment --without 'development test' --path ./app-root/repo/vendor/bundle
...
```

Hooray!

You could use this same method to set other environment variables if you so desire.
Bash to the rescue.
Happy OpenShifting!

