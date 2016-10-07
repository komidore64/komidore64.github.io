---
layout: post
title: set vim colors in iterm2
---
I have been using [Vim](http://www.vim.org) almost exclusively for 3 years now.
It has become my text editing workhorse for both code and also prose.
Vim has become a joy to use and to continue configuring and tweaking.
Many more paragraphs could be spent explaining the greatness of Vim to you, but I will refrain.
Today we're talking about colors in Vim.

I just recently switched to [iTerm 2](https://www.iterm2.com) from using OS X's default Terminal.app.
Terminal.app met my needs for the most part except its [inability to handle a long command that spilled into the next line](http://kill-0.com/duplo/2011/03/02/tmux-with-terminal-app-line-wrapping-weirdness/).
I started using Terminal.app back in 2008, and this bug is still occurring.
I decided to check out iTerm 2 after my buddy Og ([@ogmaciel](https://twitter.com/OgMaciel)) suggested it because, "it's awesome, dude!"

I'm happy with iTerm 2 so far, but it took me a few to figure out the color situation.
I like a dark background with light text in my terminal, but I prefer Vim's light-background color palette to its dark-background colors.
This was never an issue in Terminal.app, but it seems that iTerm 2 is setting some value that Vim interprets causing it to default to `background=dark`.
After poking around Vim's help docs and experimenting with ordering I came upon the [magic incantation](https://github.com/komidore64/dotfiles/commit/9ec628e037a5f186711736a668465607a34b8cea) providing my desired results:

{% highlight viml %}
set nocompatible
[...]
colorscheme default
set t_Co=256
set background=light
[...]
{% endhighlight %}

I haven't messed with it a whole lot, but my guess is these settings would go best near the top of your `~/.vimrc` before you load any plugins or start changing other colors.
For more info on these settings, please see Vim's help system with `:help nocompatible`, `:help colorscheme`, `:help t_Co`, and `:help 'background'`, respectively.

Now I have iTerm 2 set up just the way I like it, with Vim colors the way I like them.
All quiet on the terminal front.
Happy Vimming!

Anybody know how I can keep the exact same settings as above but give [MacVim](https://github.com/b4winckler/macvim) a black background?

