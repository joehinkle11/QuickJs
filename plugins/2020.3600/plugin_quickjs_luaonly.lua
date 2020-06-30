local Library = require "CoronaLibrary"

-- Create library
local lib = Library:new{ name='quickjs', publisherId='io.joehinkle' }

lib.run = function(params)
	params = params or {}
	local data = params.data or nil
	local luaFunc = params.lua or function()end
	local callback = params.callback or nil
	local runJs = params.runJs
	if runJs then
		print("WARNING: cannot run javascript on this platform, defaulting to provided lua function")
	end
	if data == nil then
		return luaFunc(callback)
	else
		return luaFunc(data, callback)
	end
end

return lib
