
/**
 * 公共的js,options等
 */


/*******************************异步加载一个页面到指定元素上************************************/
	//打开内部页面,href表示内部页面的全限定路径
	function openInnerPage(href, param){
		href = setUrlParams(href, param);
		window.location.hash = href;
	}
	
	/****************************iframe相关********************************/	
	
	//iframe内部调用: iframe内部发生高度变化时(如form validate验证后),调用此方法来调整高度
	function adjustIframeHeight(){
		var $iframe = $("#page-content-iframe", parent.document);
		var pageContentHeight = $(document).find("body").height();
		$iframe.height(pageContentHeight);
	}	
	
	//iframe加载时,或parent发生resize事件时，调用此方法
	function adaptIframeHeight(){
		var $iframe = $("#page-content-iframe");
		if($iframe.size() > 0){
			var pageContentHeight = $iframe.contents().find("body").height();
			$iframe.height(pageContentHeight);
		}		
	}
	
	
	/****************************获取url后面拼接的参数********************************/	
	
	//获取url后面拼接的参数
	function getUrlParams(key, url){
		var params = {};
		var url = url ? url : window.location.href;
		var pos = url.lastIndexOf("?");
		if(pos > 0){
			var paraStr = url.substring(pos + 1);
			var params = _convertParaStrToObject(paraStr);
			if(params){
				return key ? params[key] : params;
			}
		}else{
			return "";
		}
	}	
	
	//设置url参数
	function setUrlParams(url, params){
		if(url && params){
			var str = "";
			if(typeof params === 'string'){
				str = params;
			}
			if(typeof params === 'object'){
				$.each(params, function(key, value){
					if(key && value){
						if(typeof value === 'object'){
							value = JSON.stringify(value);
						}
						str += key + "=" + encodeURI(value) + "&";
					}
				});
			}
			if(url.indexOf("?") != -1){
				url += "&" + str;
			}else{
				url += "?" + str;
			}
		}
		return url;
	}
	
	//将url参数(如：name=jack&age=18&sex=1)转换为json对象
	function _convertParaStrToObject(paraStr){
		if(paraStr){
			var params = {};
			var arr = paraStr.split("&");
			for(var i = 0; i < arr.length; i ++){
				if(arr[i]){
					var para = arr[i].split("=");
					if(para && para.length == 2){
						params[para[0]] = decodeURI(para[1]);
					}
				}
			}
			return params;		
		}
	}
	
	//得到表单参数,利用formSerialize()方法序列化表单，然后再次解析，转换成json对象
	function getFormParams($form){
		if($form){
			var paraStr = $form.formSerialize();
			return _convertParaStrToObject(paraStr);
		}
	}
	
	//与在浏览器点击后退按钮相同
	function goBack(){
		window.history.back();
	}

	//cookie相关
	function setCookie(name, value, expireDays){
		var exp  = new Date();  
		if(expireDays) {
			exp.setTime(exp.getTime() + expireDays*24*60*60*1000);
		} else {
			exp.setTime(exp.getTime() + 30*24*60*60*1000);//缺省30天
		}
		document.cookie = name + "=" + escape (value) + ";expires=" + exp.toGMTString();
	}
	
	function getCookie(name){
		var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
		 if(arr != null) return unescape(arr[2]); return null;
	}
	
	function delCookie(name){
		var exp = new Date();
		exp.setTime(exp.getTime() - 1);
		var cval = getCookie(name);
		if(cval!=null) document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
	}	
	
	/***
	 * 菜单事件绑定，基于hash实现的异步页面加载
	 * 点击菜单时，修改hash，再通过hashchange事件获取hash值，异步调用
	 */
			
	//CHECK TO SEE IF URL EXISTS
	function checkURL() {
		//get the url by removing the hash
		var url = location.hash.replace(/^#/, "");
		var container = $("#main");
		// Do this if url exists (for page refresh, etc...)
		if(url){
			// match the menuNo(or url) and add the active class
//	 		var menuNo = getUrlParams("_m", url);
//	 		var $a = null;
//	 		if(menuNo){
//	 			$a = $("#sidebar .nav a[data-m='" + menuNo + "']");
//	 		}
//	 		if(!$a || $a.size() == 0){
//	 			var pos = url.indexOf("?");
//	 			var href = pos > 0 ? url.substring(0, pos) : url;
//	 			$a = $("#sidebar .nav a[href='" + href + "']");
//	 		}
			
			/**
			 * 渲染菜单
			 * 判断是否存在此菜单，如存在，则重新定位选中菜单，如不存在，则不做任何事
			 */
			loadURL(url, container);
		}else{
		}
	}	

	//LOAD AJAX PAGES
	function loadURL(url, container){			
		$.ajax({
			type : "GET",
			url : url,
			//dataType : "html",			
			beforeSend : function(){
				// cog placed			
			},
			success : function(data){
				indexVue.$data.value=100;
				//无法找到用户对象	
				$('#loading-bar').css('display','none');
				if(data.exceptionCode == "80"){
					window.location.href = $("base").attr("href");
					return;
				}
				//权限错误
				if(data.exceptionCode == "89"){
					window.location.href = $("base").attr("href") + "pages/error/access_denied.jsp";
					return;
				}				
				// cog replaced here...
				container.css({
					opacity : '0.0'
				}).html(data).delay(50).animate({
					opacity : '1.0'
				}, 300);
			},
			error : function(xhr, ajaxOptions, thrownError){
				container.html('<h4 style="margin-top:10px; display:block; text-align:left"><i class="fa fa-warning txt-color-orangeDark"></i> Error 404! 页面未找到.</h4>');
			}
		});
	}	
	
	function getSourceFromVue(obj){
		return JSON.parse(JSON.stringify(obj));
	}
	//请求AJAX显示消息和遮罩
	function doAjax(obj){
		//url,data,callback,type	
		var vueThis=new Vue();
		if(!obj.type){
			obj.type="post";
		}
		if(!obj.data){
			obj.data='';
		}	
		
		$.ajax({
			type : obj.type,
			url  : obj.url,
			data : obj.data,
			//dataType : "html",
			beforeSend : function(){					
				loadingInstance = window.ELEMENT.Loading.service({
		            //target: 'body',
		        });				  		  
			},
			
			success : function(data){
				if(loadingInstance){
					loadingInstance.close();
				}			
				if(data.exceptionCode && data.exceptionCode == "80"){
					window.location.href="pages/login.jsp";		
				}
				if(data.exception){
					vueThis.$message({ 
						message: data.exception,
						type: 'warning'
					});
				}else{						
					if(obj.successCallback){						
						obj.successCallback(data);
					}	
				}			
			},
			error : function(xhr, ajaxOptions, thrownError){
				if(loadingInstance){
					loadingInstance.close();
				}	
				if(xhr.status == 404){
					window.location.href="pages/modules/error/404.jsp";
					return;
				}else if(xhr.status == 500){
					window.location.href="pages/modules/error/500.jsp";
					return;
				}				
			}
		});
	}	
		
	
	//MessageBox 弹框	
	function confirmSubmit(obj){
		 try {
		      if(!obj.tip) obj.tip='确认提交此操作么?';
		      obj.vueThis.$confirm(obj.tip, '提示', {
		        confirmButtonText: '确定',
		        cancelButtonText: '取消',
		        type: 'warning'
		      }).then(function(action){
		        try {
		          if(obj.confirmCallback){
		        	 obj.confirmCallback();	
		          }
		        } catch (e) {
		          console.error(e);
		        }
		        obj.vueThis.$message({
			          type: 'success',
			          message: '操作成功',
			          showClose: true,
			          duration:1000
			        });
		        
		      }).catch(function(action) {	
		       obj.vueThis.$message({
		          type: 'info',
		          message: '已取消',
		          showClose: true,
		          duration:1000
		        });
		      });
		    } catch (e) {
		        console.log(e);
		 }
	};
	
	//上传	
	function upLoad(obj){
	       //obj.files,obj.form,obj.type,obj.url,obj.key, obj.successCallback();  
	var vueThis= new Vue(); 
      var xhr = new XMLHttpRequest();
      var data = new FormData();
        if(obj.files){
          for(var i=0;i<obj.files.length;i++){
            if(!obj.files[i])continue;
            if(obj.files[i].fileName){
              data.append("files",obj.files[i].file,obj.files[i].fileName);
            }else{
              data.append("files",obj.files[i]);
            }
          }
        };
        
      if(obj.key && !obj.form){
    	  alert("obj.key和obj.form同时传送，或者都不传");  
    	  return;
      }else if(!obj.key && obj.form){
    	  alert("obj.key和obj.form同时传送，或者都不传");  
    	  return;
      }else{
    	  data.append(obj.key,JSON.stringify(obj.form));
      }  
      
      if (obj.type == "GET") {
          xhr.open("GET", obj.url + "?" + data, true);
          xhr.send(null);
      } else if (obj.type == "POST") {
          xhr.open("POST", obj.url, true);
          xhr.send(data);
      };  
      
      loadingInstance = window.ELEMENT.Loading.service({
    	  text: 'loading...',
      });
      
      xhr.onreadystatechange = function() {       
    	  loadingInstance.close();
         if(xhr.readyState ==4 && xhr.status==200){       	
            var res = JSON.parse(xhr.responseText);
            if(obj.successCallback){
                obj.successCallback(res);
            }else{
            	vueThis.$message({
          		  type: 'warn',
                  message: res.exception,
              	});
            }            
         }else{
        	 vueThis.$message({
	     		 type: 'warn',
	             message: xhr.status,
	         });
         }       
      };
        xhr.onerror = function() {
        	loadingInstance.close();
        };
	};


