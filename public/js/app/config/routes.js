/*
  Compiled by Polvo, using CoffeeScript
*/

define('app/config/routes', ['require', 'exports', 'module'], function(require, exports, module) {
  var Routes;
  return module.exports = Routes = (function() {
    function Routes() {}

    Routes.routes = {
      '/pages': {
        to: "pages/index",
        at: null,
        el: "body"
      },
      '/404': {
        to: "pages/notfound",
        at: "/pages",
        el: "#container"
      }
    };

    Routes.root = '/pages';

    Routes.notfound = '/404';

    return Routes;

  })();
});
/*
//@ sourceMappingURL=routes.map
*/