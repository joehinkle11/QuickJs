//-----------------------------------------------------------------------------
// Solar Quick Js Plugin
// (c)2020 Joe Hinkle
//-----------------------------------------------------------------------------
window.plugin_quickjs_js = {
  returnedValue: null,
  callback: null,

  runJs: function(reqId, data, jsText) {
    const callback = function() { plugin_quickjs_js.callback(reqId, arguments) }
    plugin_quickjs_js.returnedValue = eval("(function(){"+jsText+"})()")
  },

  addEventListener: function(listener) {
    plugin_quickjs_js.callback = LuaCreateFunction(listener);
  }
};