local Library = require "CoronaLibrary"

-- Create library
local lib = Library:new{ name='quickjs', publisherId='io.joehinkle' }

local jsLib
local reqIdCounter = 0
local callbackDict = {}

lib.run = function(params)
	params = params or {}
	local data = params.data or nil
	local jsText = params.js or ""
	local luaFunc = params.lua or function()end
	local callback = params.callback or nil
	local neverCleanJsCallback = params.neverCleanJsCallback or false
	local runJs = params.runJs
	if runJs == nil then
		runJs = true
	end
	if runJs then
		if jsLib == nil then
			jsLib = require("plugin_quickjs_js")
			jsLib.addEventListener(function(reqId, neverCleanJsCallback, arguments)
				local argumentsLua = {}
				for k,v in pairs(arguments) do
					argumentsLua[k+1] = v
				end
				if callbackDict[reqId] then
					callbackDict[reqId](unpack(argumentsLua))
					if not neverCleanJsCallback then
						callbackDict[reqId] = nil
					end
				end
			end)
		end
		local reqId = reqIdCounter
		callbackDict[reqId] = callback
		jsLib.runJs(reqId, neverCleanJsCallback, data, jsText)
		local returnedValue = jsLib.returnedValue
		jsLib.returnedValue = nil
		reqIdCounter = reqIdCounter + 1
		return returnedValue
	else
		if data == nil then
			return luaFunc(callback)
		else
			return luaFunc(data, callback)
		end
	end
end

return lib
