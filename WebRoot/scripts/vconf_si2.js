function abc(el, v){
			var alt = el.alt;
			var arg = /focusFn{([^}].+?)}/.exec(alt);
			arg = (arg == null) ? false : arg[1];
			$removeClassName($(arg), 'hide');
		},
		'长度': {						
			msg: '{name}长度应为{range}位'
		},
		'相同': {						
			msg: '{name}不一致'
		},
		'支付密码不同于密码': {						
			msg: '为保护您的资金安全，支付密码和登录密码不能相同',
	        fn : function(e, v){
				var val = e.value;
				if(!val) return '';
				return ($('password').value == $('paypassword').value)?this.msg:'';
	        }
		},
		"无内容": {
			msg: '请输入{name}',
			fn:  function(e, v){
				var val = e.value;
				return (val!="点此显示验证码" && /./.test(val)) ? 'clear' : this.msg;
			}
		},
		"无内容sel": {
			msg: '请选择{name}',
			reg: /./
		},
		"全数字": {
			msg: '{name}不能为全数字',
			reg: /[^\d]+/
		},
		"有数字": {
			msg: '{name}不能有数字',
			reg: /^[^\d]+$/
		},
		"有空格": {
			msg: '{name}不能包含空格符',
			reg: /^[^ 　]+$/
		},
		"邮箱地址": {
			msg: '邮箱地址格式不正确',
			reg: /^[0-9a-z][_.0-9a-z-]{0,31}@([0-9a-z][0-9a-z-]{0,30}\.){1,4}[a-z]{2,4}$/
		},
		"手机号码": {
			msg: '{name}不正确',
			reg: /^1(3\d{1}|5[389])\d{8}$/
		},
		"证件号码": {
			msg: '{name}不正确',
			reg: /^(d){5,18}$/
		},
		"有大写": {
			msg: '{name}不能有大写字母',
			reg: /[A-Z]/,
			regFlag: true
		},
		"有全角": {
			msg: '{name}不能包含全角字符',
			reg: /[\uFF00-\uFFFF]/,
			regFlag: true
		},
		"首尾不能是空格": {
			msg: '首尾不能是空格',
			reg: /(^\s+)|(\s+$)/,
			regFlag: true
		},
		"怪字符": {
			msg: '{name}不能包含特殊字符',
			reg: />|<|,|\[|\]|\{|\}|\?|\/|\+|=|\||\'|\\|\"|:|;|\~|\!|\@|\#|\*|\$|\%|\^|\&|\(|\)|`/i ,
			regFlag : true
		},
		"怪字符pwd": {
			msg: '密码请勿使用特殊字符',
			reg: />|<|\+|,|\[|\]|\{|\}|\/|=|\||\'|\\|\"|:|;|\~|\!|\@|\#|\*|\$|\%|\^|\&|\(|\)|`/i,
			regFlag : true
		},
		"全部怪字符": {
			msg: '{name}不能包含特殊字符',
			reg: />|<|,|\[|\]|\{|\}|\?|\/|\+|=|\||\'|\\|\"|:|;|\~|\!|\@|\#|\*|\$|\%|\^|\&|\(|\)|\-|\—|\.|`/i ,
			regFlag : true
		},
		"有中文": {
			msg: '{name}不支持中文',
			reg: /[\u4E00-\u9FA5]/i,
			regFlag : true
		},
		"特殊字符": {
			msg: '{name}不支持特殊字符',
			reg: /[^a-zA-Z\.·\u4E00-\u9FA5\uFE30-\uFFA0]/i,
			regFlag : true
		},
		"下划线": {
			msg: '下划线不能在最后',
			fn:  function(e, v){
				var val = e.value;
				return (val.slice(val.length-1)=="_") ? this.msg : '';
			}
		},
		"首尾不能是下划线": {
			msg: '首尾不能是下划线',
			reg: /(^_+)|(_+$)/,
			regFlag: true
		},
		"有下划线": {
			msg: '不能包含下划线',
			fn:  function(e, v){
				var val = e.value;
				return (val.search("_") >= 0) ? this.msg : '';
			}
		},
		"可为空": {
			fn:  function(e, v){
				if(!e.value){
					e.style.background = '';
					return 'custom';
				}else { 
					return ''; 
				}
			}
		},
		"数字字母": {
			msg: '不能包含数字和英文字母以外的字符',
			reg: /[^0-9a-zA-Z]/i,
			regFlag : true
		},
		"数字字母中文": {
			msg: '不能包含数字、英文字母和汉字以外的字符',
			reg: /[^0-9a-zA-Z\u4E00-\u9FA5]/,
			regFlag : true
		},
		"数字字母中文空格下划线": {
			msg: '不能包含全角字符',
			reg: /[^0-9a-zA-Z\u4E00-\u9FA5\_\ ]/,
			regFlag : true
		},
		"非新浪邮箱": {
			fn: function(e,v) {
				var reg = /^[0-9a-z][_.0-9a-z-]{0,31}@((sina|vip\.sina|2008.sina|staff\.sina)\.){1}(cn|com|com\.cn){1}$/;
				if(reg.test(e.value)) {
					var entry = document.getElementById("entry").value;
					if ( entry == "client") {
						var url = location.href;
						var es=/invit=/;
						es.exec(url);
						var invite = RegExp.rightContext;
						
					}
				}else {
					return '';
				}
			}
			//msg: '新浪邮箱请直接<a href=\'http://login.sina.com.cn/hd/signin.php?entry=' + document.getElementById("entry") + '\'>登录</a>',
			//reg:  /^[0-9a-z][_.0-9a-z-]{0,31}@((sina|vip\.sina|2008.sina|staff\.sina)\.){1}(cn|com|com\.cn){1}$/,
			//regFlag : true
		},
		"无选中": {
			msg: '请选择{name}',
			fn: function(e,v) {
				switch (e.type.toLowerCase()) {
					case 'checkbox':
						return e.checked ? 'clear' : this.msg;
					case 'radio':
						var radioes = document.getElementsByName(e.name);
						for(var i=0; i<radioes.length; i++) {
							if(radioes[i].checked) return 'clear';
						}
						return this.msg;
					default:
						return 'clear';
				}
			}
		},
			"无选择": {
			msg: '请选择{name}',
			fn: function(e,v) {
				switch (e.type.toLowerCase()) {
					case 'select-one':
							return e.value ? 'clear': this.msg;
					default:
						return 'clear';
				}
			}
		},
		"条款": {
			msg: '{name}',
			fn: function(e,v) {
				switch (e.type.toLowerCase()) {
					case 'checkbox':
						return e.checked ? 'clear' : this.msg;
					case 'radio':
						var radioes = document.getElementsByName(e.name);
						for(var i=0; i<radioes.length; i++) {
							if(radioes[i].checked) return 'clear';
						}
						return this.msg;
					default:
						return 'clear';
				}
			}
		},
		"判断强度": {
			fn: function(e,v) {
				for (var i=1;i<=3;i++) {
					try {
						$removeClassName($("passW" + i), "passWcurr");
					}catch (e) {}
				}
				var password = e.value;
				var Modes = 0;
				var n = password.length;
				for (var i=0;i<n;i++) {
					Modes |= CharMode(password.charCodeAt(i));
				}
				var btotal = bitTotal(Modes);
				if (n >= 10) btotal++;
				switch(btotal) {
					case 1:
						try {
							$addClassName($("passW1"), "passWcurr");
						}catch (e) {}
						return;
					case 2:
						try {
							$addClassName($("passW2"), "passWcurr");
						}catch (e) {}
						return;
					case 3:
						try {
							$addClassName($("passW3"), "passWcurr");
						}catch (e) {}
						return;
					case 4:
						try {
							$addClassName($("passW3"), "passWcurr");
						}catch (e) {}
						return;
					default:
						return;
				}
			}
		},
		"判断强度2": {
			fn: function(e,v) {
				for (var i=4;i<=6;i++) {
					try {
						$removeClassName($("passW" + i), "passWcurr");
					}catch (e) {}
				}
				var password = e.value;
				var Modes = 0;
				var n = password.length;
				for (var i=0;i<n;i++) {
					Modes |= CharMode(password.charCodeAt(i));
				}
				var btotal = bitTotal(Modes);
				if (n >= 10) btotal++;
				switch(btotal) {
					case 1:
						try {
							$addClassName($("passW4"), "passWcurr");
						}catch (e) {}
						return;
					case 2:
						try {
							$addClassName($("passW5"), "passWcurr");
						}catch (e) {}
						return;
					case 3:
						try {
							$addClassName($("passW6"), "passWcurr");
						}catch (e) {}
						return;
					case 4:
						try {
							$addClassName($("passW6"), "passWcurr");
						}catch (e) {}
						return;
					default:
						return;
				}
			}
		},
		"判断验证码": {
			fn: function(e,v) {
				if (/^[0-9a-zA-Z]/.test(e.value)) {
					if (/[^0-9a-zA-Z]/.test(e.value)) return "验证码错误";
				}else if (/^[\u4E00-\u9FA5]/.test(e.value)) {
					if (/[^\u4E00-\u9FA5]/.test(e.value)) return "验证码错误";
				}
				return "";
			}
		},
		"排重": { fn: checkUsername },
		"邮箱注册排重": { fn: checkFreemail },
		"查域名": { fn: checkDomain },
		"验证生日": { fn: checkDate }
	}
