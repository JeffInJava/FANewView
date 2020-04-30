var holiday = [];
var flux = [];
setTimeout(_getFlux,100);
setTimeout(_getHoliday,100);
    function bindDatepicker(obj) {
        $(obj).bind("click", function () {
            WdatePicker({
                el: obj,
                autoPickDate: true,
                Mchanged: setCalendar
            });
			//加载数据
			//loadData(obj.value);
            setCalendar();
        });
    }
    //对日历设置
    function setCalendar() {
        var WdateIframe = $dp.dd.getElementsByTagName("iframe");

        if (WdateIframe.length > 0) {
            WdateIframe = WdateIframe[0];
			WdateIframe.style.height = "360px";
        } else {
            return;
        }
        var reg = /day_Click\((\d{4}),(\d{1,2}),(\d{1,2})\);/;
        var doc = WdateIframe.contentWindow.document;
        var _tables = doc.getElementsByTagName("table");    //当日历表格加载后才执行事件处理
        if (_tables.length == 0) {
            setTimeout(setCalendar, 100);
            return;
        }
        $(doc).find('.WdayTable td').each(function (index, element) {
            var html = element.outerHTML;
            var m = reg.exec(html);
            if (m) {
            	var _color = "black";
            	var _color2 = "black";
            	var _holiday = "";
            	var _flux = "&nbsp;";
            	var _background = "white";
            	var backgroundFlag = false;

				//m[1],m[2],m[3]分别为年月日
                var date = m[1] + '-' + m[2] + '-' + m[3];
                
                var dt = new Date(m[1], m[2]-1, m[3]);
                
                //组合比较用日期
                var _date = m[1];
                if (m[2].length == 1){
                	_date  = _date + "0";
                }
                _date = _date + m[2];
                if (m[3].length == 1){
                	_date  = _date + "0";
                }
                _date = _date + m[3];
                //加载数据
                //loadData(_date);
                
                //判断颜色
                if (dt.getDay() == 0 || dt.getDay() == 6){
                	_color = "red";
                }
                for (var i=0;i<holiday.length;i++){
                	if (holiday[i]["STMT_DAY"] == _date){
                		if (holiday[i]["HOLIDAY_TYPE"]=="1"){
                			_holiday = holiday[i]["HOLIDAY_NAME"];
                			_color = "red";
                		}else{
                			_color = "black";
                		}
                	}
                }
                for (var i=0;i<flux.length;i++){
                	if (_date == flux[i]["STMT_DAY"]){
                		_flux = flux[i]["TOTAL_TIMES"]+"万";
                	}
                }
                //非当月日期设置灰色
                if (index>=7 & index <14){
            		if (m[3]>7){
            			_background = "#f4f1f1";
            			_color = "gray";
            			_color2="gray";
            		}
            	}
            	if (index>=36){
            		if (m[3]<=14){
            			_background = "#f4f1f1";
            			_color = "gray";
            			_color2="gray";
            		}
            	}
                
                
                //此段可以作出判断，比如是节假日时候处理
                element.innerHTML = "<div  style='background-color:"+_background + ";border:#BDEBEE 1px solid;width:75px' align='center'>" +
                "<div width='100%' style='font-size:16px;font-weight:bold;color:"+_color+";width:100%;'>" + m[3] + "</div>" +
                "<div style='font-size:10px;color:"+_color2+"'><font color='"+_color+"'><strong>"+_holiday+"</strong></font> "+_flux+"</div></div>";

            }
        });
    }
    var parentToday=window.parent.document.getElementById("parentTodayId").value;
	function loadData(val){
		var _val = val;
		var myDate = new Date();
		if(parentToday){
			myDate=new Date(parentToday);
		}
		var currentMonth = myDate.getMonth()*1 + 1;
		var currentDate = myDate.getDate()*1 + 1;
		if (currentMonth<10){
			currentMonth = "0" + currentMonth;
		}
		if (currentDate<10){
			currentDate = "0" + currentDate;
		}
		_val = myDate.getFullYear() + "" + currentMonth + "" + currentDate;
		
		if (val != null && val!="" && val <= _val){
			_val = val.substring(0,6);
		}else{//大于今天，不查询
			return;
		}
		if (_val.substring(0,4)< "2014"){
			//2014年前数据不查询
			return;
		}

		var hasFluxData = false;
		for (var i=0;i<flux.length;i++){
			if (_val.substring(0,6)==flux[i]['STMT_DAY'].substring(0,6)){
				hasFluxData = true;
				break;
			}
		}

		if (!hasFluxData){
			_getFlux(_val);
		}

		var hasHolidayData = false;
		for (var i=0;i<holiday.length;i++){
			if (_val.substring(0,4)==holiday[i]['STMT_DAY'].substring(0,4)){
				hasHolidayData = true;
				break;
			}
		}
		if (!hasHolidayData){
			_getHoliday(_val.substring(0,4));
		}
	}
	function _getFlux(){
		$.ajax({
            dataType:"json",
			async:false,
            type:"POST",
            url:"resource/DatePicker/jsonDataFlow.jsp",
            //data:{"month":monthval},
            success:function(data){
			   flux = flux.concat(data);
            },
            error:function(data){
                alert("Error");
            }
        });
	}
	function _getHoliday(){
		$.ajax({
            dataType:"json",
			async:false,
            type:"POST",
            url:"resource/DatePicker/jsonDataHoliday.jsp",
            //data:{"year":yearval},
            success:function(data){
			   holiday = holiday.concat(data);
            },
            error:function(data){
                alert("Error");
            }
        });
	}

