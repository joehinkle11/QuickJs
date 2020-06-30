# Solar2D QuickJS

## Overview

I've made a quick way to call JavaScript inside Solar2D (formerly Corona SDK). It is open-source, so feel free to make a pull request at https://github.com/joehinkle11/quickjs/

Note: I'm waiting for this to go on the Solar2D plugin directory. If you want to use this before then, just copy the files the root of your project do `local QuickJs = require "plugin_quickjs"`

## Add following to your `build.settings` to use:

```lua
{
    plugins = {
        ["plugin.quickjs"] = {
            publisherId = "io.joehinkle",
        },
    },
}
```

## Example Use

**Import**

```lua
local QuickJs = require "plugin.solarquickjs"
```

**Returning a value**

```lua
local returnedMessage = QuickJs.run {
    js = [[
        var message = "hello from js!"
        return message
    ]],
    lua = function()
        return "hello from lua!"
    end
}
print(returnedMessage) -- "hello from js!" on HTML5 builds and "hello from lua!" on all other builds
```

**Using a callback**

```lua
QuickJs.run {
    js = [[
        // wait one second
        setTimeout(function(){
            callback("hello from js!")
        }, 1000)
    ]],
    lua = function(callback)
        -- wait one second
        timer.performWithDelay(1000, function()
            callback("hello from lua!")
        end)
    end,
    callback = function(callbackMessage)
        print(callbackMessage) -- "hello from js!" on HTML5 builds and "hello from lua!" on all other builds
    end
}
```

**Using a callback and returning a value**

```lua
local returnedMessage = QuickJs.run {
    js = [[
        // wait one second
        setTimeout(function(){
            callback("hello from js!")
        }, 1000)
    ]],
    lua = function(callback)
        -- wait one second
        timer.performWithDelay(1000, function()
            callback("hello from lua!")
        end)
    end,
    callback = function(callbackMessage)
        print(callbackMessage) -- "hello from js!" on HTML5 builds and "hello from lua!" on all other builds
    end
}
print(returnedMessage) -- "hello from js!" on HTML5 builds and "hello from lua!" on all other builds
```

**Passing data**

```lua
QuickJs.run {
    data = {
        hello = "hello"
    },
    js = [[
        console.log(data.hello) // "hello"
    ]],
    lua = function(data)
        print(data.hello) -- "hello"
    end
}
```

**All together now!** 🎉

```lua
local returnedMessage = QuickJs.run {
    data = {
        hello = "hello"
    },
    js = [[
        var message = data.hello + " from js!"
        // wait one second
        setTimeout(function(){
            callback(message)
        }, 1000)
        return message
    ]],
    lua = function(data, callback)
        local message = data.hello.." from lua!"
        -- wait one second
        timer.performWithDelay(1000, function()
            callback(message)
        end)
        return message
    end,
    callback = function(callbackMessage)
        print(callbackMessage) -- "hello from js!" on HTML5 builds and "hello from lua!" on all other builds
    end
}
print(returnedMessage) -- "hello from js!" on HTML5 builds and "hello from lua!" on all other builds
```


## Extra examples of other settings

**Force JavaScript** (non-HTML5 builds still will use Lua, but print a warning)

```lua
QuickJs.run {
    runJs = true,
    js = [[
        // js code here
    ]],
    lua = function()
        -- lua code here
    end
}
```

**Force Lua**

```lua
QuickJs.run {
    runJs = false,
    js = [[
        // js code here
    ]],
    lua = function()
        -- lua code here
    end
}
```

## Repeating Callbacks

When the callback in a JavaScript function is called, I automatically clean the reference to the callback in Lua. This means **you can only call the JavaScript callback once**. If you wish to disable this, set `neverCleanJsCallback` to `true` and you can make the callback as many times as you want.

```lua
QuickJs.run {
    neverCleanJsCallback = true,
    js = [[
        callback(1)
        callback(2)
        callback(3)
    ]],
    lua = function(callback)
        callback(1)
        callback(2)
        callback(3)
    end,
    callback = function(num)
        print(num) -- 1, 2, 3
    end
}
```


## Support

| Platform | Details |
| ------------------- | -------- |
| Web/HTML5 | defaults to JavaScript, but you can force Lua |
| iOS | always runs Lua |
| iOS Simulator | always runs Lua |
| Android | always runs Lua |
| TVOS | always runs Lua |
| TVOS Simulator | always runs Lua |
| Corona Simulator (Mac) | always runs Lua |
| Corona Simulator (Windows) | always runs Lua |

# Shameless plugs

* <img src="https://cdnjs.cloudflare.com/ajax/libs/webicons/2.0.0/webicons/webicon-youtube-s.png" width="15"> [My YouTube channel](https://www.youtube.com/channel/UCje9o1NPdBs0vhPp7AEgWvg)
* <img src="https://cdnjs.cloudflare.com/ajax/libs/webicons/2.0.0/webicons/webicon-youtube-s.png" width="15"> [My second YouTube channel](https://www.youtube.com/channel/UC5aSLB42ZZIDtQXrZgnS1iA)
* <img src="https://www.joehinkle.io/favicon192x192.png" width="15"> [My Website](https://www.joehinkle.io/)
* <img src="https://cdnjs.cloudflare.com/ajax/libs/webicons/2.0.0/webicons/webicon-twitter-s.png" width="15"> [My Twitter](https://twitter.com/joehink95)
* <img src="https://cdnjs.cloudflare.com/ajax/libs/webicons/2.0.0/webicons/webicon-linkedin-s.png" width="15"> [My LinkedIn](https://www.linkedin.com/in/joehinkle11/)
* <img src="https://cdnjs.cloudflare.com/ajax/libs/webicons/2.0.0/webicons/webicon-android-s.png" width="15"> [My Android Apps](https://play.google.com/store/apps/dev?id=6380399300644608862)
* <img src="https://cdnjs.cloudflare.com/ajax/libs/webicons/2.0.0/webicons/webicon-apple-s.png" width="15"> [My iOS Apps](https://apps.apple.com/us/developer/joseph-hinkle/id916334630)
* 🤓 [Hire Me](https://www.joehinkle.io/services)
