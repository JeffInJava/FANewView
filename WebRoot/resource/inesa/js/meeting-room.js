(function($){
	var meetingroom={
		meetingRooms:[],
		currentDate:null,
		planData:[],
		init:function(option){
			meetingroom.meetingRooms=option.meetingRooms;
			meetingroom.planData=option.planData;
			for(var i=0;i<meetingroom.meetingRooms.length;i++)
			{
				$(".meeting-room #meeting-room-name").append("<div class=\"side-cell\">"+meetingroom.meetingRooms[i].name+"</div>");
				$(".meeting-room #personSize").append("<div class=\"side-cell\">"+meetingroom.meetingRooms[i].personSize+"</div>");
				for (var j = 0; j <11; j++) {
					$(".meeting-room #grid-mark").append("<div class=\"cell cell-"+meetingroom.meetingRooms[i].id+"-"+j+"\" data-roomid=\""+meetingroom.meetingRooms[i].id+"\" data-hour=\""+(j+8)+"\">&nbsp;</div>");
				}
			}
			var nowDate=new Date();
			meetingroom.currentDate=nowDate;
			meetingroom.displayPlan(meetingroom.currentDate,meetingroom.planData);
			var currentDateStr = meetingroom.currentDateFormat(nowDate);
			$(".meeting-room #currentDate").html(currentDateStr);
			//
			$(".meeting-room #prev").bind("click",function(){
				meetingroom.currentDate=meetingroom.addDates(meetingroom.currentDate,-1);
				var tempDate = meetingroom.currentDateFormat(meetingroom.currentDate);
				$(".meeting-room #currentDate").html(tempDate);
				meetingroom.displayPlan(meetingroom.currentDate,meetingroom.planData);
			});
			$(".meeting-room #next").bind("click",function(){
				meetingroom.currentDate=meetingroom.addDates(meetingroom.currentDate,1);
				var tempDate = meetingroom.currentDateFormat(meetingroom.currentDate);
				$(".meeting-room #currentDate").html(tempDate);
				meetingroom.displayPlan(meetingroom.currentDate,meetingroom.planData);
			});

			if(option.enableChoose)
			{
				$(".meeting-room #grid-mark").addClass("enable");
				$(".meeting-room #grid-mark .cell").bind("click",function(){
					var roomid=$(this).data("roomid");
					var hour=$(this).data("hour");
					//
					if($(this).hasClass("meeting-schedule"))
					{
						addGritter("error", "该时间段被占用");
						return;
					}

					if($(".meeting-room #grid-mark .choose").length<=0 ||
					$(".meeting-room #grid-mark .choose:first").data("roomid")==roomid)
					{
						if(!$(this).hasClass("choose"))
						{
							if($(".meeting-room #grid-mark .choose").length>0 &&
							($(".meeting-room #grid-mark .choose:first").data("hour")-1!=hour
							&& $(".meeting-room #grid-mark .choose:last").data("hour")+1!=hour))
							{
								addGritter("error", "时间段必须连续");
								return;
							}
							$(this).addClass("choose");
						}
						else
						{
							for (var i = hour; i <=18; i++) {
								$(".cell-"+roomid+"-"+(i-8)).removeClass("choose");
							}
						}
					}else
					{
						addGritter("error", "只能选择同一个会议室的时间段");
					}
				});
			}
		},
		addDates:function(date,v){
			var newdate = new Date(date);
			newdate = newdate.valueOf();
			newdate = newdate + v * 24 * 60 * 60 * 1000;
			newdate = new Date(newdate);
			return newdate;
		},
		displayPlan:function(currentDate,planData)
		{
			$(".meeting-room #grid-mark .cell").removeClass("meeting-schedule");
			$(".meeting-room #grid-mark .cell").removeClass("choose");

			var date = new Date(currentDate);
			$.each(planData,function(i,item){
				var dateStartTime =item ? new Date(item.startTime.split(" ")[0]):null;
				if(item && date.getFullYear()==dateStartTime.getFullYear()
					&&date.getMonth()==dateStartTime.getMonth()
					&&date.getDate()==dateStartTime.getDate()
					&&date.getDay()==dateStartTime.getDay())
				{
					var startHour = parseInt(item.startTime.split(" ")[1].split(":")[0]);
					var hour=parseInt(item.endTime.split(" ")[1].split(":")[0])-parseInt(item.startTime.split(" ")[1].split(":")[0])+1;
					for (var i = startHour - 8; i < (startHour - 8 + hour); i++) {
						$(".meeting-room .cell-"+item.roomid+"-"+i).addClass("meeting-schedule");
					}
				}
			});
		},
		currentDateFormat:function(date)
		{
			var weekCN="";
			if(date.getDay()==1)
				weekCN="一";
			if(date.getDay()==2)
				weekCN="二";
			if(date.getDay()==3)
				weekCN="三";
			if(date.getDay()==4)
				weekCN="四";
			if(date.getDay()==5)
				weekCN="五";
			if(date.getDay()==6)
				weekCN="六";
			if(date.getDay()==0)
				weekCN="日";
			var currentDateStr = date.getFullYear()+"年"+(date.getMonth()+1)+"月"+date.getDate()+"日 星期"+weekCN;
			return currentDateStr;
		}
	};
	$.fn.meetingroom=function(option){
		meetingroom.init(option);
		return {
			getChooseTime:function(){
				var date=meetingroom.currentDate;
				var startHour=$(".meeting-room #grid-mark .choose:first").data("hour");
				var endHour=$(".meeting-room #grid-mark .choose:last").data("hour");
				var roomid=$(".meeting-room #grid-mark .choose:first").data("roomid");

				var dateStr=date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();

				var address="";
				$.each(meetingroom.meetingRooms,function(i,item){
					if(item.id==roomid)
						address=item.name;
				});

				return {
					tblMeetingRoomId:roomid,
					address:address,
					startTime:dateStr+" "+startHour+":00",
					endTime:dateStr+" "+endHour+":00"
				};
			}
		};
	};
})(window.jQuery);