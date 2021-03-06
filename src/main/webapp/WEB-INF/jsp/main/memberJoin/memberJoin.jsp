<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>ITMS</title>
<!-- Bootstrap core CSS-->
<link href="/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom fonts for this template-->
<link href="/css/font-awesome/font-awesome.min.css" rel="stylesheet" type="text/css">
<!-- Custom styles for this template-->
<link href="/css/sb-admin.css" rel="stylesheet">
<style type="text/css">
body {
	line-height: 1;
}
/*로그인*/
.body_bg {
	background: url(../images/login/bg.jpg) no-repeat ;
	background-size: cover;
}
.error {
	font-size: 0.8em;
	color: red;
}
</style>
<script src="/js/jquery-1.11.0.min.js"></script>
<script src="/js/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="/js/jquery-easing/jquery.easing.min.js"></script>
<!-- Custom scripts for all pages-->
<script src="/js/sb-admin.min.js"></script>
</head>

<body class="body_bg">
	<div class="container" style="margin-top: 5px;">
		<div class="card card-register mx-auto mt-5">
			<div class="card-header">ITMS 회원가입</div>
			<div class="card-body">
				<form id="login_form" name="login_form">
					<input type="hidden" id="checkedIsUser" name="checkedIsUser" value=""/>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="exampleInputLastName">아이디<span style="color: red;">*</span></label> 
								<input class="form-control" id="p_login_id" name="p_login_id" type="text" alt="아이디" aria-describedby="nameHelp" placeholder="">
							</div>
							<div class="col-md-3">
								<label for="exampleInputName">&nbsp;</label>
								<a class="btn btn-secondary btn-block" href="javascript:userIdCheck();">중복확인</a>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="exampleInputPassword1">패스워드<span style="color: red;">*</span></label> 
								<input class="form-control" id="p_password" name="p_password" type="password" alt="패스워드" placeholder="">
							</div>
							<div class="col-md-6">
								<label for="exampleConfirmPassword">패스워드 확인<span style="color: red;">*</span></label> 
								<input class="form-control" id="p_confirm_password" name="p_confirm_password" type="password" alt="패스워드 확인" placeholder="">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="exampleInputLastName">이름<span style="color: red;">*</span></label> 
								<input class="form-control" id="p_name" name="p_name" type="text" alt="이름" aria-describedby="nameHelp" placeholder="">
							</div>
							<div class="col-md-6">
								<label for="exampleInputName">Email<span style="color: red;">*</span></label> 
								<input class="form-control" id="p_e_mail" name="p_e_mail" type="text" alt="Email" aria-describedby="nameHelp" placeholder="">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="exampleInputName">회사</label> 
								<input class="form-control" id="p_company_name" name="p_company_name" type="text" alt="Email" aria-describedby="nameHelp" placeholder="">
							</div>
							<div class="col-md-6">
								<label for="exampleInputLastName">부서</label> 
								<input class="form-control" id="p_department" name="p_department" type="text" alt="부서" aria-describedby="nameHelp" placeholder="">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="exampleInputName">직급</label> 
								<select class="form-control" id="p_sel_position" name="p_sel_position"></select>
							</div>
							<div class="col-md-6">
								<label for="exampleInputName">담당업무</label>
								<input class="form-control" id="p_business_role" name="p_business_role" type="text" alt="연락처" aria-describedby="nameHelp" placeholder="">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-6">
								<label for="exampleInputName">연락처</label> 
								<input class="form-control" id="p_phone1" name="p_phone1" type="text" alt="Email" aria-describedby="nameHelp" placeholder="">
							</div>
							<div class="col-md-6">
								<label for="exampleInputLastName">회사 연락처</label> 
								<input class="form-control" id="p_tel" name="p_tel" type="text" alt="부서" aria-describedby="nameHelp" placeholder="">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-row">
							<div class="col-md-12">
								<label for="exampleInputName">주소</label> 
								<input class="form-control" id="p_home_address" name="p_home_address" type="text" aria-describedby="p_answer" placeholder="">
							</div>	
						</div>
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">계정보호 질문 / 답변<span style="color: red;">*</span></label> 
						<select class="form-control" id="p_sel_question" name="p_sel_question">
						</select>
						<input class="form-control" style="margin-top: 2px;" id="p_answer" name="p_answer" type="text" aria-describedby="p_answer" placeholder="질문에 대한 답변을 입력...">
					</div>
					<button class="btn btn-primary btn-block" type="submit">아래 약관을 동의하며 회원 가입</button>
				</form>
				<div class="text-center" style="margin-top: 5px;">
                    <a data-toggle="modal" data-target="#userAgreement" style="cursor: pointer;">회원가입약관</a> 
                    <span class="inline-saperator">/</span> 
                    <a data-toggle="modal" data-target="#userPrivacy" style="cursor: pointer;">개인정보취급방침</a>
				</div>
				<br />
				<div class="text-center">
					<a class="small mt-3" href="login.do">로그인</a> / <a class="small" href="main.passwdInit.passwdInit.do">비밀번호 초기화</a>
				</div>
				
				
			</div>
		</div>
	</div>
	
	<!-- Logout Modal-->
	<div class="modal fade" id="userAgreement" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">회원가입약관</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<table style="width: 510px;">
			           <tr>
			             <td align=left>
							<textarea name="tos" rows=20 cols=51>${clause }</textarea>
				         </td>
				       </tr>
				    </table>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Logout Modal-->
	<div class="modal fade" id="userPrivacy" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">개인정보취급방침</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<table style="width: 510px;">
			           <tr>
			             <td align=left>
			               <textarea name="tos" rows=20 cols=51>${policy }</textarea>
		              </td>
		            </tr>
		          </table>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
