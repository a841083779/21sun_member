(function(c, f) {
	if (c.PCgroup) {
		return
	}
	var b,
	d = Object.prototype.toString,
	e = Array.prototype.slice,
	a = c.document;
	b = function() {
		return b.dom.quick.apply(this, arguments)
	};
	b.add = function(g, h) {
		if (typeof g != "string") {
			var i = g;
			for (var g in i) {
				b.add(g, i[g])
			}
			return
		}
		if (b[g] == f) {
			b[g] = h
		} else {
			throw new Error("PCgroup Lib：模块名" + g + "已被占用")
		}
	};
	b.version = "1.0";
	b.add({
		isFunction: function(g) {
			return d.call(g) === "[object Function]"
		},
		isArray: function(g) {
			return d.call(g) === "[object Array]"
		},
		isPlainObject: function(g) {
			return g && d.call(g) === "[object Object]" && !g.nodeType && !g.setInterval
		},
		isBoolean: function(g) {
			return d.call(g) === "[object Boolean]"
		},
		isUndefined: function(g) {
			return g === f
		},
		isString: function(g) {
			return d.call(g) === "[object String]"
		},
		isNumber: function(g) {
			return d.call(g) === "[object Number]"
		},
		trim: function(g) {
			if (String.prototype.trim) {
				return g.trim()
			}
			return g.replace(/^\s+/g, "").replace(/\s+$/g, "")
		},
		each: function(h, l) {
			if (f === h.length) {
				for (var k in h) {
					if (false === l.call(h, h[k], k)) {
						break
					}
				}
			} else {
				for (var j = 0, g = h.length; j < g; j++) {
					if (j in h) {
						if (false === l.call(h, h[j], j)) {
							break
						}
					}
				}
			}
		},
		extend: function(g, k, i, h) {
			if (i === f) {
				i = true
			}
			for (var j in k) {
				if (i || !(j in g)) {
					if (h) {
						h(j)
					} else {
						g[j] = k[j]
					}
				}
			}
			return g
		},
		merge: function() {
			var j = {},
			h,
			g = arguments.length;
			for (h = 0; h < g; ++h) {
				b.extend(j, arguments[h])
			}
			return j
		},
		bindFn: function(g) {
			return function() {
				var i = e.call(arguments, 0),
				h;
				i.unshift(this);
				h = g.apply(this, i);
				if (h === f) {
					return this
				} else {
					if (h && h.nodeType && h.nodeType == 1) {
						return b.element(h)
					} else {
						return h
					}
				}
			}
		}
	});
	b.add("dom",
	function(h) {
		var g = false,
		l = [],
		i = function() {
			if (!g) {
				g = true;
				if (l) {
					b.each(l,
					function(m) {
						m.call(a, b)
					});
					l = null
				}
			}
		},
		k = false;
		bindReady = function() {
			if (k) {
				return
			}
			k = true;
			if (a.addEventListener) {
				a.addEventListener("DOMContentLoaded",
				function() {
					a.removeEventListener("DOMContentLoaded", arguments.callee, false);
					i()
				},
				false)
			} else {
				if (a.attachEvent) {
					a.attachEvent("onreadystatechange",
					function() {
						if (a.readyState === "complete") {
							a.detachEvent("onreadystatechange", arguments.callee);
							i()
						}
					});
					if (a.documentElement.doScroll && c == c.top) { (function() {
							if (g) {
								return
							}
							try {
								a.documentElement.doScroll("left")
							} catch(m) {
								setTimeout(arguments.callee, 0);
								return
							}
							i()
						})()
					}
				}
			}
			b.addEvent(c, "load", i)
		};
		var j = {
			getElems: function(m, n) {
				return b.selector(m, n)
			},
			getElem: function(m, o) {
				var n = b.dom.getElems(m, o);
				return n.length ? n[0] : null
			},
			quick: function(p, o) {
				var n,
				m;
				if (!p) {
					return null
				}
				if (b.isString(p)) {
					var n = b.dom.getElems(p, o);
					return b.dom.quick(n)
				}
				if (b.isFunction(p)) {
					return b.dom.ready(p)
				}
				if (b.isArray(p)) {
					b.each(p,
					function(q) {
						b.dom.quick(q)
					});
					if (p.length > 1) {
						p.each = b.bindFn(b.each)
					} else {
						p = p[0];
						p[0] = p;
						p.each = function(q) {
							q(p)
						}
					}
					return p
				}
				if (p.nodeType) {
					return b.dom.element(p)
				}
				return null
			},
			ready: function(m) {
				bindReady();
				if (g) {
					m.call(a, b)
				} else {
					l.push(function() {
						return m.call(a, b)
					})
				}
				return this
			},
			element: function(m) {
				b.extend(m, b.dom.methods);
				return m
			},
			extend: function(p, o) {
				if (!b.isString(p)) {
					var q = {};
					if (o) {
						b.each(o,
						function(s) {
							var t = p[s];
							if (t) {
								q[s] = t
							}
						})
					} else {
						q = p
					}
					b.each(q,
					function(t, s) {
						b.dom.extend(s, t)
					})
				} else {
					var m = b.dom.methods,
					n = p,
					r = o;
					if (b.isFunction(r)) {
						m[n] = b.bindFn(r)
					} else {
						m[n] = r
					}
				}
			},
			methods: {}
		};
		return j
	} (b));
	b.getElem = b.dom.getElem;
	b.getElems = b.dom.getElems;
	b.ready = b.dom.ready;
	b.element = b.dom.element;
	b.add("loader", {
		getScript: function(h, k, j) {
			var i = a.getElementsByTagName("head")[0] || a.documentElement,
			g = a.createElement("script");
			g.src = h;
			j && (g.charset = j);
			g.onload = g.onreadystatechange = function() {
				if ((!this.readyState || this.readyState === "loaded" || this.readyState === "complete")) {
					k && k();
					g.onload = g.onreadystatechange = null;
					if (i && g.parentNode) {
						i.removeChild(g)
					}
				}
			};
			i.appendChild(g);
			return g
		},
		need: function() {
			var g = b.loader,
			h = e.call(arguments, 0),
			i = h.pop();
			if (!b.isFunction(i)) {
				return
			}
			var j = function() {
				i.call(b, b)
			};
			j.depth = h.length;
			b.each(h,
			function(o) {
				var l,
				n = g.__mods[o];
				if (n) {
					l = o;
					o = n
				}
				if (o) {
					var m = function() { ! --j.depth && j()
					},
					k = g.__log[o] || (g.__log[o] = {});
					if (l && b[l]) {
						k.status = "loaded"
					}
					if (k.status == "sent") {
						k.callbaks.push(m)
					} else {
						if (k.status == "loaded") {
							m()
						} else {
							k.status = "sent";
							k.callbaks = [m];
							g.getScript(o,
							function() {
								b.each(k.callbaks,
								function(p) {
									p.call(c, b)
								});
								k.status = "loaded"
							})
						}
					}
				}
			})
		}
	});
	b.need = b.loader.need;
	b.getScript = b.loader.getScript;
	c.pc = c.PCgroup = b
})(window);
PCgroup.add("selector", (function(f) {
	var g = /^(?:[\w\-_]+)?\.([\w\-_]+)/,
	e = /^(?:[\w\-_]+)?#([\w\-_]+)/,
	k = /^([\w\*\-_]+)/,
	h = /^(?:[\w\-_]+)?\[([\w]+)(=(\w+))?\]/,
	i = [null, null, null, null];
	function c(p, n) {
		n = n || document;
		var l = /^[\w\-_#]+$/.test(p);
		if (!l && n.querySelectorAll) {
			return b(n.querySelectorAll(p))
		}
		if (p.indexOf(",") > -1) {
			var z = p.split(/,/g),
			w = [],
			v = 0,
			u = z.length;
			for (; v < u; ++v) {
				w = w.concat(c(z[v], n))
			}
			return d(w)
		}
		p = p.replace(" > ", ">").replace(">", " > ");
		var r = p.split(/ /g),
		o = r.pop(),
		m = (o.match(e) || i)[1],
		x = !m && (o.match(g) || i)[1],
		A = !m && (o.match(k) || i)[1],
		q = o.match(h) || i,
		y = q[1] || null,
		t = q[3] || null,
		s;
		if (x && !A && n.getElementsByClassName) {
			s = b(n.getElementsByClassName(x))
		} else {
			s = !m && b(n.getElementsByTagName(A || "*"));
			if (x) {
				s = j(s, "className", x)
			}
			if (y) {
				s = j(s, y, t)
			}
			if (m) {
				var B = n.getElementById(m);
				return B ? [B] : []
			}
		}
		return r[0] && s[0] ? a(r, s) : s
	}
	function b(p) {
		try {
			return slice.call(p)
		} catch(o) {
			var m = [],
			n = 0,
			l = p.length;
			for (; n < l; ++n) {
				m[n] = p[n]
			}
			return m
		}
	}
	function a(x, q, o) {
		var s = x.pop();
		if (s === ">") {
			return a(x, q, true)
		}
		var t = [],
		l = -1,
		m = (s.match(e) || i)[1],
		u = !m && (s.match(g) || i)[1],
		w = !m && (s.match(k) || i)[1],
		v = -1,
		n,
		y,
		p;
		w = w && w.toLowerCase();
		while ((n = q[++v])) {
			y = n.parentNode;
			do {
				p = !w || w === "*" || w === y.nodeName.toLowerCase();
				p = p && (!m || y.id === m);
				p = p && (!u || RegExp("(^|\\s)" + u + "(\\s|$)").test(y.className));
				if (o || p) {
					break
				}
			}
			while ((y = y.parentNode));
			if (p) {
				t[++l] = n
			}
		}
		return x[0] && t[0] ? a(x, t) : t
	}
	var d = (function() {
		var l = new Date().getTime();
		var m = (function() {
			var o = 1;
			return function(q) {
				var p = q[l],
				n = o++;
				if (!p) {
					q[l] = n;
					return true
				}
				return false
			}
		})();
		return function(n) {
			var t = n.length,
			o = [],
			s = -1,
			p = 0,
			q;
			for (; p < t; ++p) {
				q = n[p];
				if (m(q)) {
					o[++s] = q
				}
			}
			l += 1;
			return o
		}
	})();
	function j(p, s, u) {
		var m = RegExp("(^|\\s)" + u + "(\\s|$)");
		var t = function(w) {
			var r = s == "className" ? w.className: w.getAttribute(s);
			if (r) {
				if (u) {
					if (m.test(r)) {
						return true
					}
				} else {
					return true
				}
			}
			return false
		};
		var o = -1,
		n,
		l = -1,
		q = [];
		while ((n = p[++o])) {
			if (t(n)) {
				q[++l] = n
			}
		}
		return q
	}
	return c
})(PCgroup));
PCgroup.add("browser", (function(e) {
	var c = {
		msie: /msie/.test(e) && !/opera/.test(e),
		opera: /opera/.test(e),
		safari: /webkit/.test(e) && !/chrome/.test(e),
		firefox: /firefox/.test(e),
		chrome: /chrome/.test(e),
		ipad: (/ipad/).test(e),
		iphone: (/iphone/).test(e)
	};
	var a = "";
	for (var d in c) {
		if (c[d]) {
			a = "safari" == d ? "version": d;
			break
		}
	}
	c.version = a && RegExp("(?:" + a + ")[\\/: ]([\\d.]+)").test(e) ? RegExp.$1: "0";
	c.ie = c.msie;
	c.ie6 = c.msie && parseInt(c.version, 10) == 6;
	c.ie7 = c.msie && parseInt(c.version, 10) == 7;
	c.ie8 = c.msie && parseInt(c.version, 10) == 8;
	c.ie9 = c.msie && parseInt(c.version, 10) == 9;
	c.support = function() {
		var f = document.createElement("div");
		f.style.display = "none";
		f.innerHTML = "<a href='#' style='color:red;float:left;opacity:.55;'>a</a>";
		var b = f.getElementsByTagName("a")[0];
		return {
			opacity: /^0.55$/.test(b.style.opacity),
			cssFloat: !!b.style.cssFloat
		}
	} ();
	return c
})(window.navigator.userAgent.toLowerCase())); (function(h, d) {
	var f = /alpha\([^)]*\)/,
	e = /float/i,
	n = /opacity=([^)]*)/,
	i = h.browser.support.cssFloat ? "cssFloat": "styleFloat",
	m = /([A-Z])/g,
	b = /-([a-z])/ig,
	c = function(o, p) {
		return p.toUpperCase()
	},
	a = document.defaultView && document.defaultView.getComputedStyle,
	g = /^-?\d+(?:px)?$/i,
	l = /^-?\d/;
	h.add({
		cssHooks: {},
		getStyle: function(u, r, v, p) {
			var q,
			t = u.style,
			s,
			o = PCgroup.cssHooks[r];
			if (!h.browser.support.opacity && r === "opacity" && u.currentStyle) {
				q = n.test(u.currentStyle.filter || "") ? (parseFloat(RegExp.$1) / 100) + "": "";
				return q === "" ? "1": q
			}
			if (e.test(r)) {
				r = i
			}
			if (o && "get" in o && (q = o.get(u, p)) !== d) {
				return q
			} else {
				if (!v && t && t[r]) {
					q = t[r]
				} else {
					q = k(u, r, v)
				}
			}
			return q
		},
		setStyle: function() {
			var t = arguments,
			r = t[0];
			if (typeof t[1] != "string") {
				for (var w in t[1]) {
					h.setStyle.apply(h, [r, w, t[1][w]])
				}
				return
			}
			var p = t[1],
			v = t[2];
			var o = r.style || r,
			u = v !== d;
			if (!h.browser.support.opacity && p === "opacity") {
				if (u) {
					o.zoom = 1;
					var s = parseInt(v, 10) + "" === "NaN" ? "": "alpha(opacity=" + v * 100 + ")";
					var q = o.filter || "";
					o.filter = f.test(q) ? q.replace(f, s) : s
				}
				return o.filter && o.filter.indexOf("opacity=") >= 0 ? (parseFloat(n.exec(o.filter)[1]) / 100) + "": ""
			}
			if (e.test(p)) {
				p = i
			}
			p = p.replace(b, c);
			if (u) {
				o[p] = v
			}
		}
	});
	function j(s, q, p) {
		var u = q === "width" ? s.offsetWidth: s.offsetHeight,
		t = q === "width" ? ["Left", "Right"] : ["Top", "Bottom"],
		r = 0,
		o = t.length;
		if (u > 0) {
			if (p !== "border") {
				for (; r < o; r++) {
					if (!p) {
						u -= parseFloat(PCgroup.getStyle(s, "padding" + t[r])) || 0
					}
					if (p === "margin") {
						u += parseFloat(PCgroup.getStyle(s, p + t[r])) || 0
					} else {
						u -= parseFloat(PCgroup.getStyle(s, "border" + t[r] + "Width")) || 0
					}
				}
			}
			return u + "px"
		}
		u = k(s, q, q);
		if (u < 0 || u == null) {
			u = s.style[q] || 0
		}
		u = parseFloat(u) || 0;
		if (p) {
			for (; r < o; r++) {
				u += parseFloat(PCgroup.getStyle(s, "padding" + t[r])) || 0;
				if (p !== "padding") {
					u += parseFloat(PCgroup.getStyle(s, "border" + t[r] + "Width")) || 0
				}
				if (p === "margin") {
					u += parseFloat(PCgroup.getStyle(s, p + t[r])) || 0
				}
			}
		}
		return u + "px"
	}
	function k(s, p, q) {
		var o = s.style,
		w;
		if (a) {
			if (e.test(p)) {
				p = "float"
			}
			p = p.replace(m, "-$1").toLowerCase();
			var v = s.ownerDocument.defaultView;
			if (!v) {
				return null
			}
			var x = v.getComputedStyle(s, null);
			if (x) {
				w = x.getPropertyValue(p)
			}
			if (p === "opacity" && w === "") {
				w = "1"
			}
		} else {
			if (s.currentStyle) {
				var t = p.replace(b, c);
				w = s.currentStyle[p] || s.currentStyle[t];
				if (!g.test(w) && l.test(w)) {
					var r = o.left,
					u = s.runtimeStyle.left;
					s.runtimeStyle.left = s.currentStyle.left;
					o.left = t === "fontSize" ? "1em": (w || 0);
					w = o.pixelLeft + "px";
					o.left = r;
					s.runtimeStyle.left = u
				}
			}
		}
		return w
	}
	PCgroup.each(["height", "width"],
	function(o) {
		PCgroup.cssHooks[o] = {
			get: function(q, p) {
				return j(q, o, p)
			}
		}
	});
	PCgroup.dom.extend(PCgroup, ["getStyle", "setStyle"])
})(PCgroup); (function(f, d) {
	var j = /\s+/,
	e = /[\n\t\r]/g;
	var b = function(n, k, m) {
		k = k || 1;
		var l = 0;
		for (; n; n = n[m]) {
			if (n.nodeType == 1 && ++l == k) {
				break
			}
		}
		return n
	},
	g = function(m, l) {
		var k = [];
		for (; m; m = m.nextSibling) {
			if (m.nodeType == 1 && m != l) {
				k.push(m)
			}
		}
		return k
	};
	var c = {},
	i = "PCgroup",
	a = 0;
	var h = document.documentElement.textContent !== d ? "textContent": "innerText";
	f.add({
		create: function(n, l, o) {
			var o = o || document;
			var k = o.createElement(n);
			if (l) {
				for (var m in l) {
					var p = l[m];
					if (m == "className") {
						f.addClass(k, p);
						continue
					}
					k.setAttribute(m, p)
				}
			}
			return k
		},
		prependChild: function(l, k) {
			if (l.nodeType == 1) {
				l.insertBefore(k, l.firstChild)
			}
		},
		insertAfter: function(n, k) {
			var l = n.parentNode,
			m = l.lastChild;
			if (m == n) {
				l.appendChild(k)
			} else {
				l.insertBefore(k, n.nextSibling)
			}
		},
		hasClass: function(m, k) {
			var l = " ",
			n = l + m.className + l;
			return n.indexOf(l + k + l) != -1 ? true: false
		},
		addClass: function(l, k) {
			if (!pc.hasClass(l, k)) {
				l.className = pc.trim(l.className + " " + k)
			}
		},
		removeClass: function(n, l) {
			var m = (" " + n.className + " ").replace(e, " "),
			o = l.split(j);
			for (var p = 0, k = o.length; p < k; p++) {
				m = m.replace(" " + o[p] + " ", " ")
			}
			n.className = pc.trim(m)
		},
		nextElem: function(k) {
			return b(k, 2, "nextSibling")
		},
		prevElem: function(m, k, l) {
			return b(m, 2, "previousSibling")
		},
		parentElems: function(k) {
			return pc.walk(k, "parentNode")
		},
		nextElems: function(k) {
			return pc.walk(k, "nextSibling")
		},
		prevElems: function(k) {
			return pc.walk(k, "previousSibling")
		},
		siblings: function(l) {
			var k = g(l.parentNode.firstChild, l);
			return k
		},
		walk: function(n, l, m) {
			var k = [],
			p = n[l];
			while (p && p.nodeType !== 9) {
				if (p.nodeType === 1) {
					if (m) {
						var o = m(p);
						if (o === false) {
							p = p[l];
							continue
						}
					}
					k.push(p)
				}
				p = p[l]
			}
			return k
		},
		childElems: function(l, k) {
			var l = g(l.firstChild);
			return l
		},
		getText: function(k) {
			var l = k[h];
			return l
		},
		setText: function(k, l) {
			if (l !== d) {
				k[h] = l
			}
		},
		setData: function(l, k, m) {
			var n = l[i];
			if (n === d) {
				n = a++;
				l[i] = n
			}
			if (c[n] === d) {
				c[n] = {}
			}
			return c[n][k] = m
		},
		getData: function(l, k) {
			var n = l[i],
			m = c[n] && c[n][k];
			if (m === d) {
				m = null
			}
			return m
		},
		removeData: function(l, k) {
			var m = l[i];
			if (m !== d && c[m]) {
				delete c[m][k]
			}
		}
	});
	PCgroup.dom.extend(PCgroup, ["prependChild", "insertAfter", "hasClass", "addClass", "removeClass", "nextElem", "prevElem", "parentElems", "nextElems", "prevElems", "siblings", "childElems", "setData", "getData", "removeData", "walk", "getText", "setText"])
})(PCgroup); (function(e, f) {
	var c = 0,
	d = "PCgroupEventID",
	b = "PCgroupEvents",
	a = [];
	e.add({
		addEvent: function(l, k, j) {
			var h;
			if (!e.getData(l, b)) {
				e.setData(l, b, {})
			}
			h = e.getData(l, b);
			if (!h[k]) {
				h[k] = {}
			}
			var g = function(p) {
				var p = p || window.event,
				n = this;
				if (p !== f) {
					var o = PCgroup.extend({},
					p);
					p = pc.eventTarget(p)
				}
				j.apply(l, [p, o])
			};
			var m = function(s) {
				var p = function(u, t) {
					try {
						return u.contains ? u != t && u.contains(t) : !!(u.compareDocumentPosition(t) & 16)
					} catch(v) {}
				};
				var s = s || window.event,
				o = this;
				if (s !== f) {
					var q = PCgroup.extend({},
					s);
					s = pc.eventTarget(s);
					var r = s.target,
					n = s.relatedTarget;
					if (!p(o, n) && o != n) {
						j.apply(l, [s, q])
					}
				}
			};
			g.fn = j;
			j[b] = g;
			var i = c++;
			g[d] = i;
			h[k][i] = g;
			if (l.attachEvent) {
				l.attachEvent("on" + k, g)
			} else {
				if (k == "mouseenter") {
					l.addEventListener("mouseover", m, false)
				} else {
					if (k == "mouseleave") {
						l.addEventListener("mouseout", m, false)
					} else {
						l.addEventListener(k, g, false)
					}
				}
			}
		},
		removeEvent: function(l, k, j) {
			var g = e.getData(l, b);
			if (!k && !j) {
				var i = e.getEvent(l);
				if (i) {
					pc.each(i,
					function(m, n) {
						e.removeEvent(l, n)
					})
				}
			}
			if (!j) {
				var i = e.getEvent(l, k);
				if (i) {
					pc.each(i,
					function(m) {
						e.removeEvent(l, k, m.fn)
					})
				}
				return
			}
			var h = j[b][d];
			j = g[k][h];
			if (l.detachEvent) {
				l.detachEvent("on" + k, j)
			} else {
				l.removeEventListener(k, j, false)
			}
			delete g[k][h]
		},
		getEvent: function(k, j, l) {
			var i = {},
			g,
			h = false;
			if (!e.getData(k, b)) {
				e.setData(k, b, {})
			}
			g = e.getData(k, b);
			if (g) {
				e.each(g,
				function(n, m) {
					if (j && j != m) {
						return true
					}
					i[m] = i[m] || [];
					e.each(n,
					function(o) {
						h = true;
						i[m].push(o)
					})
				})
			}
			return h ? (j ? i[j] : i) : null
		},
		cloneEvent: function(j, i, h) {
			var g = e.getEvent(j, h);
			if (g) {
				if (h) {
					pc.each(g,
					function(k) {
						pc.addEvent(i, h, k.fn)
					})
				} else {
					pc.each(g,
					function(k, l) {
						pc.each(k,
						function(m) {
							pc.addEvent(i, l, m.fn)
						})
					})
				}
			}
		},
		eventTarget: function(i) {
			if (!i.target) {
				i.target = i.srcElement || document
			}
			if (i.target.nodeType === 3) {
				i.target = i.target.parentNode
			}
			if (!i.relatedTarget && i.fromElement) {
				i.relatedTarget = (i.fromElement === i.target) ? i.toElement: i.fromElement
			}
			if (i.which === f) {
				i.which = (i.charCode !== f) ? i.charCode: i.keyCode
			}
			if (i.pageX == null && i.clientX != null) {
				var h = document.documentElement,
				g = document.body;
				i.pageX = i.clientX + (h && h.scrollLeft || g && g.scrollLeft || 0) - (h && h.clientLeft || g && g.clientLeft || 0);
				i.pageY = i.clientY + (h && h.scrollTop || g && g.scrollTop || 0) - (h && h.clientTop || g && g.clientTop || 0)
			}
			if (!i.preventDefault) {
				i.preventDefault = function() {
					i.returnValue = false
				}
			}
			if (!i.stopPropagation) {
				i.stopPropagation = function(j) {
					i.cancelBubble = true
				}
			}
			return i
		}
	});
	PCgroup.dom.extend(PCgroup, ["addEvent", "removeEvent", "getEvent", "cloneEvent"])
})(PCgroup); (function(a, b) {
	a.add({
		timers: {},
		stopTimer: function() {
			a.each(this.timers,
			function(c) {
				c.stop()
			})
		},
		startTimer: function() {
			a.each(this.timers,
			function(c) {
				c.start()
			})
		},
		pauseTimer: function() {
			a.each(this.timers,
			function(c) {
				c.pause()
			})
		},
		addTimer: function(g, e, h, f) {
			var d = this,
			f = f || [],
			c = {
				fn: g,
				repeatCount: 0,
				start: function() {
					if (h !== b && this.run === false) {
						this.startTime += d.now() - this.restTime
					} else {
						this.startTime = d.now()
					}
					this.run = true
				},
				pause: function() {
					if (this.run != false && h !== b) {
						this.restTime = d.now()
					}
					this.run = false
				},
				stop: function() {
					window.clearInterval(this.id);
					delete d.timers[this.id]
				},
				__init: function() {
					c.id = window.setInterval(function() {
						if (c.run === false) {
							return
						}
						g.apply(c, f);
						c.repeatCount++;
						if (h) {
							var i = d.now() - c.startTime;
							if (i > h) {
								c.oncomplete && c.oncomplete();
								c.stop()
							}
						}
					},
					e);
					c.start();
					d.timers[c.id] = c
				}
			};
			c.__init();
			return c
		},
		now: function() {
			return new Date().getTime()
		}
	})
})(PCgroup); (function(d, g) {
	var f = document,
	c = encodeURIComponent,
	e = decodeURIComponent;
	var a = {
		get: function(j) {
			var i,
			h;
			if (b(j)) {
				if ((h = f.cookie.match("(?:^| )" + j + "(?:(?:=([^;]*))|;|$)"))) {
					i = h[1] ? e(h[1]) : ""
				}
			}
			return i
		},
		set: function(j, o, h, k, m, l) {
			var n = c(o),
			i = h;
			if (typeof i === "number") {
				i = new Date();
				i.setTime(i.getTime() + h * 86400000)
			}
			if (i instanceof Date) {
				n += "; expires=" + i.toUTCString()
			}
			if (b(k)) {
				n += "; domain=" + k
			}
			if (b(m)) {
				n += "; path=" + m
			}
			if (l) {
				n += "; secure"
			}
			f.cookie = j + "=" + n
		},
		remove: function(h, i, k, j) {
			d.setCookie(h, "", 0, i, k, j)
		}
	};
	d.add({
		cookie: a,
		getCookie: a.get,
		setCookie: a.set,
		removeCookie: a.remove
	});
	function b(h) {
		return d.isString(h) && h !== ""
	}
})(PCgroup); (function(b, g) {
	var f = Array.prototype.slice,
	e = Object.prototype.toString,
	c = function(h, i, k, j) {
		this.elem = h;
		this.duration = i;
		this.easing = k;
		this.callback = function() {
			var l = b.getData(h, "timers");
			if (b.isArray(l) && l.length > 0) {
				l.shift()
			}
			j && j.call(this);
			b.dequeue(h)
		};
		this.clips = []
	},
	a = function(k, l, h, i, j) {
		this.elem = k;
		this.start = l;
		this.end = h;
		this.name = i;
		this.unit = j
	};
	var d = {
		visibility: "hidden",
		display: "block"
	};
	b.add({
		animate: function(k, h, l, r, s, n) {
			var j = arguments,
			t = [],
			q,
			o;
			for (var m = 2; m < j.length; m++) {
				if (b.isNumber(j[m])) {
					q = j[m]
				}
				if (b.isString(j[m])) {
					o = j[m]
				}
				if (b.isFunction(j[m])) {
					t.push(j[m])
				}
			}
			s = t[0];
			n = t[1];
			l = q || 1000;
			r = o || "swing";
			b.queue(k,
			function() {
				if (n && b.isFunction(n)) {
					if (n() === false) {
						b.dequeue(k);
						return
					}
				}
				var i = new c(k, l, r, s);
				b.each(h,
				function(z, B) {
					var x = z.toString().match(/^([+-]=)?([\d+-.]+)(.*)$/);
					if (x) {
						var p,
						y = B.toLowerCase();
						if (y == "scrollleft" || y == "scrolltop") {
							p = true
						}
						var w = parseFloat(x[2]),
						A = x[3],
						u = p ? k[B] : parseFloat(b.getStyle(k, B));
						if (!A) {
							if (B.search(/opacity/i) == -1) {
								A = "px"
							}
						}
						var v = new a(k, u, w, B, A);
						v.nonStyle = p;
						i.clips.push(v);
						lastProp = B
					}
				});
				i.init()
			});
			return k
		},
		easing: {
			linear: function(j, k, h, i) {
				return h + i * j
			},
			swing: function(j, k, h, i) {
				return (( - Math.cos(j * Math.PI) / 2) + 0.5) * i + h
			},
			quadIn: function(j, k, h, i) {
				return j * j * i + h
			},
			quadOut: function(j, k, h, i) {
				return - j * j * i + 2 * j * i + h
			},
			cubicIn: function(j, k, h, i) {
				return j * j * j * i + h
			},
			cubicOut: function(j, k, h, i) {
				return i * ((j -= 1) * j * j + 1) + h
			}
		},
		queue: function(i, j) {
			var h = b.getData(i, "queue");
			if (b.isArray(h)) {
				h.push(j)
			} else {
				h = [j];
				b.setData(i, "queue", h)
			}
			if (h[0] !== "inprogress") {
				this.dequeue(i)
			}
			return h
		},
		dequeue: function(k) {
			var i = this;
			var h = b.getData(k, "queue"),
			j = h && h.shift();
			if (j === "inprogress") {
				j = h.shift()
			}
			if (j) {
				h.unshift("inprogress");
				j.call(k,
				function() {
					i.dequeue(k)
				})
			}
		},
		pause: function(h) {
			var i = b.getData(h, "timers");
			if (b.isArray(i) && i[0]) {
				i[0].pause()
			}
		},
		begin: function(h) {
			var i = b.getData(h, "timers");
			if (b.isArray(i) && i[0]) {
				i[0].start()
			}
		},
		end: function(h) {
			b.setData(h, "queue", []);
			var i = b.getData(h, "timers");
			if (b.isArray(i) && i[0]) {
				i[0].stop()
			}
			b.removeData(h, "timers")
		},
		fadeTo: function(i, h, j, k) {
			b.animate(i, {
				opacity: h
			},
			j, "linear", k)
		},
		show: function(h, i, j) {
			b.setStyle(h, "display", "block");
			if (!i || !b.isNumber(i)) {
				return
			}
			b.fadeTo(h, 1, i, j)
		},
		hide: function(h, i, j) {
			if (!i || !b.isNumber(i)) {
				b.setStyle(h, "display", "none");
				return
			}
			b.fadeTo(h, 0, i,
			function() {
				b.setStyle(h, "display", "none");
				j && j.call(h)
			})
		},
		slideUp: function(i, j, m, l) {
			var h;
			if (b.isFunction(m)) {
				l = m;
				m = g
			}
			b.animate(i, {
				height: 0
			},
			j, m,
			function() {
				b.setStyle(i, {
					display: "none",
					height: h + "px"
				});
				b.setStyle(i, "overflow", "visible");
				if (l && b.isFunction(l)) {
					l.call(i)
				}
			},
			k);
			function k() {
				if (b.getStyle(i, "display") == "none") {
					return false
				}
				h = b.getData(i, "PCgroupOriHeight") || parseInt(b.getStyle(i, "height"));
				b.setStyle(i, "overflow", "hidden")
			}
		},
		slideDown: function(l, m, o, n) {
			if (b.getStyle(l, "display") != "none") {
				return
			}
			if (b.isFunction(o)) {
				n = o;
				o = g
			}
			var i,
			k = {
				height: 0,
				overflow: "hidden"
			},
			h = {},
			j = {
				overflow: b.getStyle(l, "overflow")
			};
			b.each(d,
			function(q, p) {
				h[p] = b.getStyle(l, p)
			});
			b.setStyle(l, d);
			i = l.clientHeight;
			b.setStyle(l, h);
			b.setStyle(l, k);
			if (b.getData(l, "PCgroupOriHeight") === null) {
				b.setData(l, "PCgroupOriHeight", i)
			}
			b.setStyle(l, "display", "block");
			b.animate(l, {
				height: i
			},
			m, o,
			function() {
				b.setStyle(l, j);
				if (n && b.isFunction(n)) {
					n.call(l)
				}
			})
		}
	});
	c.prototype = {
		init: function() {
			var h = this;
			h.timer = b.addTimer(function(j) {
				var l = b.now() - this.startTime,
				k = l / h.duration;
				b.each(h.clips,
				function(n, m) {
					var o = b.easing[h.easing](k, l, 0, 1);
					n.pos = n.start + ((n.end - n.start) * o)
				});
				h.update()
			},
			13, h.duration);
			h.timer.oncomplete = function() {
				b.each(h.clips,
				function(j) {
					j.pos = j.end
				});
				h.update();
				h.callback.call(h.elem)
			};
			var i = b.getData(h.elem, "timers");
			if (b.isArray(i)) {
				i.push(h.timer)
			} else {
				b.setData(h.elem, "timers", [h.timer])
			}
		},
		update: function() {
			b.each(this.clips,
			function(h) {
				if (h.nonStyle) {
					h.elem[h.name] = h.pos
				} else {
					b.setStyle(h.elem, h.name, h.pos + h.unit)
				}
			})
		}
	};
	PCgroup.dom.extend(PCgroup, ["animate", "show", "hide", "slideUp", "slideDown", "fadeTo", "begin", "pause", "end"])
})(PCgroup);
pc.add("faker",
function() {
	var f = window.document,
	e = /CSS1Compat/.test(f.compatMode),
	b = /webkit/ig.test(navigator.userAgent),
	a = e && !b ? f.documentElement: f.body;
	var g = function(m) {
		var l = {
			x: 0,
			y: 0
		};
		try {
			var o = m.getBoundingClientRect();
			l.x = o.left + a.scrollLeft;
			l.y = o.top + a.scrollTop
		} catch(n) {}
		return l
	};
	var d = function(k, j) {
		function m(p) {
			var r = {};
			var q;
			if (p.style.display == "none") {
				p.style.display = "block";
				q = "fixblock"
			}
			var o = p.getBoundingClientRect();
			if (q == "fixblock") {
				p.style.display = "none"
			}
			r.top = o.top + document.documentElement.scrollTop + document.body.scrollTop;
			r.left = o.left + document.documentElement.scrollLeft + document.body.scrollLeft;
			r.bottom = o.bottom + document.documentElement.scrollTop + document.body.scrollTop;
			return r
		}
		var i = m(k),
		n = m(j);
		var l = {
			left: i.left - n.left,
			top: i.top - n.top,
			bottom: i.bottom - n.bottom
		};
		return l
	};
	var h = function(k, i) {
		var j = f.createEventObject ? f.createEventObject() : f.createEvent("MouseEvents");
		if (!document.all) {
			j.initMouseEvent(i, true, true, document.defaultView, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
			k.dispatchEvent(j)
		} else {
			k.fireEvent("on" + i, j)
		}
	};
	var c = function(j) {
		if (arguments.length > 1) {
			var i = arguments,
			k = {};
			if (pc.isPlainObject(i[i.length - 1])) {
				i = Array.prototype.slice.call(i, 0);
				k = i.pop()
			}
			pc.each(i,
			function(l) {
				k.target = pc.isString(j) ? document.getElementById(l) : l;
				new pc.faker(k)
			});
			return
		}
		if (pc.isString(j)) {
			j = {
				target: document.getElementById(j)
			}
		}
		c.instances.push(this);
		this.config = pc.extend(j, c.config, false);
		this.init()
	};
	c.config = {
		className: "",
		col: 1,
		maxHeight: 240
	};
	c.instances = [];
	c.prototype = {
		init: function() {
			var u = this,
			r = u.config,
			o = u.target = r.target;
			if (!o || o.faker) {
				return
			}
			var i = "-" + o.id || "",
			s = o.parentNode,
			n = {
				select: ";width:" + o.offsetWidth + "px;height:" + o.offsetHeight + "px;float:" + pc.getStyle(o, "float"),
				pos: ";display:-moz-inline-stack;display:inline-block;zoom:1;*display:inline;position:relative;vertical-align:top;",
				hide: ";position:absolute;left:-2000px;",
				body: ";display:none;position:absolute;z-index:100;" + (r.height ? "height:" + r.height + "px;overflow:auto;": "")
			},
			l = '<!--[if IE 6]><iframe width="200px" height="300px" style="position:absolute; top:0; z-index:-1; filter:alpha(opacity=80);" src="about:blank"></iframe><![endif]-->';
			var j = pc.create("div", {
				id: "faker" + i,
				className: "faker"
			}),
			m = o.nextSibling;
			j.appendChild(o);
			j = s.insertBefore(j, m);
			j.style.cssText += n.pos + n.select;
			o.style.cssText += n.hide;
			o.faker = this;
			var k = o.disabled,
			t = pc.create("div", {
				className: "fakerWrap" + (k ? " disabled": "")
			});
			t = j.appendChild(t);
			t.style.cssText += ";position:relative;width:100%;-moz-user-select:none;";
			t.onselectstart = function() {
				return false
			};
			u.skin = t;
			u.wrap = j;
			var q,
			q = '<div class="fakerHead" id="faker' + i + '-head"><div></div></div>';
			q += '<div class="fakerBody ' + r.className + '" id="faker' + i + '-body" style="' + n.body + '"></div>';
			t.innerHTML = q;
			u.head = t.firstChild.firstChild;
			u.body = pc.nextElem(t.firstChild);
			u.holder = r.holder || document.body;
			p();
			function p() {
				var v = document.readyState,
				w = pc.browser.ie && u.holder == document.body && v !== "complete";
				if (!w) {
					u.body = u.holder.appendChild(u.body);
					u.attach();
					return
				}
				window.setTimeout(p, 500)
			}
			u.syncData()
		},
		attach: function() {
			var i = this,
			l = i.target,
			j = i.wrap,
			k = i.skin;
			pc.addEvent(i.head, "click",
			function(m) {
				if (l.disabled) {
					return
				}
				var n = i.body.style;
				if (n.display == "block") {
					i.close()
				} else {
					i.open()
				}
				m.stopPropagation()
			});
			pc.addEvent(i.head, "mouseover",
			function(n) {
				i.syncData();
				i.body.style.top = "auto";
				i.body.style.bottom = "auto";
				i.body.style.left = "auto";
				i.body.style.right = "auto";
				i.adjustTop();
				var m = d(i.wrap, i.holder);
				if (j.getBoundingClientRect().left + a.scrollLeft < a.clientWidth / 2) {
					i.body.style.left = m.left + "px"
				} else {
					i.body.style.right = i.holder.offsetWidth - m.left - j.offsetWidth + "px"
				}
				pc.addClass(k, "focus")
			});
			pc.addEvent(i.head, "mouseout",
			function(m) {
				if (!i.opened) {
					pc.removeClass(k, "focus")
				}
			});
			pc.addEvent(i.target, "focus",
			function(m) {
				if (l.disabled) {
					return
				}
				pc.addClass(k, "focus")
			});
			pc.addEvent(i.target, "blur",
			function() {
				pc.removeClass(k, "focus")
			});
			pc.addEvent(i.target, "change",
			function() {
				i.syncChange()
			});
			pc.addEvent(i.body, "click",
			function(m) {
				m.stopPropagation()
			});
			pc.addEvent(document, "click",
			function(m) {
				i.close()
			})
		},
		close: function() {
			var i = this.body.style;
			i.display = "none";
			pc.removeClass(this.skin, "focus");
			this.opened = false
		},
		open: function() {
			var i = this,
			j = i.body.style;
			if (pc.faker.opened) {
				pc.faker.opened.close()
			}
			if (i.initList && pc.browser.ie6) {
				j.top = "-9999px"
			}
			j.display = "block";
			pc.addClass(i.skin, "focus");
			pc.faker.opened = this;
			i.initList && i.initList();
			this.opened = true
		},
		adjustTop: function() {
			var j = this;
			var i = d(j.wrap, j.holder);
			var k = false;
			if (j.body.style.display == "none") {
				j.body.style.display = "block";
				k = true
			}
			var l = j.head.getBoundingClientRect();
			var m = j.body.offsetHeight;
			if (k == true) {
				j.body.style.display = "none"
			}
			if (l.top - m > 0 && l.top + j.head.offsetHeight + m > document.documentElement.clientHeight) {
				j.body.style.top = "auto";
				j.body.style.top = -m + d(j.head, j.holder).top + "px"
			} else {
				j.body.style.bottom = "auto";
				j.body.style.top = i.top + j.head.offsetHeight + "px"
			}
		},
		syncStatus: function() {
			var i = this,
			j = i.target.disabled;
			if (j) {
				pc.addClass(i.skin, "disabled")
			} else {
				pc.removeClass(i.skin, "disabled")
			}
		},
		syncWidth: function() {
			var i = this;
			window.setTimeout(function() {
				i.wrap.style.width = i.target.offsetWidth + "px"
			},
			0)
		},
		syncChange: function() {
			var j = this,
			k = j.selectedIndex | 0;
			if (!j.options) {
				return
			}
			pc.removeClass(j.options[k], "selected");
			j.selectedIndex = j.target.selectedIndex;
			pc.addClass(j.options[j.selectedIndex], "selected");
			j.head.innerHTML = pc.getText(j.options[j.selectedIndex])
		},
		syncData: function() {
			var u = this;
			if (u.options && !u.isUpdated()) {
				return
			}
			var o = '<div class="inner"' + (pc.browser.ipad && ' style=";height:auto;max-height:none;overflow:auto;"') + '><div class="fBody0">',
			n = 0,
			t,
			q,
			m = u.target.options;
			for (var p = 0; p < m.length; p++) {
				var r = 'class="',
				j = m[p].getAttribute("custom"),
				k = m[p].selected,
				s = m[p].disabled,
				l = m[p].getAttribute("caption") === "true";
				if (k) {
					r += " selected";
					u.selectedIndex = p;
					q = m[p].innerHTML
				}
				if (s) {
					r += " disabled"
				}
				if (l) {
					n++;
					r += " caption";
					o += '</div><div class="fBody' + n + (n % 2 ? " even": "") + '">'
				}
				r += '"';
				o += "<a href='javascript:void(0)' hidefocus='true' " + (j ? "custom=" + j: "") + " index='" + p + "' " + r + "value=" + m[p].value + ">" + m[p].innerHTML + "</a>"
			}
			o += "</div></div>";
			u.body.innerHTML = o;
			u.head.innerHTML = q;
			if (pc.browser.ie6) {
				u.initList = function() {
					window.setTimeout(function() {
						var i = u.body.firstChild;
						if (i.scrollHeight > u.config.maxHeight) {
							i.style.height = u.config.maxHeight + "px"
						}
						u.adjustTop();
						u.initList = null;
						delete u.initList
					},
					0)
				}
			}
			var t = u.options = u.body.getElementsByTagName("a");
			pc.each(u.options,
			function(w, v) {
				pc.addEvent(w, "click",
				function(x) {
					var i = pc.hasClass(w, "disabled");
					if (i) {
						return false
					}
					u.close();
					window.setTimeout(function() {
						if (pc.hasClass(w, "disabled")) {
							x.stopPropagation();
							return
						}
						u.target.options[w.getAttribute("index")].selected = "selected";
						u.syncChange();
						h(u.target, "change")
					},
					0);
					return false
				})
			})
		},
		sync: function() {
			this.syncStatus();
			this.syncWidth();
			this.syncChange()
		},
		isUpdated: function() {
			var j = this.target.options,
			i = this.options,
			k = j[j.length - 1].getAttribute("value"),
			l = i[i.length - 1].getAttribute("value");
			return j.length !== i.length || k !== l
		}
	};
	return c
} (pc));
function relatedSelect() {
	var f = arguments;
	relatedSelect.data = {};
	if (f.length <= 1) {
		return
	}
	for (var c = 0; c < f.length; c++) {
		f[c].fnName = f[c].id + "callback";
		f[c].obj = a(f[c].id);
		f[c].initurl = f[c].url;
		f[c].obj.index = c;
		f[c].obj.options[0].selected = true;
		f[c].obj.oriText = f[c].obj.options[0].text;
		if (f[c].url && c == 0 && !f[c].load) {
			f[c].obj.onmouseover = function() {
				var g = this.index;
				f[g].url += "?callback=" + f[g].fnName;
				e(f[g]);
				this.onmouseover = this.onfocus = null
			}
		}
		if (c > 0) {
			f[c].obj.disabled = true
		}
		if (c < f.length - 1) {
			f[c].obj.onchange = function() {
				var l,
				j,
				k = this.options,
				g = k.length,
				p = this.index | 0;
				for (var h = 0; h < g; h++) {
					if (k[h].selected) {
						l = k[h].getAttribute("custom");
						j = l && l.indexOf("+") != -1;
						l = l !== window.undefined ? l: this.value
					}
				}
				f[p].pointer = f[p].id + l;
				for (var h = p + 1; h < f.length; h++) {
					if (!f[h].url || f[h].initurl.indexOf("=") == -1) {
						return
					}
					if (h == p + 1 && !j && l) {
						var m = f[h];
						if (m.loadTimer) {
							window.clearTimeout(m.loadTimer)
						}
						m.loadTimer = window.setTimeout(function() {
							m.obj.options[0].text = "数据加载中...";
							if (m.obj.faker) {
								m.obj.faker.sync()
							}
						},
						200);
						f[h].url = f[h].initurl + l + "&callback=" + f[h].fnName;
						e(f[h], f[p].pointer)
					}
					d(f[h].obj);
					f[h].obj.disabled = true;
					if (f[h].obj.faker) {
						f[h].obj.faker.sync()
					}
				}
			}
		}
		if (f[c].url && f[c].load) {
			if (f[c].url.indexOf("=") > 0) {
				f[c].url += "&callback=" + f[c].fnName
			} else {
				f[c].url += "?callback=" + f[c].fnName
			}
			e(f[c])
		}
	}
	function e(i, g) {
		var h = relatedSelect.data[g];
		window[i.fnName] = function(l) {
			if (i.loadTimer) {
				window.clearTimeout(i.loadTimer)
			}
			var j,
			m = i.node;
			for (var k in l) {
				if (k == m.root) {
					j = l[k]
				}
			}
			if (!j || j == "" || j.length < 1) {
				if (i.obj.faker) {
					window.setTimeout(function() {
						i.obj.faker.sync()
					},
					100)
				}
				return
			}
			window.setTimeout(function() {
				i.obj.removeAttribute("disabled");
				i.obj.disabled = false;
				for (var o in j) {
					var q,
					p,
					n,
					s = j[o][m.value],
					r = j[o][m.text];
					m.custom && (q = j[o][m.custom]);
					p = j[o]["disabled"];
					n = j[o]["caption"];
					if (!s || !r) {
						continue
					}
					var t = new Option(r, s);
					q && t.setAttribute("custom", q);
					p !== window.undefined && t.setAttribute("disabled", p);
					n !== window.undefined && t.setAttribute("caption", n);
					i.obj.options[i.obj.length] = t
				}
				if (i.obj.faker) {
					i.obj.faker.syncData();
					i.obj.faker.sync()
				}
			},
			0);
			relatedSelect.data[g] = l
		};
		if (h) {
			window[i.fnName](relatedSelect.data[g])
		}
		b(h, i.url,
		function() {
			if (i.obj.oriText) {
				i.obj.options[0].text = i.obj.oriText
			}
		})
	}
	function d(h) {
		h.style.visibility = "hidden";
		var g = h.options[0];
		h.innerHTML = "";
		h.options[0] = g;
		h.style.visibility = "visible"
	}
	function b(j, l, m) {
		m = m ||
		function() {};
		if (j) {
			return m(false)
		}
		var i = window.__needJS__ || (window.__needJS__ = []),
		k = i[l] || (i[l] = {
			loaded: false,
			callbacks: []
		});
		var h = k.callbacks;
		if (h.push(m) == 1) {
			var g = document.createElement("script");
			g.onload = g.onreadystatechange = function() {
				var n = g.readyState;
				if (n && n != "loaded" && n != "complete") {
					return
				}
				k.loaded = true;
				for (var o = 0; o < h.length; o++) {
					h[o](true)
				}
			};
			g.src = l;
			document.getElementsByTagName("head")[0].appendChild(g)
		}
	}
	function a(g) {
		return document.getElementById(g) ;
	}
};
new pc.faker('zd_probrand', {
	className: 'multiFakerBody brandFakerBody'
});
new pc.faker('firm_3', {
	className: 'multiFakerBody firmFakerBody'
});
relatedSelect({
	id: "zd_probrand",
	url: "/include/brand_json_chooser.jsp",
	node: {
		root: "brands",
		value: "id",
		text: "text",
		custom: "id"
	},
	load: true
},
{
	id: "firm_3",
	url: "/include/indexjsondata/serial_json_chooser.jsp?brand=",
	node: {
		root: "firms",
		value: "id",
		text: "text",
		custom: "id"
	}
},
{
	id: "car_2",
	url: "/include/model_json_chooser.jsp?type=1&serial=",
	node: {
		root: "cars",
		value: "id",
		text: "text",
		custom: "id"
	}
});