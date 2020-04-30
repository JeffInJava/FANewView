<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePathHttp = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
String basePathHttps = request.getScheme()+"s://"+request.getServerName()+request.getContextPath()+"/";
String basePath=basePathHttp;
%>
<!DOCTYPE html>
<html>
  <head>
	<base href="<%=basePath%>">

	<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
	<meta name="description" content="" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="renderer" content="webkit">
	
	<link rel="stylesheet" href="resource/element-ui/index.css" />
	
	<!-- basic scripts -->
	<script src='resource/jquery/js/jquery-1.9.1.min.js'></script>
	
	<script src="resource/vue/vue.min.js"></script>
	<script src="resource/element-ui/index.js"></script>
	<script src="resource/common.js"></script>
	<script src="resource/moment/moment.min.js"></script>
<!-- 	<script src="https://cdn.bootcss.com/babel-polyfill/7.0.0-rc.3/polyfill.js"></script> -->

	<title>全路网车站终端设备</title>
	<style>
	.el-card{
	   margin-bottom: 10px;
	   padding-top:10px;
    }
    .el-card__body{
        padding-top:10px;
	    padding-bottom:0;
    }	
   .el-table .cell {
	    padding:0px;
	}
	
	.totalTitle{
	   text-align:right;
	   height:36px;
	   line-height:36px;
	   font-size:9pt;
	}
	.option{
	   text-align:left;
	   height:36px;
	   line-height:36px;
	   color:red;
	   width:1%
	}
	.el-col {
	    margin: 5px;
	}
	.el-dialog--small{
	    width:80%
	}
    #div .el-dialog--small{
   		width:35%;
    }
    </style>
  </head>
  <body>
    <div  id="main" >
	  <el-row style="height:8%;text-align:center;" >
	       <h2 style="color:#409EFF">全路网车站终端设备</h2>
	   </el-row>
      <el-card>
         <el-form :inline="true"  :model="netCar">
	          <el-form-item label="线路" >
	               <el-select  v-model="netCar.lineDefault" placeholder="请选择线路"  @change="onChange()" >
	                    <el-option key="全部" label="全部" value="全部"></el-option>
	                   <el-option v-for="item in netCar.line" :key="item.LINE_ID" :label="item.LINE_NAME"  :value="item.LINE_ID"></el-option>
	               </el-select>
	          </el-form-item>
	          <el-form-item label="车站">
	               <el-select v-model="netCar.stationDefault"  placeholder="请选车站">
	                    <el-option key="全部" label="全部" value="全部"></el-option>
	                    <el-option v-for="item in netCar.station" :key="item.STATION_ID" :label="item.STATION_NM_CN" :value="item.STATION_ID"></el-option>
	               </el-select>
	          </el-form-item>
	          <el-form-item  label="设备类型">
	                <el-select v-model="netCar.deviceDefault" placeholder="请选设备">
	                     <el-option key="全部" label="全部" value="全部"></el-option>
	                     <el-option v-for="item in netCar.device"  :key="item.DEVICE_TYPE" :label="item.DEVICE_NAME"  :value="item.DEVICE_TYPE"></el-option>
	                </el-select>
	          </el-form-item>
	           <el-form-item>
	                 <el-button  type="primary" @click="selectNetCar">查询</el-button>
	          </el-form-item>
	          <el-form-item>
	                 <el-button  type="success" @click="handleAdd">新增</el-button> 
	          </el-form-item>
	           <el-form-item>
	                 <el-button  type="success" @click="handleAdd2">自营网点新增</el-button> 
	          </el-form-item>
         </el-form> 
       </el-card>
       
       <el-card>
	       <el-form :inline="true"  :model="netCar"> 
	          <el-form-item label="设备节点号">
	                 <el-input v-model="netCar.device_node"  placeholder="请输入设备节点号"  ></el-input>
	          </el-form-item>
	          <el-form-item label="清分节点号">
	                 <el-input v-model="netCar.QF_node" placeholder="请输入清分节点号"  ></el-input>
	          </el-form-item>
	          <el-form-item label="IP地址">
	                 <el-input v-model="netCar.IP"  placeholder="请输入IP地址"  ></el-input>
	          </el-form-item>
	       </el-form>
      </el-card>
      
      <el-card >
            <el-table :data="stationList" border style="font-size:12px;"  height=450 width=100%  stripe="true" >
                 <el-table-column prop="LINE_NAME"  label="线路"  align="center"></el-table-column>
                 <el-table-column prop="STATION_NM_CN"  label="车站"  align="center"></el-table-column>
                 <el-table-column prop="DEVICE_ID"  label="设备" width="50" align="center"></el-table-column>
                 <el-table-column prop="DEVICE_NODE"  label="设备节点号"   align="center"></el-table-column>
                  <el-table-column prop="QF_NODE"  label="清分节点号"  align="center"></el-table-column>
                 <el-table-column prop="DEVICE_NAME"  label="设备类型"  align="center"></el-table-column>
                 <el-table-column prop="IP"  label="IP地址"  width="130"  align="center"></el-table-column>
                 <el-table-column prop="OS"  label="操作系统"   align="center"></el-table-column>
                 <el-table-column prop="SOFTWAR_VER"  label="软件版本"   align="center"></el-table-column>
                 <el-table-column prop="VERSION"  label="型号" width="130" align="center"></el-table-column>
                 <el-table-column prop="PRODUCTION_NAME"  label="上位机厂商"  align="center"></el-table-column>
                 <el-table-column prop="READER_WRITER_FIRM_ENTER"  label="进站读写器厂商" width="130"  align="center"></el-table-column>
                 <el-table-column prop="READER_WRITER_TYPE_ENTER"  label="进站读写器类型"  width="130" align="center"></el-table-column>
                 <el-table-column prop="READER_WRITER_VER_ENTER"  label="进站读写器软件版本" width="130"  align="center"></el-table-column>
                 <el-table-column prop="READER_WRITER_FIRM_OUT"  label="出站读写器厂商"  width="130" align="center"></el-table-column>
                 <el-table-column prop="READER_WRITER_TYPE_OUT"  label="出站读写器类型" width="130"  align="center"></el-table-column>
                 <el-table-column prop="READER_WRITER_VER_OUT"  label="出站读写器软件版本" width="130"  align="center"></el-table-column>
                 <el-table-column prop="BAO_CARD"  label="保通卡通道"  align="center"></el-table-column>
                 <el-table-column prop="SWITC_HBOARD"  label="交换机"  align="center"></el-table-column>
                 <el-table-column prop="TYPE"  label="类型"  align="center"></el-table-column>
                 <el-table-column prop="REMARK"  label="备注"  align="center"></el-table-column>
            </el-table>
            
            <div style="width:100%;text-align:center;padding-top:10px; ">
		    <el-pagination background @size-change="handleSize" @current-change="handleCurrent"
		      :current-page="page.currentPage" :page-sizes="[50,100,150,200]" :total="totals"
		      :page-size="page.pageSize" layout="total,sizes,prev,pager,next,jumper">
		    </el-pagination>
		</div>
      </el-card>
      
    <el-dialog  :visible.sync="dialogVisible"  :before-close="handleClose"  >
      <el-row  style="margin-bottom:15px;margin-left:10%">
      	<span style="color:red; font-size:13pt; ">带   *  号为必填项</span>
      </el-row>
         <el-row>
		     <el-col :span="2"><div class="totalTitle" >线路</div></el-col>
		     <el-col :span="4">
		      <div class="totalTitle">
		          <el-select    v-model="addDevice.lineDefault"  @change="addChange()">
		                 <el-option v-for="item in addDevice.line" :key="item.LINE_ID"  :label="item.LINE_NAME"  :value="item.LINE_ID"></el-option>
		          </el-select>
		       </div>
		     </el-col>
		     <el-col :span="1" class="option">*</el-col>
		     
		     <el-col :span="2"><div class="totalTitle"><span>车站</span></div></el-col>
		     <el-col :span="4">
		           <el-select   v-model="addDevice.stationDefault"  >
						<el-option  v-for="item in addDevice.station"  :key="item.STATION_ID" :label="item.STATION_NM_CN"   :value="item.STATION_ID"></el-option>
			     </el-select>
		     </el-col>
		     <el-col :span="1" class="option">*</el-col>
		     
		     <el-col :span="3"><div class="totalTitle">设备</div></el-col>
		     <el-col :span="4"  >
			       <div class="totalTitle"><el-input  v-model="addDevice.device_id"    ></el-input></div>
		     </el-col>
		     <el-col :span="1"><div  div class="option">*</div></el-col> 
		 </el-row>
		 
		<el-row>     
		     <el-col :span="2"><div class="totalTitle" >设备节点号</div></el-col>
		     <el-col :span="4"  >
			       <div class="totalTitle"><el-input  v-model="addDevice.device_node"    ></el-input></div>
		     </el-col>
		     <el-col :span="1" class="option">*</el-col>  
		     
		     <el-col :span="2"><div class="totalTitle" >清分节点号</div></el-col>
		     <el-col :span="4"  >
			       <div class="totalTitle"><el-input  v-model="addDevice.QF_node"    ></el-input></div>
		     </el-col>
		     <el-col :span="1" class="option">*</el-col>
		     
		     <el-col :span="3"><div class="totalTitle" >设备类型</div></el-col>
		     <el-col :span="4" >
		         <div class="totalTitle">
		           <el-select  v-model="addDevice.deviceDefault"   >
		               <el-option v-for="item in netCar.device" v-if="item.DEVICE_TYPE!='09'" :key="item.DEVICE_TYPE" :label="item.DEVICE_NAME"  :value="item.DEVICE_TYPE"></el-option>
		           </el-select>
		         </div>
		     </el-col>
		     <el-col :span="1" class="option">*</el-col>  
		</el-row>
		
		<el-row>  
		     <el-col :span="2"><div class="totalTitle">IP地址</div></el-col>
		     <el-col :span="4"  >
			       <div class="totalTitle"><el-input  v-model="addDevice.IP"    ></el-input></div>
		     </el-col>
		     <el-col :span="1" class="option">*</el-col>
		     
		     <el-col :span="2"><div class="totalTitle">操作系统</div></el-col>
		     <el-col :span="4"  >
			       <div class="totalTitle"><el-input  v-model="addDevice.OS"    ></el-input></div>
		     </el-col>
		     <el-col :span="1" class="option"></el-col>
		     
		     <el-col :span="3"><div class="totalTitle">软件版本</div></el-col>
		     <el-col :span="4"  >
			       <div class="totalTitle"><el-input  v-model="addDevice.softwar_ver"    ></el-input></div>
		     </el-col>
		     <el-col :span="1" class="option"> </el-col>
		</el-row>
		
		<el-row>  
		     <el-col :span="2"><div class="totalTitle">型号</div></el-col>
		     <el-col :span="4"  >
			       <div class="totalTitle"><el-input  v-model="addDevice.version"    ></el-input></div>
		     </el-col>
		     <el-col :span="1" class="option"></el-col>
		     
		     <el-col :span="2"><div class="totalTitle">上位机厂商</div></el-col>
		     <el-col :span="4"  >
			       <div class="totalTitle"><el-input  v-model="addDevice.production_name"    ></el-input></div>
		     </el-col>
		     <el-col :span="1" class="option"></el-col>
		</el-row>
		
		<el-row > 
		     <el-col :span="2"   class="totalTitle">进站读写器厂商</el-col>
		     <el-col :span="4"  >
			       <div class="totalTitle"><el-input  v-model="addDevice.reader_writer_firm_enter"    ></el-input></div>
		     </el-col>
		     <el-col :span="1" class="option"></el-col>
		     
		     <el-col :span="2" ><div class="totalTitle">进站读写器类型</div></el-col>
		     <el-col   :span="4"  >
			       <div class="totalTitle"><el-input  v-model="addDevice.reader_writer_type_enter"    ></el-input></div>
		     </el-col>
		     <el-col :span="1"  class="option"></el-col>
		     
			<el-col  :span="3"><div class="totalTitle">进站读卡器软件版本</div></el-col>
		    <el-col :span="4">
			       <div class="totalTitle"><el-input  v-model="addDevice.reader_writer_ver_enter"    ></el-input></div>
		    </el-col>
		</el-row>
		     
	   <el-row> 
	     <el-col :span="2"><div class="totalTitle">出站读卡器厂商</div></el-col>
	     <el-col :span="4"  >
		       <div class="totalTitle"><el-input  v-model="addDevice.reader_writer_firm_out"    ></el-input></div>
	     </el-col>
	     <el-col :span="1"   class="option"></el-col>
	      
	     <el-col :span="2"><div class="totalTitle">出站读卡器类型</div></el-col>
	     <el-col :span="4"  >
		       <div class="totalTitle"><el-input  v-model="addDevice.reader_writer_type_out"    ></el-input></div>
	     </el-col>
	     <el-col :span="1"   class="option"></el-col>
		  
		 <el-col :span="3"><div class="totalTitle">出站读卡器软件版本</div></el-col>
	     <el-col :span="4"  >
		       <div class="totalTitle"><el-input  v-model="addDevice.reader_writer_ver_out"    ></el-input></div>
	     </el-col>
	   </el-row>
  
       <el-row>
             <el-col :span="2"><div class="totalTitle">保通卡通道</div></el-col>
		     <el-col :span="4"  >
			       <div class="totalTitle"><el-input  v-model="addDevice.bao_card"    ></el-input></div>
		     </el-col>
		     <el-col :span="1"  class="option"></el-col>
		     
             <el-col :span="2"><div class="totalTitle">交换机</div></el-col>
		     <el-col :span="4"  >
			       <div class="totalTitle"><el-input  v-model="addDevice.switc_hboard"    ></el-input></div>
		     </el-col>
		     <el-col :span="1" class="option"></el-col>
		     
		     <el-col :span="3"><div class="totalTitle">类型</div></el-col>
		     <el-col :span="4"  >
			       <div class="totalTitle"><el-input  v-model="addDevice.type"    ></el-input></div>
		     </el-col>
		     <el-col :span="1"></el-col>
       </el-row>

		<el-row>
		     <el-col :span="2"><div class="totalTitle">备注</div></el-col>
		     <el-col :span="4"  >
			       <div class="totalTitle"><el-input  v-model="addDevice.remark"    ></el-input></div>
		     </el-col>
		</el-row>
		
	    <span slot="footer" >
	      <el-button  type="primary" @click="saveDevice"  :disabled="optStatue">保存</el-button>
	    </span>
	</el-dialog> 
	
	
	
	 <el-dialog  id="div"  :visible.sync="dialogVisible2"  :before-close="handleClose2"  	 >
         <el-form :inline="true"  :model="addDevice" label-width="160px" > 
	          <el-form-item label="线路" >
	                  <el-select style="width:90%"   v-model="addDevice.lineDefault"  @change="addChange()">
		                 <el-option v-for="item in addDevice.line" :key="item.LINE_ID"  :label="item.LINE_NAME"  :value="item.LINE_ID"></el-option>
		             </el-select>
	          </el-form-item>
	          <el-form-item label="车站">
	                 <el-select style="width:90%"  v-model="addDevice.stationDefault"  >
						<el-option  v-for="item in addDevice.station"  :key="item.STATION_ID" :label="item.STATION_NM_CN"   :value="item.STATION_ID"></el-option>
			         </el-select>
	          </el-form-item>
	          <el-form-item label="设备类型">
	                  <el-select style="width:90%" v-model="addDevice.device_add"  value="自营网点"  :disabled=true></el-select>
	          </el-form-item>
	          <el-form-item label="IP地址">
	               <el-col :span="22">
	                 <el-input  v-model="addDevice.IP"></el-input>
	               </el-col>
	          </el-form-item>
	            
	   </el-form>
	      
	   <span slot="footer" >
		      <el-button  type="primary" @click="saveDevice2"  :disabled="optStatue2">保存</el-button>
	   </span>
	</el-dialog> 
	
	
	   <el-dialog  title="提示"  :visible.sync="successMessage" :modal="false"  style="width:40%;margin-left:30%" >
		  <span style="font-size:20px;color:#67C23A">
		      <i class="el-icon-circle-check" style="" ></i>
		  </span>
		  <span style="font-size:18px;color:#67C23A">{{msg}}</span>
		  <span slot="footer" class="dialog-footer">
		    <el-button type="primary" @click="successMessage = false">确 定</el-button>
		  </span>
	   </el-dialog>
	</div>
  </body>
  
  <script type="text/javascript">

	var indexVue=new Vue({
		//绑定dom的地方
		el:'#main',
		data:function(){			
			return {
				successMessage:false,
				dialogVisible:false,
				optStatue:false,
				dialogVisible2:false,
				optStatue2:false,
				msg:'',
				//表格
				stationList:[],
				//添加
				addDevice:{
					lineDefault:'',
					line:[],
					stationDefault:'',
					station:[],
					deviceDefault:'',
					device:[],
					device_id:'',
					device_node:'',
					QF_node:'',
					device_type:'',
					IP:'',
					OS:'',
					softwar_ver:'',
					version:'',
					production_name:'',
					reader_writer_firm_enter:'',
					reader_writer_type_enter:'',
					reader_writer_ver_enter:'',
					reader_writer_firm_out:'',
					reader_writer_type_out:'',
					reader_writer_ver_out:'',
					bao_card:'',
					switc_hboard:'',
					type:'',
					remark:'',
					device_add:'自营网点'
				},
				//分页
				page:{
					currentPage:1,
		    	    pageSize:50
				},
				totals:1,
				//线路，车站
				netCar:{
					lineDefault:'全部',
					line:[],
					stationDefault:'全部',
					station:[],
					deviceDefault:'全部',
					device:[]
					
				},
				//车站集合
				stationBackList:[]
				
			}
		},
		
		mounted:function(){
			 this.dataInit();
		},
		methods:{
			//初始化页面参数数据
			dataInit:function(){
				$.post("device/data_Load.action",function(data){
					//表格数据
					indexVue.stationList = data.list;
					//线路下拉框
					indexVue.netCar.line = data.line_list;
					indexVue.addDevice.line = data.line_list;
					//车站下拉框
					indexVue.stationBackList = data.station_list;
					indexVue.netCar.station = data.station_list;
					indexVue.addDevice.station = data.station_list;
					//设备下拉框
					indexVue.netCar.device = data.device_list;
					//indexVue.addDevice.device = data.device_list_add;
				
				});
			},
			handleClose:function(done){
				this.dialogVisible=false;
				this.uploadDialogVisible=false;
			},
			handleClose2:function(done){
				this.dialogVisible2=false;
				this.uploadDialogVisible2=false;
			},
			//点击新增，弹层操作
			handleAdd:function(){
		    	this.dialogVisible=true;
		    	this.optStatue=false;
		    	this.addDevice.lineDefault='';
		    	this.addDevice.stationDefault='';
		    	this.addDevice.deviceDefault='';
				this.addDevice.device_id='',
		    	this.addDevice.device_node='';
		    	this.addDevice.QF_node='';
		    	this.addDevice.device_type='';
		    	this.addDevice.IP='';
		    	this.addDevice.OS='';
		    	this.addDevice.softwar_ver='';
		    	this.addDevice.version='';
		    	this.addDevice.production_name='';
		    	this.addDevice.reader_writer_firm_enter='';
		    	this.addDevice.reader_writer_type_enter='';
		    	this.addDevice.reader_writer_ver_enter='';
		    	this.addDevice.reader_writer_firm_out='';
		    	this.addDevice.reader_writer_type_out='';
		    	this.addDevice.reader_writer_ver_out='';
		    	this.addDevice.bao_card='';
		    	this.addDevice.switc_hboard='';
		    	this.addDevice.type='';
		    	this.addDevice.remark='';
			},
			
			//点击自营网点新增，弹层操作
			handleAdd2:function(){
		    	this.dialogVisible2=true;
		    	this.optStatue2=false;
		    	this.addDevice.lineDefault='';
		    	this.addDevice.stationDefault='';		    	
		    	this.addDevice.IP='';
		    	
			},
			
			//点击查询按钮
			selectNetCar:function(){
				 var param={
						 "line_id":this.netCar.lineDefault,
						 "station_id":this.netCar.stationDefault,
						 "device_type":this.netCar.deviceDefault,
						 "currentPage":this.page.currentPage,
						 "pageSize":this.page.pageSize,
						 "device_node":this.netCar.device_node,
						 "qf_node":this.netCar.QF_node,
						 "ip":this.netCar.IP
				     };
				 doAjax({url:"device/device_query.action",data:param,successCallback:function(data){
					     indexVue.totals = data.count;
					     indexVue.stationList = data.list;
				 }});
			},
			
			// 选择线路，刷新车站下拉框
			onChange:function(){
				var id=this.netCar.lineDefault;
				var stationName = [];
				if('全部'==id){
					stationName = this.stationBackList;
				}else{
					for(var i=0;i<this.stationBackList.length;i++){
						  if(this.stationBackList[i].LINE_ID==id){
							  var arr="{STATION_ID:"+"'"+this.stationBackList[i].STATION_ID+"'"+",STATION_NM_CN:"+"'"+this.stationBackList[i].STATION_NM_CN+"'"+"}";
							  stationName.push(eval('(' + arr + ')'));
						  }
					}
				}
				indexVue.netCar.station = stationName;
			},
			//添加表单中，选择线路，刷新车站下拉框
			addChange:function(){
				var id=this.addDevice.lineDefault;
				var stationName = [];
				for(var i=0;i<this.stationBackList.length;i++){
					  if(this.stationBackList[i].LINE_ID==id){
						  var arr="{STATION_ID:"+"'"+this.stationBackList[i].STATION_ID+"'"+",STATION_NM_CN:"+"'"+this.stationBackList[i].STATION_NM_CN+"'"+"}";
						  stationName.push(eval('(' + arr + ')'));
					  } 
				}
				indexVue.addDevice.station = stationName;
			},
			//添加表单保存按钮
			saveDevice:function(){
			    	
				this.$confirm('确认要添加该条数据么', '提示', {
		            confirmButtonText: '确定',
		            cancelButtonText: '取消',
		            type: 'warning'
		          }).then(() => {
		        	  var param = {
								 "line_id": this.addDevice.lineDefault,
								 "station_id": this.addDevice.stationDefault, 
								 "device_id": this.addDevice.device_id,
								 "device_node": this.addDevice.device_node, 
								 "QF_node": this.addDevice.QF_node,
								 "device_type": this.addDevice.deviceDefault, 
								 "IP": this.addDevice.IP,
								 "OS": this.addDevice.OS, 
								 "softwar_ver": this.addDevice.softwar_ver, 
								 "version": this.addDevice.version,
								 "production_name": this.addDevice.production_name, 
								 "reader_writer_firm_enter": this.addDevice.reader_writer_firm_enter, 
								 "reader_writer_type_enter": this.addDevice.reader_writer_type_enter, 
								 "reader_writer_ver_enter": this.addDevice.reader_writer_ver_enter, 
								 "reader_writer_firm_out": this.addDevice.reader_writer_firm_out, 
								 "reader_writer_type_out": this.addDevice.reader_writer_type_out, 
								 "reader_writer_ver_out": this.addDevice.reader_writer_ver_out, 
								 "bao_card": this.addDevice.bao_card, 
								 "switc_hboard": this.addDevice.switc_hboard, 
								 "type": this.addDevice.type,
								 "remark": this.addDevice.remark,
						 };
		        	//校验数据
		        	if(indexVue.checkForm(param)){
		        		
		        		 doAjax({ url:"device/add_device.action",data:param,successCallback:function(data){
							  if("success"==data.root){
								  indexVue.msg='添加成功';
								  indexVue.successMessage=true;
								  indexVue.dialogVisible = false;
								  indexVue.optStatue=true;
								  indexVue.dataInit();
							  }else if("false"==data.root){
								  indexVue.msg='添加失败';
								  indexVue.successMessage=true;
								  indexVue.dialogVisible = false;
								  indexVue.optStatue=true;
								  indexVue.dataInit();
							  }else{
								  indexVue.msg='添加异常';
								  indexVue.successMessage=true;
								  indexVue.dialogVisible = false;
								  indexVue.optStatue=true;
							  }
						 }});
		        	}
		          }).catch(() => {
		            this.$message({type: 'info',message: '已取消操作'});
		            indexVue.dialogVisible = false;
		          });
		    	this.optStatue=false;
				
			},
			//自营网点添加
			saveDevice2:function(){
				this.$confirm('确认要添加该条数据么', '提示', {
		            confirmButtonText: '确定',
		            cancelButtonText: '取消',
		            type: 'warning'
		          }).then(() => {
		        	  var param = {
								 "line_id": this.addDevice.lineDefault,
								 "station_id": this.addDevice.stationDefault, 
								 "device_type":'09',
								 "ip": this.addDevice.IP
						 };
		        	//校验数据
		        	if(indexVue.checkParam(param)){
		        		
		        		 doAjax({ url:"device/add_self.action",data:param,successCallback:function(data){
							  if("success"==data.root){
								  indexVue.msg='添加成功';
								  indexVue.successMessage=true;
								  indexVue.dialogVisible2 = false;
								  indexVue.optStatue2=true;
								  indexVue.dataInit();
							  }else if("false"==data.root){
								  indexVue.msg='添加失败';
								  indexVue.successMessage=true;
								  indexVue.dialogVisible2 = false;
								  indexVue.optStatue2=true;
								  indexVue.dataInit();
							  }else{
								  indexVue.msg='添加异常';
								  indexVue.successMessage=true;
								  indexVue.dialogVisible2 = false;
								  indexVue.optStatue2=true;
							  }
						 }});
		        	}
		          }).catch(() => {
		            this.$message({type: 'info',message: '已取消操作'});
		            indexVue.dialogVisible2 = false;
		          });
		    	this.optStatue=false;
			},
			//校验数据
			 checkForm:function(pm){
		    	if(pm.line_id.trim()==""){
		    		this.$message.warning('请选择线路！');
		    		return false;
		    	}
		    	if(pm.station_id.trim()==""){
		    		this.$message.warning('请选择车站！');
		    		return false;
		    	}
		    	if(pm.device_id.trim()==""){
		    		this.$message.warning('请选择设备！');
		    		return false;
		    	}
		    	if(pm.device_node.trim()==""){
		    		this.$message.warning('请输入设备节点号！');
		    		return false;
		    	}
		    	if(pm.QF_node.trim()==""){
		    		this.$message.warning('请输入清分节点号！');
		    		return false;
		    	}
		    	if(pm.device_type.trim()==""){
		    		this.$message.warning('请选择设备类型！');
		    		return false;
		    	}
		    	if(pm.IP.trim()==""){
		    		this.$message.warning('请输入IP地址！');
		    		return false;
		    	}
		    	return true;
		    },
		    //校验自营网点添加数据
		    checkParam:function(pm){
		    	if(pm.line_id.trim()==""){
		    		this.$message.warning('请选择线路！');
		    		return false;
		    	}
		    	if(pm.station_id.trim()==""){
		    		this.$message.warning('请选择车站！');
		    		return false;
		    	}
		    	if(pm.IP.trim()==""){
		    		this.$message.warning('请输入IP地址！');
		    		return false;
		    	}
		    	return true;
		    },
		    //分页
		    handleSize:function(val){
		    	this.page.pageSize=val;
		    },
		    handleCurrent:function(val){
		    	this.page.currentPage=val;
		    	this.selectNetCar();
		    }
		    
		    
			
		}
		
	
	})	
  </script>
</html>
