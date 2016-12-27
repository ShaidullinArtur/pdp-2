import App from "app";
import { each } from "lodash";

class Initializer {
  initialize(el = document) {
    let _cache = {};
    $("*", el).each((i, node) => {
      each(node.attributes, (attr) => {
        if (attr.name.match(/^js-component-.+/) && attr.value !== "ready" && attr.value !== "locked") {
          if (!_cache[attr.name]) { _cache[attr.name] = []; }
          _cache[attr.name].push(node);
          return $(node).attr(attr.name, "locked");
        }
      })
    });

    return (() => {
      let result = [];
      for (let key in App.initializers) {
        let func = App.initializers[key];
        let item;
        let elements = _cache[key];
        if (elements) { item = func(elements, { cache: true }); }
        result.push(item);
      }
      return result;
    })();
  }

  addComponent(klass, options) {
    options.constructor = klass;
    if (!App.initializers) { App.initializers = {}; }
    App.initializers[`js-component-${options.name}`] = this.initializeComponent(options);
  }

  initializeComponent(options) {
    return function(el, opts = {}) {
      let attrName = `js-component-${options.name}`;
      if (opts.cache) {
        var targets = $(el);
      } else {
        var targets = $(`[${js-component}]:not([${js-component}='ready'])`, el);
      }
      return each(targets, function(target){
        let item = new options.constructor(target);
        return $(target).attr(attrName, "ready");
      });
    };
  }
}

App.initializer = new Initializer;

export default App.initializer;