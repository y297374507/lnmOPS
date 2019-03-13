%rebase base position='分组管理',managetopli="opsconf"

<link rel="stylesheet" href="/assets/bootstrap-select/bootstrap-select.min.css">

<div class="page-body">
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="widget">
                <div class="widget-header bordered-bottom bordered-themesecondary">
                    <i class="widget-icon fa fa-tags themesecondary"></i>
                    <span class="widget-caption themesecondary">分组列表</span>
                    <div class="widget-buttons">
                        <a href="#" data-toggle="maximize">
                            <i class="fa fa-expand"></i>
                        </a>
                        <a href="#" data-toggle="collapse">
                            <i class="fa fa-minus"></i>
                        </a>
                        <a href="#" data-toggle="dispose">
                            <i class="fa fa-times"></i>
                        </a>
                    </div>
                    
                </div><!--Widget Header-->
                <div style="padding:-10px 0px;" class="widget-body no-padding">
                    <div class="tickets-container">
                        <div class="table-toolbar" style="float:left">
                            <a id="addtaskgrps" target="_bank" href="{{session.get('WebSSHurl',None)}}/ssh/host/127.0.0.1?port=22" class="btn  btn-primary ">
                                <i class="btn-label fa fa-cog"></i>管理API
                            </a>
                            %if msg.get('message'):
                      		    <span style="color:{{msg.get('color','')}};font-weight:bold;">&emsp;{{msg.get('message','')}}</span>
                    	    %end
                        </div>
                       <table id="myLoadTable" class="table table-bordered table-hover"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog"  aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" >
      <div class="modal-content" id="contentDiv">
         <div class="widget-header bordered-bottom bordered-blue ">
           <i class="widget-icon fa fa-pencil themeprimary"></i>
           <span class="widget-caption themeprimary" id="modalTitle">API信息</span>
        </div>

         <div class="modal-body">
            <div>
            <form id="modalForm">
               <div class="form-group">
                  <label class="control-label" for="inputSuccess1">API名称：</label>
                  <input type="text" class="form-control" id="grpname" name="grpname" require>
               </div>
               <div class="form-group">
                  <label class="control-label" for="inputSuccess1">API路径：</label>
                  <textarea id="grpdesc" name="grpdesc" style="height:60px;width:100%;line-height:1.5;resize:vertical;" ></textarea>
               </div>
               <div class="form-group">
                  <label class="control-label" for="inputSuccess1">API说明：</label>
                  <textarea id="grpdesc" name="grpdesc" style="height:60px;width:100%;line-height:1.5;resize:vertical;" ></textarea>
               </div>
               <div class="form-group">
                  <label class="control-label" for="inputSuccess1">API版本：</label>
                  <textarea id="grpdesc" name="grpdesc" style="height:60px;width:100%;line-height:1.5;resize:vertical;" ></textarea>
               </div>
        	   <div class="form-group">
                  <input type="hidden" id="hidInput" value="">
                  <button type="button" id="subBtn" class="btn btn-primary  btn-sm">提交</button>
                  <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">关闭</button> 
	           </div>
             </form>
            </div>
         </div>
      </div>
   </div>
