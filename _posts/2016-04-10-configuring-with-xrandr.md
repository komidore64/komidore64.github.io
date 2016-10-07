---
layout: post
title: Configuring Your Monitors With XRandR
categories: linux xrandr
---
Have you ever gone to plug an external monitor into your linux laptop and it didn't result automatically in more desktop space?
This has happened to me recently with a fairly old but still useful monitor that I have at home.
Today I'm going to show you that using ``xrandr`` isn't near as intimidating as it sounds and that you can get your monitor up and running in just a couple commands.

I've started working from home a little more recently since I purchased my own home and now have a dedicated office.
The 1920-by-1080 monitor on my laptop is certainly no slouch, but I still miss my two monitors whenever I'm not sitting at my desk at work.
The monitor hooked up to my gaming PC is old, and the resolution isn't great compared to current standards, but it suits my needs for now.
I decided I'd plug in this monitor for whenever I work from home, giving no thought to it not being plug-and-play because it usually always is.
With laptop powered up, I plug in this Envision.
**Black**.
Maybe it'll take a couple seconds so I'll wait.
**Still black**.
Hmm.
The indicator light on the front of the monitor is still on standby-yellow.
Time to figure this out.

At this point, I knew that ``xrandr`` existed and I knew that is was for configuring displays.
Other than that it just sounded intimidating because one thinks _there's no way that manually configuring monitors can be easy_.
I spent a while doing some research on the Googles, mostly with links to Stack Overflow and a handful of other sites.
I'll be explaining my findings here.

First thing we need to do is confirm that the computer realizes a new display has been connected.
Easiest way to do this is to compare the output of ``xrandr -q`` before and after your monitor is connected.
In my case, Fedora 23 sees this Thinkpad's internal display as ``eDP1``, and the external display is ``DP2-1``.

So let's compare output:

```
$ xrandr -q
Screen 0: minimum 8 x 8, current 1920 x 1080, maximum 32767 x 32767
eDP1 connected 1920x1080+0+0 (normal left inverted right x axis y axis) 308mm x 173mm
   1920x1080     60.00*+
   1400x1050     59.98
   1600x900      60.00
   1280x1024     60.02
   1280x960      60.00
   1368x768      60.00
   1280x720      60.00
   1024x768      60.00
   1024x576      60.00
   960x540       60.00
   800x600       60.32    56.25
   864x486       60.00
   640x480       59.94
   720x405       60.00
   640x360       60.00
DP1 disconnected (normal left inverted right x axis y axis)
DP2 disconnected (normal left inverted right x axis y axis)
HDMI1 disconnected (normal left inverted right x axis y axis)
HDMI2 disconnected (normal left inverted right x axis y axis)
VIRTUAL1 disconnected (normal left inverted right x axis y axis)
```

Here is output with the external monitor connected:

```
$ xrandr -q
Screen 0: minimum 8 x 8, current 1920 x 1080, maximum 32767 x 32767
eDP1 connected 1920x1080+0+0 (normal left inverted right x axis y axis) 308mm x 173mm
   1920x1080     60.00*+
   1400x1050     59.98
   1600x900      60.00
   1280x1024     60.02
   1280x960      60.00
   1368x768      60.00
   1280x720      60.00
   1024x768      60.00
   1024x576      60.00
   960x540       60.00
   800x600       60.32    56.25
   864x486       60.00
   640x480       59.94
   720x405       60.00
   640x360       60.00
DP1 disconnected (normal left inverted right x axis y axis)
DP2 disconnected (normal left inverted right x axis y axis)
DP2-1 connected (normal left inverted right x axis y axis)
   1024x768      60.00
   800x600       60.32    56.25
   848x480       60.00
   640x480       59.94
DP2-2 disconnected (normal left inverted right x axis y axis)
DP2-3 disconnected (normal left inverted right x axis y axis)
HDMI1 disconnected (normal left inverted right x axis y axis)
HDMI2 disconnected (normal left inverted right x axis y axis)
VIRTUAL1 disconnected (normal left inverted right x axis y axis)
```

Note the added ``DP2-1`` display, which is our newly connected display.
If ``xrandr``'s output doesn't show you a newly connected display, unfortunately this article can assist you no further as troubleshooting a display connection is outside of our scope today.
[:(](http://www.nooooooooooooooo.com/)

After confirmation of a connected display, next we need to make sure ``xrandr`` has the correct modes for the monitor.
Sadly, in my case, ``xrandr`` had no idea what modes my display supported.
If your desired resolution shows up, then you are great shape, my friend!
You can skip this bit about creating a new display mode and adding it to the monitor.


My conversation with `xrandr`:

```
me:     Why didn't you auto-detect and configure my display?
XRandR: I think this is a monitor?
        Maybe.
        Pretty sure.
        ¯\_(ツ)_/¯
```

We're going to use ``cvt`` to give us all the proper information to create a new mode in ``xrandr``.
The arguments that ``cvt`` needs are (a) the horizonal number of pixels, (b) the vertical number of pixels, and optionally but probably a good idea to include (c) the monitor's refresh rate, usually 60 Hz.
Let's run it.

```
$ cvt 1680 1050 60
# 1680x1050 59.95 Hz (CVT 1.76MA) hsync: 65.29 kHz; pclk: 146.25 MHz
Modeline "1680x1050_60.00"  146.25  1680 1784 1960 2240  1050 1053 1059 1089 -hsync +vsync
```

Taking that output, we feed it straight into ``xrandr``:

```
$ xrandr --newmode "1680x1050" 146.25  1680 1784 1960 2240  1050 1053 1059 1089 -hsync +vsync
```

Looking good, but we're not done yet so don't leave.
That mode that we just created exists now, but ``xrandr`` needs to know that this new mode belongs to our monitor.

```
# xrandr --addmode MODE_NAME DISPLAY_NAME
$ xrandr --addmode 1680x1050 DP2-1
```

After all that, now we're ready to actually tell the monitor to display using that mode.

```
$ xrandr --output DP2-1 --mode 1680x1050
```

At this point, hopefully you'll at least be seeing something on the monitor.
We have the monitor working with linux now, which is great.
At this point we're just tweaking the placement.
``xrandr`` has options for relative placement (``--above``, ``--below``, ``--right-of``, ``--left-of``), as well as absolute pixel placement (``--pos``).
In my case I needed ``--above`` to get this external monitor where I wanted it.

```
$ xrandr --output DP2-1 --above eDP1
```

And there you have it.
That is how I managed to manually configure my displays.
I learned a lot about ``xrandr`` during this whole process.
At the same time, I'm sure there's still so much more to ``xrandr`` than what I uncovered here.
I now have a **huge** respect for plug-and-play monitor support because it's wonderful to simply plug in a monitor and see it working correctly in a couple seconds.
Kudos to you, whoever you are that makes that possible.

I hope that this information is helpful to someone along the way as they're googling when their monitor shows up as blank.
I'd love to be able to get this stuff to apply automatically whenever I plug this monitor in.
I've not figured that out yet.
If you know how to do that, holler at me.
Until next time friends, multi-monitor on!

