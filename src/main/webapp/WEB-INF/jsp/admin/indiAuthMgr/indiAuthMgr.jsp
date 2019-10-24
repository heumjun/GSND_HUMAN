<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/font-awesome/font-awesome.min.css" type="text/css">
<link rel="stylesheet" href="/css/ui.jqgrid.css" type="text/css" />
<link rel="stylesheet" href="/css/redmond/jquery-ui-1.10.4.custom.css" type="text/css" />
<style>
.endbox {
	position: relative;
	text-align: right;
	left: -10px;
}

table th {
	text-align: center;
}

.required {
	background-color: #FFFFA2;
	text-transform: uppercase;
	border: 1px solid #000;
}

.common, select {
	font-family: '굴림';
	border:1px solid #999999;
    width:100%;
    margin:5px 0;
    padding:3px;
}

table {
	font-family: '굴림';
	font-size: 11px;
	font-weight: 100;
}

.btn-group-sm > .btn, .btn-sm {
	padding: .2rem .5rem;
}
</style>
<form id="application_form" name="application_form" >
<div class="container-fluid">
	<!-- Breadcrumbs-->
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="#">개별권한관리</a></li>
		<!-- <li class="breadcrumb-item active">목록</li> -->
	</ol>
	<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
		<col width="120">
		<col width="150">
		<col width="120">
		<col width="150">
		<col width="120">
		<col width="150">
		<col width="*"/>
		<tbody>
			<tr>
				<th style="font-size: 13px; font-weight: 100;">로그인ID</th>
				<td><input type="text" class="common" id="p_login_id" name="p_login_id" alt="아이디"  style="width:120px;" value="" /></td>
				
				<th style="font-size: 13px; font-weight: 100;">이름</th>
				<td><input type="text" class="common" id="p_name" name="p_name" alt="이름"  style="width:120px;" value="" /></td>
				
				<th style="font-size: 13px; font-weight: 100;">권한</th>
				<td>
					<select id="p_auth_code" name="p_auth_code"  style="width:120px; font-size: 13px; font-weight: 100;">
					</select>
				</td>	
				<td>
					<div class="button endbox">
						<button type="button" id="btnSearch" class="btn btn-primary btn-sm" >조회</button>
						<button type="button" id="btnSave" class="btn btn-primary btn-sm" >저장</button>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="table-responsive">
	
		<div id="divList" style="position:relative; float: left; width: 55%;">
			<table id="jqGridMasterList"></table>
			<div id="btnJqGridMasterList"></div>
		</div>
		<div id="divList1" style="position:relative; float: right; width: 41%;">
			<table id="jqGridDetailList" style="width: 100%"></table>
			<div id="btnjqGridDetailList"></div>
		</div>
		
	</div>
</div>
</form>
<!-- /.container-fluid-->
<script src="/js/jquery-1.11.0.min.js"></script>
<script src="/js/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/js/sb-admin.min.js"></script>
<script type="text/javascript" src="/js/commonGridUtil.js" charset='utf-8'></script>
<script type="text/javascript" src="/js/jquery.jqGrid.min.js" charset='utf-8'></script>
<script type="text/javascript" src="/js/jqgrid/i18n/grid.locale-en.js" charset='utf-8'></script>
<script src="/js/jqueryAjax.js"></script>
<script type="text/javascript">
var idRow;
var idCol;
var kRow;
var kCol;
var resultData = [];

var jqGridMasterObj = $('#jqGridMasterList');
var jqGridDetailObj = $('#jqGridDetailList');

$(function() {
	getAjaxHtml($("#p_auth_code"), "admin.indiAuthMgr.indiAuthSelectBoxDataList.do?sb_type=sel&p_query=getIndiAuthSelectBoxDataList", null, null);	
});


