/*
  Compiled by Polvo, using CoffeeScript
*/

define('theoricus/mvc/lib/binder', ['require', 'exports', 'module'], function(require, exports, module) {
  var Binder;
  return module.exports = Binder = (function() {
    var bind_name_reg, bind_reg, collect, context_reg, parse;

    function Binder() {}

    context_reg = '(<!-- @[\\w]+ -->)([^<]+)(<!-- \/@[\\w]+ -->)';

    bind_reg = "(<!-- @~KEY -->)([^<]+)(<!-- \/@~KEY -->)";

    bind_name_reg = /(<!-- @)([\w]+)( -->)/;

    Binder.prototype.binds = null;

    Binder.prototype.bind = function(dom, just_clean_attrs) {
      return parse((this.binds = {}), dom, just_clean_attrs);
    };

    Binder.prototype.update = function(field, val) {
      var current, item, node, search, updated, _i, _len, _ref, _results;
      if (this.binds == null) {
        return;
      }
      if (this.binds[field] == null) {
        return;
      }
      _ref = this.binds[field] || [];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        node = $(item.target);
        switch (item.type) {
          case 'node':
            current = node.html();
            search = new RegExp(bind_reg.replace(/\~KEY/g, field), 'g');
            updated = current.replace(search, "$1" + val + "$3");
            node.html(updated);
            break;
          case 'attr':
            _results.push(node.attr(item.attr, val));
            break;
          default:
            _results.push(void 0);
        }
      }
      return _results;
    };

    parse = function(binds, dom, just_clean_attrs) {
      return dom.children().each(function() {
        var attr, key, keys, match_all, match_single, name, text, value, _i, _j, _len, _len1, _ref;
        _ref = this.attributes;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          attr = _ref[_i];
          name = attr.nodeName;
          value = attr.nodeValue;
          match_single = new RegExp(context_reg);
          if (match_single.test(value)) {
            key = (value.match(bind_name_reg))[2];
            ($(this)).attr(name, (value.match(match_single))[2]);
            if (just_clean_attrs === false) {
              collect(binds, this, 'attr', key, name);
            }
          }
        }
        if (just_clean_attrs === false) {
          match_all = new RegExp(context_reg, 'g');
          text = ($(this)).clone().children().remove().end().html();
          text = "" + text;
          keys = (text.match(match_all)) || [];
          for (_j = 0, _len1 = keys.length; _j < _len1; _j++) {
            key = keys[_j];
            key = (key.match(bind_name_reg))[2];
            collect(binds, this, 'node', key);
          }
        }
        return parse(binds, $(this), just_clean_attrs);
      });
    };

    collect = function(binds, target, type, variable, attr) {
      var bind, tmp;
      bind = (binds[variable] != null ? binds[variable] : binds[variable] = []);
      tmp = {
        type: type,
        target: target
      };
      if (attr != null) {
        tmp.attr = attr;
      }
      return bind.push(tmp);
    };

    return Binder;

  })();
});
/*
//@ sourceMappingURL=binder.map
*/