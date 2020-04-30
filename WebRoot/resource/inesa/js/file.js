(function($, root){

	var file = {
		"attach": {
			"findAttachBox": function(fileName){
				return $(".attach-box[name='" + fileName + "']:last");
			},
			"doAttachError": function(fileData, msg){
				var $attachBox = this.findAttachBox(fileData["name"]);
				addGritter("error", msg);
				$attachBox.find(".attach-body").addClass("attach-error");
				$attachBox.find(".progress-bar").removeClass("progress-bar-success").addClass("progress-bar-danger");
				$attachBox.tooltip({"title": msg});
			},
			"doAttachSucc": function(fileData, msg, result){
				var $attachBox = this.findAttachBox(fileData["name"]);
				$attachBox.data({"state": "1", "result": result}).tooltip({"title": msg});
			}
		},
		"getAttachmentList": function(){
			var $attachBox = $(".attach-box").filter(function(){
				return $(this).data("state") == "1";
			});
			var attachment = {"files": []};
			$.each($attachBox, function(i, attach){
				var files = $(attach).data("result");
				$.each(files, function(i, file){
					attachment["inputName"] = file["inputName"];
					attachment["files"].push(file["files"][0]);
				});
			});
			attachment = [attachment];
			log(attachment);
			return attachment;
		},
		"bindFileUpload": function(){
			$(".up-attach").fileupload({
				"url": "media/add_media.action",
				"maxFileSize": 102400000,
				"change": function(e, data){
					mstRender({"data": data, "url": "view/sys/attach-box.html", "extend": {
						"sizeDis": function(){
							var size = this.size;
							var length = size.toString().length;
							var dis = "";
							if(length <= 6){
								dis = parseInt(this.size/1024) + "KB";
							}else if(length <= 9){
								dis = parseInt(this.size/1024/1024) + "MB";
							}else{
								dis = parseInt(this.size/1024/1024/1024) + "GB";
							}
							return dis;
						},
						"attachClass": function(){
							var type = this.name;
							var index = type.lastIndexOf(".") + 1
							index = index > type.length ? type.length : index;
							return "attach-type-" + type.substring(index)
						}
					}}, function(html){
						var $html = $(html);
						$html.find(".attach-remove").click(function(){
							$(this).closest(".attach-box").tooltip("destroy").remove();
						});
						$(".attach-list").append($html);
					});							
				},
				"done": function(e, data){
					log("----------------------------done-----------------------------");
					log(data);
					var $upload = $(".uploader-input");
					$upload.removeAttr("disabled");
					if(typeof data.result === "object" && data.result.exception){
						var fileName = data.files[0]["name"];
						var msg = fileName + "上传失败: " + data.result.exception;
						file.attach.doAttachError(data.files[0], msg);
					}else{
						file.attach.doAttachSucc(data.files[0], "上传成功", data.result);
					}
				},
				"send": function(e, data){
					var $upload = $(".uploader-input");
					$upload.attr("disabled",true);
					var fileName = data.files[0]["name"];
					var fileSize = data.files[0]["size"];
					if(fileSize > data.maxFileSize){
						var msg = fileName + "超过100MB最大限制,无法上传";
						file.attach.doAttachError(data.files[0], msg);
						return false;
					}
				},
				"progress": function(e, data){
					var fileName = data.files[0]["name"];
					var $attachBox = file.attach.findAttachBox(fileName);
					var $progress = $attachBox.find(".progress-bar");
					var progress = parseInt(data.loaded / data.total * 100, 10);
					$progress.css("width", progress + "%").html(progress + "%");
				}
			});			
		},
		"bindAttachListRemove": function(){
			$(".list-attach-remove").click(function(){
				var self = this;
				modal.loadModal({
					"id": "attachModal",
					"title": "确认框",
					"content": "确认删除此附件吗?",
					"btns": [
					    {"id": "remove-cancel", "name": "取消", "cls": "btn-default", "dismiss": true},
						{"id": "remove-confirm", "name": "确定删除", "cls": "btn-danger", "click": function(){
					    	var attachId = $("#attachModal").data("attachId");
					    	var $tr = $("#attachModal").data("tr");
							doPost("jkworkflow/remove_attachment.action", {"id": attachId}, function(data){
								addGritter("success", data.root);
								$tr.remove();
								$("#attachModal").modal("hide");
							});								
						}}
					]
				}, function(){
					var $tr = $(self).closest("tr");
					var id = $tr.data("id");
					$("#attachModal").data({"attachId": id, "tr": $tr});
				});
			});
		}
	};
	
	
	root.file = file;
	
})(jQuery, window);