$(document).ready(function(){
	
	jqGridMasterObj.jqGrid({ 
	    datatype: 'json', 
	    mtype: 'POST',
	    url: 'admin.indiAuthMgr.indiAuthMgrList.do',
	    postData : fn_getFormData('#application_form'),
	    colNames : ['seq', '로그인 ID', '이름', 'E_MAIL', '권한코드', '권한', 'OPER'],
	    colModel : [
					{name:'seq_id', index:'seq_id', width:55, align:'center', hidden: true},
					{name:'login_id',index:'login_id', width:50, excel:'아이디'},
					{name:'name',index:'name', width:40, align:'center'},
					{name:'e_mail',index:'e_mail', width:100, align:'left'},
					{name:'auth_code',index:'auth_code', width:100, align:'center', hidden:true},
					{name:'auth_code_name',index:'auth_code_name', width:80, align:'left', hidden:false},
					{name:'oper', index:'oper', width:50, align:'center', sortable:true, title:false, hidden: true}
				],
	    gridview: true,
	    toolbar: [false, "bottom"],
	    viewrecords: true,
	    autowidth: true,
	    cellEdit : true,
        cellsubmit : 'clientArray', // grid edit mode 2
	    scrollOffset : 17,
	    shrinkToFit:true,
	    multiselect: true,
	    //pager: $('#btnJqGridMasterList'),
	    rowList:[100,500,1000],
	    recordtext: '내용 {0} - {1}, 전체 {2}',
	    emptyrecords:'조회 내역 없음',
	    rowNum : 99999, 
		beforeEditCell :  function(rowid, cellname, value, iRow, iCol) {
	    	idRow=rowid;
	    	idCol=iCol;
	    	kRow = iRow;
	    	kCol = iCol;
		},
		beforeSaveCell : chmResultEditEnd,
		jsonReader : {
	        root: "rows",
	        page: "page",
	        total: "total",
	        records: "records",  
	        repeatitems: false,
	    },        
	    //imgpath: 'themes/basic/images',
	    onPaging: function(pgButton) {
	    	
    		var pageIndex         = parseInt($(".ui-pg-input").val());
   			var currentPageIndex  = parseInt(jqGridMasterObj.getGridParam("page"));// 페이지 인덱스
   			var lastPageX         = parseInt(jqGridMasterObj.getGridParam("lastpage"));  
   			var pages = 1;
   			var rowNum 			  = 100;	   

   			if (pgButton == "user") {
   				if (pageIndex > lastPageX) {
   			    	pages = lastPageX
   			    } else pages = pageIndex;
   				
   				rowNum = $('.ui-pg-selbox option:selected').val();
   			}
   			else if(pgButton == 'next'){
   				pages = currentPageIndex+1;
   				rowNum = $('.ui-pg-selbox option:selected').val();
   			} 
   			else if(pgButton == 'last'){
   				pages = lastPageX;
   				rowNum = $('.ui-pg-selbox option:selected').val();
   			}
   			else if(pgButton == 'prev'){
   				pages = currentPageIndex-1;
   				rowNum = $('.ui-pg-selbox option:selected').val();
   			}
   			else if(pgButton == 'first'){
   				pages = 1;
   				rowNum = $('.ui-pg-selbox option:selected').val();
   			}
 	   		else if(pgButton == 'records') {
   				rowNum = $('.ui-pg-selbox option:selected').val();     
   			}
   			
   			$(this).jqGrid("clearGridData");
   			$(this).setGridParam({datatype: 'json',page:''+pages, rowNum:''+rowNum}).triggerHandler("reloadGrid"); 		
		 },		
		 loadComplete: function (data) {
			var $this = $(this);
			if ($this.jqGrid('getGridParam', 'datatype') === 'json') {
			    $this.jqGrid('setGridParam', {
			        datatype: 'local',
			        data: data.rows,
			        pageServer: data.page,
			        recordsServer: data.records,
			        lastpageServer: data.total
			    });
			
			    this.refreshIndex();
			
			    if ($this.jqGrid('getGridParam', 'sortname') !== '') {
			        $this.triggerHandler('reloadGrid');
			    }
			} else {
			    $this.jqGrid('setGridParam', {
			        page: $this.jqGrid('getGridParam', 'pageServer'),
			        records: $this.jqGrid('getGridParam', 'recordsServer'),
			        lastpage: $this.jqGrid('getGridParam', 'lastpageServer')
			    });
			    this.updatepager(false, true);
			}	
		}
		
	}); //end of jqGrid
	
	jqGridDetailObj.jqGrid({ 
	    datatype: 'json', 
	    mtype: 'POST',
	    url: 'admin.stanAuthMgr.stanAuthMgrList.do',
	    postData : fn_getFormData('#application_form'),
	    colNames : ['', '권한코드', '권한', '설명', 'OPER'],
	    colModel : [
					{name:'seq_id', index:'seq_id', width: 30, align:'center',
					    formatter: function radio(cellValue, option) {
					        return '<input type="radio" value=' + cellValue + ' name="radioid" />';
					    }
					},
					{name:'stand_auth_code', index:'stand_auth_code', width:80, align:'center', hidden:true},
					{name:'stand_auth_code_name',index:'stand_auth_code_name', width:65, align:'left'},
					{name:'description',index:'description', width:165, hidden:false},
					{name:'oper', index:'oper', width:50, align:'center', sortable:true, title:false, hidden: true}
				],
	    gridview: true,
	    toolbar: [false, "bottom"],
	    viewrecords: true,
	    autowidth: true,
	    cellEdit : true,
        cellsubmit : 'clientArray', // grid edit mode 2
	    scrollOffset : 17,
	    shrinkToFit:true,
	    multiselect: false,
	    //pager: $('#btnjqGridDetailList'),
	    rowList:[100,500,1000],
	    recordtext: '내용 {0} - {1}, 전체 {2}',
	    emptyrecords:'조회 내역 없음',
	    rowNum : 99999, 
		beforeEditCell :  function(rowid, cellname, value, iRow, iCol) {
	    	idRow=rowid;
	    	idCol=iCol;
	    	kRow = iRow;
	    	kCol = iCol;
		},
		beforeSaveCell : chmResultEditEnd,
		jsonReader : {
	        root: "rows",
	        page: "page",
	        total: "total",
	        records: "records",  
	        repeatitems: false,
	    },        
	    //imgpath: 'themes/basic/images',
	    onPaging: function(pgButton) {
	    	
    		var pageIndex         = parseInt($(".ui-pg-input").val());
   			var currentPageIndex  = parseInt(jqGridDetailObj.getGridParam("page"));// 페이지 인덱스
   			var lastPageX         = parseInt(jqGridDetailObj.getGridParam("lastpage"));  
   			var pages = 1;
   			var rowNum 			  = 100;	   

   			if (pgButton == "user") {
   				if (pageIndex > lastPageX) {
   			    	pages = lastPageX
   			    } else pages = pageIndex;
   				
   				rowNum = $('.ui-pg-selbox option:selected').val();
   			}
   			else if(pgButton == 'next'){
   				pages = currentPageIndex+1;
   				rowNum = $('.ui-pg-selbox option:selected').val();
   			} 
   			else if(pgButton == 'last'){
   				pages = lastPageX;
   				rowNum = $('.ui-pg-selbox option:selected').val();
   			}
   			else if(pgButton == 'prev'){
   				pages = currentPageIndex-1;
   				rowNum = $('.ui-pg-selbox option:selected').val();
   			}
   			else if(pgButton == 'first'){
   				pages = 1;
   				rowNum = $('.ui-pg-selbox option:selected').val();
   			}
 	   		else if(pgButton == 'records') {
   				rowNum = $('.ui-pg-selbox option:selected').val();     
   			}
   			
   			$(this).jqGrid("clearGridData");
   			$(this).setGridParam({datatype: 'json',page:''+pages, rowNum:''+rowNum}).triggerHandler("reloadGrid"); 		
		},		
		loadComplete: function (data) {
			var $this = $(this);
			if ($this.jqGrid('getGridParam', 'datatype') === 'json') {
			    $this.jqGrid('setGridParam', {
			        datatype: 'local',
			        data: data.rows,
			        pageServer: data.page,
			        recordsServer: data.records,
			        lastpageServer: data.total
			    });
			
			    this.refreshIndex();
			
			    if ($this.jqGrid('getGridParam', 'sortname') !== '') {
			        $this.triggerHandler('reloadGrid');
			    }
			} else {
			    $this.jqGrid('setGridParam', {
			        page: $this.jqGrid('getGridParam', 'pageServer'),
			        records: $this.jqGrid('getGridParam', 'recordsServer'),
			        lastpage: $this.jqGrid('getGridParam', 'lastpageServer')
			    });
			    this.updatepager(false, true);
			}	
			
		},
		gridComplete : function() {
		},
	}); //end of jqGrid

	// jqGrid 크기 동적화
	//fn_gridresize( $(window), $( "#jqGridList" ), 70 );
	fn_insideGridresize( $(window), $("#divList"), $("#jqGridMasterList"), -440, .47);
	fn_insideGridresize( $(window), $("#divList1"), $("#jqGridDetailList"), -440, .47);
	
	// Search 버튼 클릭 시 Ajax로 리스트를 받아 넣는다.
	$("#btnSearch").click(function(){
		fn_search();
	});
	
	//저장버튼
	$( "#btnSave" ).click( function() {
		fn_save();
	} );
	
	
});

