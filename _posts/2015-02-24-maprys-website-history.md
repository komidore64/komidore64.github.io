---
layout: post
title: maprys website history
---
**Maprys.net** started out back in my college days at [Elon](http://elon.edu).
I worked for a student/faculty group named [elite](https://wiki.elon.edu/pages/viewpage.action?pageId=39321890) (Emerging Leaders in Technology At Elon).
Our job was to provide basic to intermediate software support to students, faculty, and the community.
One requirement for the job was that we had to have our own personal website to display some of our tech skills and learn new technologies at the same time.
So my little college brain got to work trying to come up with something awesome that I could be proud of.

It began as a PHP and JavaScript application and it stayed that way for quite some time even after graduation.
I felt like I had programmed the site in a clever way at the time, but now I'm not so sure.
Regardless, you can view the last iteration of the **maprys.net** PHP creation on [Github](https://github.com/komidore64/maprys.net/tree/old-php) in all its "glory."

The revamp process commences.
I wanted to get away from PHP and remove as much JavaScript as possible.
I had since become a Ruby programmer, so I wanted to use as much Ruby as I could.
My desire was to find a web-framework/tool that would be small and easy to work with.
Ease of setup was very high on the must-have list.
After some time spent researching I eventually came across [Nesta CMS](http://nestacms.com).
It had quite a few nice features that I very much liked:

- built in Ruby
- uses [Sinatra](http://sinatrarb.com) as its web-application
- no database; the content consists of text files on the filesystem
- supports multiple markup languages out of the box: [Markdown](http://daringfireball.net/projects/markdown/syntax), [Haml](http://haml.info), or plain ole HTML
- no JavaScript
- easy to set up a development server

With Nesta, I can write all my pages and posts in Markdown, which I've learned since being on Github everyday.
Perfect!
Let me show you how easy it is to write a new post:

1. `$ vim content/pages/new-blog-post.md` \*
1. write some stuff
1. navigate your browser to `http://dev-server/new-blog-post`
1. profit!

Once I had a website that I was happy with, then I needed to figure out how I was going to host it.
I had no idea that [OpenShift](http://openshift.com) was what I needed until I started reading about it.
*Hey, what's this new Red Hat product that we're offering that seems to be making a lot of buzz?*
OpenShift served my needs perfectly.
It hosts small, containerized applications, for free.
Sweet!
It's main mechanism for getting code into the containers was [Git](http://git-scm.com).
Can this get any better?!
In less than 30 minutes, I had my Nesta application running in an OpenShift container on the Web.
The only money that has left my wallet has been to pay for my domain.

A nice-to-have feature would be to have some automatic deployment to my OpenShift container whenever I push new code to Github.
[Snap-CI](http://snap-ci.com) was able to make that happen.
Snap-CI is a hosted continuous integration tool that hooks in nicely with Github.
I've set up Snap-CI to push my new code to OpenShift whenever I push new commits to Github.
This allows me to focus on coding and putting content into the pages as opposed to wasting time getting new code into OpenShift whenever I'm done.

I love that I was able to bring a bunch of tools together to create a workflow that I'm happy with.
Knowing that I put in effort to making these tools work together, then seeing the end result has been very satisfying.

## tl;dr

[Nesta CMS](http://nestacms.com) is the framework.
Code lives on [Github](https://github.com/komidore64/maprys.net).
Hosted on [OpenShift](http://openshift.com).
Deployments using [Snap-CI](http://snap-ci.com/komidore64/maprys.net/branch/master).
Feeling proud.

## update 2016/10/06

Everything you just read about isn't used anymore!
Hooray.
Openshift started phasing out their free tier, so I switched to [Github Pages](http://pages.github.com).
Github Pages uses [Jekyll](http://jekyllrb.com) as its static-site generator, and I found this [DevJournal](https://github.com/hemangsk/DevJournal) theme made by Hemang Kumar on [Jekyll Themes](http://jekyllthemes.org/).
The site's code still lives on Github, but it has moved to [komidore64/komidore64.github.io](http://github.com/komidore64/komidore64.github.io).

###### \* the best text editor in the world