<!-- Bootstrap core JavaScript-->
<script src="/js/jquery-1.11.0.min.js"></script>
<script src="/js/commonGridUtil.js"></script>
<script src="/js/jqueryAjax.js"></script>
<script src="/js/validate/jquery.validate.min.js"></script>
<script src="/js/validate/additional-methods.min.js"></script>
<script src="/js/validate/localization/messages_ko.min.js"></script>
<script src="/js/jquery.mask.js"></script>
<script type="text/javascript">

$.validator.addMethod('customphone', function (value, element) {
    return this.optional(element) || /^\d{3}-\d{4}-\d{4}$/.test(value);
}, "Please enter a valid phone number");

$(function() {
	
	$("#p_phone1").mask("999-9999-9999");
	$("#p_tel").mask("999-9999-9999");
	
	$("#login_form").validate({
        //validation이 끝난 이후의 submit 직전 추가 작업할 부분
        submitHandler: function() {
        	
        	if($("#checkedIsUser").val() != "Y") 
        	{
        		alert("아이디 중복 확인을 해주세요.");
        		return false;
        	} 
        	else 
        	{
        		if(confirm("회원가입을 완료하겠습니까?"))
        		{
        			$.ajax({
        				type : 'POST',
        				url : 'main.memberJoin.memberJoinRegiste.do',
        				data : $("#login_form").serialize(),
        				dataType : 'json',
        				success : function(data) {
        					alert(data.resultMsg);
        					if (data.result == 'success') {
        						location.href = "/login.do";
        					}
        				},
        				error : function(xhr, status, error) {
        					alert('시스템 오류입니다.\n전산담당자에게 문의해주세요.');
        				}

        			});
                } 
        		else 
        		{
                    return false;
                }
        	}
            
        },
        //규칙
        rules: {
        	p_login_id: {
                required : true,
                minlength : 4
            },
            p_password: {
                required : true,
                minlength : 6
            },
            p_confirm_password: {
                required : true,
                equalTo : "#p_password"
            },
            p_name: {
                required : true,
                minlength : 2
            },
            p_answer: {
            	required : true
            },
            p_phone1: {
            	customphone : true
            },
            p_tel: {
            	customphone : true
            },
            p_e_mail: {
                required : true,
                minlength : 2,
                email : true
            }
        },
        //규칙체크 실패시 출력될 메시지
        messages : {
        	p_login_id: {
                required : "필수 입력항목입니다.",
                minlength : "최소 {0}글자 이상이어야 합니다",
            },
            p_password: {
                required : "필수 입력항목입니다.",
                minlength : "최소 {0}글자 이상이어야 합니다."
            },
            p_confirm_password: {
                required : "필수 입력항목입니다.",
                equalTo : "비밀번호가 일치하지 않습니다."
            },
            p_name: {
                required : "필수 입력항목입니다.",
                minlength : "최소 {0}글자 이상이어야 합니다."
            },
            p_answer: {
            	required : "필수 입력항목입니다."
            },
            p_phone: {
            	customphone : "###-####-#### 형식에 맞게 입력해야 합니다."
            },
            p_tel: {
            	customphone : "###-####-#### 형식에 맞게 입력해야 합니다."
            },
            p_e_mail: {
                required : "필수 입력항목입니다.",
                minlength : "최소 {0}글자 이상이어야 합니다.",
                email : "메일규칙에 어긋납니다."
            }
        }
    });

	// 계정보호 질문 리스트
	getAjaxHtml($("#p_sel_question"), "main.memberJoin.memberQuestionSelectBoxDataList.do?sb_type=not&p_query=getMemberQuestionList", null, null);
	
	// 직급 리스트
	getAjaxHtml($("#p_sel_position"), "main.memberJoin.memberPositionSelectBoxDataList.do?sb_type=not&p_query=getMemberPositionList", null, null);
	
});

function userIdCheck() {

	$.ajax({
		type : 'POST',
		url : 'main.memberJoin.userIdCheck.do',
		data : $("#login_form").serialize(),
		dataType : 'json',
		success : function(data) {
			alert(data.resultMsg);
			if(data.result == 'success') {
				$("#checkedIsUser").val("Y");
			}
		},
		error : function(xhr, status, error) {
			alert('시스템 오류입니다.\n전산담당자에게 문의해주세요.');
		}
	});
            
}
</script>
</body>

</html>