//검색
function fn_search() {
	
	//모두 대문자로 변환
	$("input[type=text]").each(function(){
		$(this).val($(this).val().toUpperCase());
	});
	
	//검색 시 스크롤 깨짐현상 해결
	jqGridMasterObj.closest(".ui-jqgrid-bdiv").scrollLeft(0); 
	
	var sUrl = "admin.indiAuthMgr.indiAuthMgrList.do";
	jqGridMasterObj.jqGrid( "clearGridData" );
	jqGridMasterObj.jqGrid( 'setGridParam', {
		url : sUrl,
		mtype : 'POST',
		datatype : 'json',
		page : 1,
		postData : fn_getFormData( "#application_form" )
	} ).trigger( "reloadGrid" );
	
	//검색 시 스크롤 깨짐현상 해결
	jqGridMasterObj.closest(".ui-jqgrid-bdiv").scrollLeft(0); 
	
	var sUrl = "admin.stanAuthMgr.stanAuthMgrList.do";
	jqGridDetailObj.jqGrid( "clearGridData" );
	jqGridDetailObj.jqGrid( 'setGridParam', {
		url : sUrl,
		mtype : 'POST',
		datatype : 'json',
		page : 1,
		postData : fn_getFormData( "#application_form" )
	} ).trigger( "reloadGrid" );
}

