(function (global, factory) {
    typeof exports === 'object' && typeof module !== 'undefined' ? module.exports = factory() :
        typeof define === 'function' && define.amd ? define(factory) :
            (global.MetisMenu = factory());
}(this, (function () { 'use strict';

    var __assign = function() {
        __assign = Object.assign || function __assign(t) {
            for (var s, i = 1, n = arguments.length; i < n; i++) {
                s = arguments[i];
                for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p)) t[p] = s[p];
            }
            return t;
        };
        return __assign.apply(this, arguments);
    };

    var Default = {
        parentTrigger: "li",
        subMenu: "ul",
        toggle: true,
        triggerElement: "a"
    };
    var ClassNames = {
        activeClass: "active",
        collapseClass: "collapse",
        collapseInClass: "in",
        collapsingClass: "collapsing"
    };

    var MetisMenu = /** @class */ (function () {

        function MetisMenu(element, options) {
            this.element =
                typeof element === "string" ? document.querySelector(element) : element;
            this.cacheEl = this.element;
            this.config = __assign({}, Default, options);
            this.cacheConfig = this.config;
            this.disposed = false;
            this.ulArr = [];
            this.listenerOb = [];
            this.init();
        }
        MetisMenu.prototype.update = function () {
            this.disposed = false;
            this.element = this.cacheEl;
            this.config = this.cacheConfig;
            this.init();
        };
        MetisMenu.prototype.dispose = function () {
            for (var _i = 0, _a = this.listenerOb; _i < _a.length; _i++) {
                var lo = _a[_i];
                for (var key in lo) {
                    if (lo.hasOwnProperty(key)) {
                        var el = lo[key];
                        el[1].removeEventListener(el[0], el[2]);
                    }
                }
            }
            this.ulArr = [];
            this.listenerOb = [];
            this.config = null;
            this.element = null;
            this.disposed = true;
        };
        MetisMenu.prototype.on = function (event, fn) {
            this.element.addEventListener(event, fn, false);
            return this;
        };
        MetisMenu.prototype.off = function (event, fn) {
            this.element.removeEventListener(event, fn);
            return this;
        };
        MetisMenu.prototype.emit = function (event, eventDetail, shouldBubble) {
            if (shouldBubble === void 0) { shouldBubble = false; }
            var evt;
            if (typeof CustomEvent === "function") {
                evt = new CustomEvent(event, {
                    bubbles: shouldBubble,
                    detail: eventDetail
                });
            }
            else {
                evt = document.createEvent("CustomEvent");
                evt.initCustomEvent(event, shouldBubble, false, eventDetail);
            }
            this.element.dispatchEvent(evt);
            return this;
        };
        MetisMenu.prototype.init = function () {
            this.ulArr = [].slice.call(this.element.querySelectorAll(this.config.subMenu));
            for (var _i = 0, _a = this.ulArr; _i < _a.length; _i++) {
                var ul = _a[_i];
                var li = ul.parentNode;
                ul.classList.add(ClassNames.collapseClass);
                if (li.classList.contains(ClassNames.activeClass)) {
                    this.show(ul);
                }
                else {
                    this.hide(ul);
                }
                var a = li.querySelector(this.config.triggerElement);
                if (a.getAttribute("aria-disabled") === "true") {
                    return;
                }
                a.setAttribute("aria-expanded", "false");
                var listenerOb = {
                    aClick: ["click", a, this.clickEvent.bind(this)]
                };
                for (var key in listenerOb) {
                    if (listenerOb.hasOwnProperty(key)) {
                        var listener = listenerOb[key];
                        listener[1].addEventListener(listener[0], listener[2]);
                    }
                }
                this.listenerOb.push(listenerOb);
            }
        };
        MetisMenu.prototype.clickEvent = function (ev) {
            if (!this.disposed) {
                if (ev.currentTarget.tagName === "A") {
                    ev.preventDefault();
                }
                var li = ev.currentTarget.parentNode;
                var ul = li.querySelector(this.config.subMenu);
                this.toggle(ul);
            }
        };
        MetisMenu.prototype.toggle = function (ul) {
            if (ul.parentNode.classList.contains(ClassNames.activeClass)) {
                this.hide(ul);
            }
            else {
                this.show(ul);
            }
        };
        MetisMenu.prototype.show = function (ul) {
            var _this = this;
            if (this.isTransitioning ||
                ul.classList.contains(ClassNames.collapseInClass)) {
                return;
            }
            var complete = function () {
                ul.classList.remove(ClassNames.collapsingClass);
                ul.style.height = "";
                ul.removeEventListener("transitionend", complete);
                _this.setTransitioning(false);
                _this.emit("shown.metisMenu", {
                    shownElement: ul
                });
            };
            var li = ul.parentNode;
            li.classList.add(ClassNames.activeClass);
            var a = li.querySelector(this.config.triggerElement);
            a.setAttribute("aria-expanded", "true");
            ul.style.height = "0px";
            ul.classList.remove(ClassNames.collapseClass);
            ul.classList.remove(ClassNames.collapseInClass);
            ul.classList.add(ClassNames.collapsingClass);
            var eleParentSiblins = [].slice
                .call(li.parentNode.children)
                .filter(function (c) { return c !== li; });
            if (this.config.toggle && eleParentSiblins.length > 0) {
                for (var _i = 0, eleParentSiblins_1 = eleParentSiblins; _i < eleParentSiblins_1.length; _i++) {
                    var sibli = eleParentSiblins_1[_i];
                    var sibUl = sibli.querySelector(this.config.subMenu);
                    if (sibUl !== null) {
                        this.hide(sibUl);
                    }
                }
            }
            this.setTransitioning(true);
            ul.classList.add(ClassNames.collapseClass);
            ul.classList.add(ClassNames.collapseInClass);
            ul.style.height = ul.scrollHeight + "px";
            this.emit("show.metisMenu", {
                showElement: ul
            });
            ul.addEventListener("transitionend", complete);
        };
        MetisMenu.prototype.hide = function (ul) {
            var _this = this;
            if (this.isTransitioning ||
                !ul.classList.contains(ClassNames.collapseInClass)) {
                return;
            }
            this.emit("hide.metisMenu", {
                hideElement: ul
            });
            var li = ul.parentNode;
            li.classList.remove(ClassNames.activeClass);
            var complete = function () {
                ul.classList.remove(ClassNames.collapsingClass);
                ul.classList.add(ClassNames.collapseClass);
                ul.removeEventListener("transitionend", complete);
                _this.setTransitioning(false);
                _this.emit("hidden.metisMenu", {
                    hiddenElement: ul
                });
            };
            ul.style.height = ul.getBoundingClientRect().height + "px";
            ul.style.height = ul.offsetHeight + "px";
            ul.classList.add(ClassNames.collapsingClass);
            ul.classList.remove(ClassNames.collapseClass);
            ul.classList.remove(ClassNames.collapseInClass);
            this.setTransitioning(true);
            ul.addEventListener("transitionend", complete);
            ul.style.height = "0px";
            var a = li.querySelector(this.config.triggerElement);
            a.setAttribute("aria-expanded", "false");
        };
        MetisMenu.prototype.setTransitioning = function (isTransitioning) {
            this.isTransitioning = isTransitioning;
        };
        return MetisMenu;
    }());

    return MetisMenu;

})));

