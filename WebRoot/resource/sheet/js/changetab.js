var _selected = document.getElementById("a");
var _selected_tr = document.getElementById("11");
function changeTab(obj,trid){
         if( _selected != null && _selected != obj ){
				   _selected.className = "b-12";
					_selected_tr.style.display = "none";
         }
         _selected = obj;
		_selected.className = "a-12";
		
         _selected_tr = document.getElementById(trid);
         document.getElementById(trid).style.display = "block";
}

var _selected_2 = document.getElementById("b");
var _selected_tr_2 = document.getElementById("21");
function changeTab_2(obj,trid){
         if( _selected_2 != null && _selected_2 != obj ){
				   _selected_2.className = "b-22";
					_selected_tr_2.style.display = "none";
         }
         _selected_2 = obj;
		_selected_2.className = "a-22";
         _selected_tr_2 = document.getElementById(trid);
         document.getElementById(trid).style.display = "block";
}

var _selected_3 = document.getElementById("c");
var _selected_tr_3 = document.getElementById("31");
function changeTab_3(obj,trid){
         if( _selected_3 != null && _selected_3 != obj ){
				   _selected_3.className = "list_b-12";
					_selected_tr_3.style.display = "none";
         }
         _selected_3 = obj;
		_selected_3.className = "list_a-12";
         _selected_tr_3 = document.getElementById(trid);
         document.getElementById(trid).style.display = "block";
}