function checkBoxHeader(e, tObj) {
	
	e = e||event;/* get IE event ( not passed ) */
	e.stopPropagation? e.stopPropagation() : e.cancelBubble = true; //이벤트 지우기
	
	var isChk = $("input[id="+tObj.id+"]").is(":checked");
	var cellName = tObj.id.toLowerCase().replace("chk", "");
	
	if(isChk){
		$("#jqGridMasterList").jqGrid('resetSelection');
        var ids = $("#jqGridMasterList").jqGrid('getDataIDs');
        for (var i=0, il=ids.length; i < il; i++) {
        	$("#jqGridMasterList").jqGrid('setCell',ids[i], cellName, "Y");
        }
	} else {
		$("#jqGridMasterList").jqGrid('resetSelection');
        var ids = $("#jqGridMasterList").jqGrid('getDataIDs');
        for (var i=0, il=ids.length; i < il; i++) {
           $("#jqGridMasterList").jqGrid('setCell',ids[i], cellName, "N");
        }
	}
}


//저장
function fn_save() {

	var authValue;
	
	var myGrid = $("#jqGridDetailList");
	var selRadio = $("td[aria-describedby=jqGridDetailList_seq_id] input[type='radio']:radio:checked"), $tr;
    if (selRadio.length > 0) {
        $tr = selRadio.closest('tr');
        if ($tr.length > 0) {
        	authValue = selRadio.val();
        }
        else
        {
        	alert("권한을 선택하십시오.");
        	return;
        }
    } else {
    	alert("권한을 선택하십시오.");
    	return;
    }
    
	$( '#jqGridMasterList' ).saveCell( kRow, idCol );
	var row_id = $("#jqGridMasterList").jqGrid('getGridParam', 'selarrrow');
	
	if(row_id == ""){
		alert("사용자를 선택하십시오.");
		return false;
	}
	
	var userAuthSeq = new Array();
	for(var i=0; i<row_id.length; i++){
		var item = $("#jqGridMasterList").jqGrid( 'getRowData', row_id[i]);
		userAuthSeq.push(item.seq_id);
	}
	
	var url = "admin.indiAuthMgr.indiAuthMgrSave.do?p_userAuthSeq="+encodeURIComponent(userAuthSeq)+"&p_authValue="+authValue;
	var formData = fn_getFormData('#application_form');
	//객체를 합치기. dataList를 기준으로 formData를 합친다.
	
	$.post( url, formData, function( data ) {
		alert(data.resultMsg);
		if ( data.result == 'success' ) {
			fn_search();
		}
	}, "json" ).error( function () {
		alert( "시스템 오류입니다.\n전산담당자에게 문의해주세요." );
	} );
	
}

//afterSaveCell oper 값 지정
function chmResultEditEnd( irowId, cellName, value, irow, iCol ) {
	var item = $( '#jqGridMasterList' ).jqGrid( 'getRowData', irowId );
	if( item.oper != 'I' ){
		item.oper = 'U';
		$( '#jqGridMasterList' ).jqGrid('setCell', irowId, cellName, '', { 'background' : '#6DFF6D' } );
	}
	$( '#jqGridMasterList' ).jqGrid( "setRowData", irowId, item );
	$( "input.editable,select.editable", this ).attr( "editable", "0" );
}
</script>