</div>
<script type="text/javascript">
$(function(){
    /**
    *表格数据
    */
    var editId;        //定义全局操作数据变量
	var isEdit;
    $('#myLoadTable').bootstrapTable({
          method: 'post',
          url: '/api/getapiinfos',
          contentType: "application/json",
          datatype: "json",
          cache: false,
          checkboxHeader: true,
          striped: true,
          pagination: true,
          pageSize: 15,
          pageList: [10,20,50],
          search: true,
          showColumns: true,
          showRefresh: true,
          minimumCountColumns: 2,
          clickToSelect: true,
          smartDisplay: true,
          //sidePagination : "server",
          sortOrder: 'asc',
          sortName: 'id',
          columns: [{
              field: 'bianhao',
              title: 'checkbox',      
              checkbox: true,
          },{
              field: 'xid',
              title: '编号',
              align: 'center',
              valign: 'middle',
              width:25,
              //sortable: false,
              formatter:function(value,row,index){
                return index+1;
              }
          },{
              field: 'apiname',
              title: 'API名称',
              align: 'center',
              valign: 'middle',
              sortable: false
          },{ 
              field: 'apipath',
              title: 'API路径',
              align: 'center',
              valign: 'middle',
              sortable: false
          },{
              field: 'apidesc',
              title: 'API说明',
              align: 'center',
              valign: 'middle',
              sortable: false
          },{
              field: 'apiversion',
              title: 'API版本',
              align: 'center',
              valign: 'middle',
              sortable: false
          },{
	      field: '',
              title: '操作',
              align: 'center',
              valign: 'middle',
              width:220,
              formatter:getinfo
          }]
      });

    function getinfo(value,row,index){
        eval('rowobj='+JSON.stringify(row));
        //定义按钮样式，只有管理员或自己编辑的任务才有权编辑
        /*if({{session.get('access',None)}} == '1' || "{{session.get('name',None)}}" == rowobj['userid']){
            var style_edit = '<a href="/changeroom/'+rowobj['id']+'" class="btn-sm btn-info" >';
        }else{
            var style_edit = '<a class="btn-sm btn-info" disabled>';
        }*/
        //定义按钮样式，只有管理员或自己编辑的任务才有权点击
        if({{session.get('access',None)}} == '1' || "{{session.get('name',None)}}" == rowobj['userid']){
            var style_more = '&nbsp;<a href="/showapiinfo/'+rowobj['id']+'" class="btn-sm btn-danger" >';
        }else{
            var style_more = '&nbsp;<a class="btn-sm btn-danger" disabled>';
        }

        return [
            /*style_edit,
                '<i class="fa fa-edit"> 编辑</i>',
            '</a>', */

           style_more,
                '<i class="fa fa-times"> 查看详情</i>',
            '</a>'
        ].join('');
    }



    /**
    *添加弹出框
    */
	$('#addtaskgrp').click(function(){
        $('#modalTitle').html('新增分组');
        $('#grptasks').selectpicker('val',['noneSelectedText']); //清除默认值
        $('#hidInput').val('0');
        $('#myModal').modal('show');
        $('#modalForm')[0].reset();
        isEdit = 0;
    });


    /**
    *修改弹出框
    */
    
    $('#changetaskgrp').popover({
    	    html: true,
    	    container: 'body',
    	    content : "<h3 class='btn btn-danger'>请选择一条进行操作</h3>",
    	    animation: false,
    	    placement : "top"
    }).on('click',function(){
    		var result = $("#myLoadTable").bootstrapTable('getSelections');
    		if(result.length <= 0){
    			$(this).popover("show");
    			setTimeout("$('#changetaskgrp').popover('hide')",1000)
    		}
    		if(result.length > 1){
    			$(this).popover("show");
    			setTimeout("$('#changetaskgrp').popover('hide')",1000)
    		}
    		if(result.length == 1){
                $('#changetaskgrp').popover('hide');
                $('#grpname').val(result[0]['grpname']);
                $('#grpdesc').val(result[0]['grpdesc']);
                $('#modalTitle').html('分组变更');     //头部修改
                $('#hidInput').val('1');            //修改标志
                $('#myModal').modal('show');
                //console.log(result[0]['grptasks'])
                var arr = result[0]['grptasks'].split(',');
                //console.log(arr)
                $('#grptasks').selectpicker('val',arr); //处理grptasks选择默认值
                editId = result[0]['id'];
				isEdit = 1;
    		}
        });

    /**
    *提交按钮操作
    */
    $("#subBtn").click(function(){
           var grpname = $('#grpname').val();
           var grpdesc = $('#grpdesc').val();
           var grptasks = $('#grptasks').val();
           var postUrl;
           if(isEdit==1){
                postUrl = "/changetaskgrp/"+editId;           //修改路径
           }else{
                postUrl = "/addtaskgrp";          //添加路径
           }

           $.post(postUrl,{grpname:grpname,grpdesc:grpdesc,grptasks:grptasks},function(data){
                  if(data==0){
                    $('#myModal').modal('hide');
                    $('#myLoadTable').bootstrapTable('refresh');
                    message.message_show(200,200,'成功','操作成功');   
                  }else if(data==-1){
                      message.message_show(200,200,'失败','操作失败');
                  }else{
                        message.message_show(200,200,'添加失败','填写不完整');return false;
                }
            },'html');
       });

})
</script>

<script src="/assets/bootstrap-select/bootstrap-select.min.js"></script>
