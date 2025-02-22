<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>아나바다 중고장터</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="../resources/assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="../resources/css/styles.css" rel="stylesheet" />
<style type="text/css">
.rach input[type='radio'] {
	display: none;
}

.rach input[type='radio']+span {
	display: inline-block;
	padding: 5px 5px;
	border: 1px solid #AEB6BF;
	border-radius: 10px;
	background-color: white;
	text-align: center;
	cursor: pointer;
}

.rach input[type='radio']:checked+span {
	background-color: #AEB6BF;
	color: white;
	border-radius: 10px;
}

.word {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
/*글자 자르게*/
.sideword {
	width: 110px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

/*레이아웃 */
#wapper {
	width: 1200px;
	margin: auto;
	height: auto;
}

.nav, .aside, .section {
	margin: 3px; /*간격*/
}

.nav, .section, .aside {
	float: left;
}

.nav {
	width: 70px;
}

.section {
	/* background-color: #f9f9f9;    */
	width: 1000px;
	border: 0px;
	border-collapse: collapse;
}

.aside {
	
}

.sideBanner {
	width: 120px;
	position: absolute;
	max-height: 490px;
	min-height: 200px;
	top: 100px;
	background-color: white;
	border: 1px solid #E2E2E2;
	text-align: center;
	margin-left: 10px;
	margin-top: 10px;
}

.recent_list {
	height: 405px;
	overflow: hidden;
}

/*최근 본 알바 ul*/
#recentItemList {
	list-style: none;
	float: left;
	text-align: center;
}

#recentItemList li {
	height: 130px;
	display: inline-block;
	text-align: center;
	margin-bottom: 5px;
}

ul {
	list-style: none;
	margin: 0px;
	padding: 0px;
}

.searchDIV {
	margin: auto;
	margin-top: 10px;
	width: 650px;
}

.searchTable {
	text-align: center;
	width: 600px;
	margin: auto;
	margin-top: 40px;
}

   .recent_btn{
   	   all: unset; 
   	   cursor: pointer;
   }
.rachb input[type='radio'] {
   display: none;
}

.rachb input[type='radio']:checked+span {
   font-weight: 600;
}

.rachb input[type='radio']+span {
   text-align: center;
   cursor: pointer;
}

.pro-select {
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  border: 0;
  color: #A5A5A5;
  font-size: 12px;
  font-weight: 350;
  background: url('../resources/images/pro_down.png') no-repeat 95% 50%;
}

.pro-input {
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  margin: auto;
  border: 0;
  font-size: 13px;
  padding: 0 5px;
  box-sizing: border-box;
}

.pro-search {
  all: unset;
}




</style>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	$(function() {
		

		
		//게시글 유효성 검사 
		$(".postExistence").click(function() {
			
			
			
			var url = $(this).attr('title');
			var pno =$(this).attr('pno');
			
			$.ajax({
				type:"get",
				url : "/product/postExistence",
			     data : {pno : pno},
				 traditional : true,
				 success : function(res){
					 if(res == 0){
						 alert("이미 삭제된 게시글 입니다.");
						 location.reload();
					 }else{
						 location.href=url;
					 }
				 },
				 error :function (request,status, error){
					 alert("이동 실패 : "+error);
				 }
			
				
			}) // ajax end
			
			
		
			
			
			
			
		});
		
		
		
		
		

		// 검색어 입력하고 검색 눌렀을떄 
		$('.searchBtn').on(
				"click",
				function() {
				

					var chbtn = $("input[type='radio']:checked").val();
				

					self.location = "list" + '${pageMaker.makeQuery(1)}'
							+ '&searchType='
							+ $("select option:selected").val() + "&keyword="
							+ encodeURIComponent($('#keywordInput').val())
							+ "&productType=" + encodeURIComponent(chbtn);
				});

		// 카테고리 버튼 클릭 이벤트 
		$("input[type='radio']").click(
				function() {

					var chbtn = $("input[type='radio']:checked").val();

					self.location = "list" + '${pageMaker.makeQuery(1)}'
							+ '&searchType='
							+ $("select option:selected").val() + "&keyword="
							+ encodeURIComponent($('#keywordInput').val())
							+ "&productType=" + encodeURIComponent(chbtn);

				})

		//내글쓰기 버튼 눌렀을때 
		$('#writebtn').on("click", function() {

			if ("${id}" == "") {
				alert('회원 전용 서비스입니다. 로그인 후 이용하세요 ');
				return;
			} else if("${id}"=="admin"){
				alert("관리자 모드입니다.");
				return;
			}
			
			else  {

				location.href = "/product/writeView";
			}

		})

		//최근본 목록
		// 최근 본 알바 플로팅배너
		// 기본 위치(top)값
		//outerHeight() : 선택한 요소의 세로값 (패딩포함)을 가져오거나 설정한다. 
		var floatPosition = parseInt($(".sideBanner").css('top')); //100
		var floatHei = parseInt($(".sideBanner").outerHeight()); // 플로팅 배너 길이 450
		var footerTop = $('#footer').outerHeight(); // footer가 위치한 높이 
        var headTop = $('#headLine').outerHeight();
	
		// scroll 인식
		$(window).scroll(function() {

			// 현재 스크롤 위치
			var currentTop = $(window).scrollTop(); // 현재 top위치 
			var bannerTop = currentTop + floatPosition + "px";
			var val = $(document).height() - footerTop;
			var hei = currentTop + floatPosition + floatHei;

			//이동 애니메이션
			if (hei < footerTop) {

				$(".sideBanner").stop().animate({
					"top" : bannerTop
				}, 500);
			}
			if (currentTop < headTop) {
				$(".sideBanner").stop().animate({
					"top" : headTop
				}, 500);

			}

		}).scroll();

		function get_recent_item() {

			//sessionStorage.clear(); 
			var $recentItemList = $("#recentItemList");

			var items = sessionStorage.getItem("recent_product");

			if (items == null) {
				var li = "<br><br><br><br><li>최근 본 상품이 없습니다.</li>"
				$recentItemList.append(li);
			}

			//alert(key)

			  var realitem = JSON.parse(items);


			var recent_array = new Array();
			//최근 본 게시물 유효성 검사 
			for (var j = 0; j < 6; j++) {

				//최근 본 목록의 pno를 배열에 담아서 에이젝스로 유효성 검사 넘김
				if (JSON.stringify(realitem[j]) != null) {
					var recent = JSON.stringify(realitem[j].pno);
					recent_array.push(recent);
					//alert(recent_array);
				}
			}
			$.ajax({

				type : "get",
				url : "/product/recent_chk",
				data:{
					recent_array : recent_array,
				},
				 traditional : true,

	              success: function(data){
                      
	                  //파싱된 객체의 길이로 for문 돌리기
	                  for (var i = 0; i < 6; i++) {
	                      
	                      if(data.includes(realitem[i].pno)){
	                           var pno = realitem[i].pno;
	                          var p_title = realitem[i].p_title;
	                          var p_img = realitem[i].p_img;

	                                 
	                                   if(p_img == "" || p_img == null){
	                                	   var li = "<li  ><a href='/product/readView?pno="
	   	          							+ pno
	   	          							+ "'><img style='border-radius: 5px;' width='100' height='100' src='../resources/images/img.png'/>"
	   	          							+ "<br><div class='sideword' >" + p_title + "</div>"
	   	          							+ "</a></li>";
	                                   }else{
	                                	   var li = "<li  ><a href='/product/readView?pno="
	   	          							+ pno
	   	          							+ "'><img style='border-radius: 5px;' width='100' height='100' src='"+p_img+"'/>"
	   	          							+ "<br><div class='sideword' >" + p_title + "</div>"
	   	          							+ "</a></li>";
	                                   }
	                                   
	                                   
	                        /*   if (p_img != null || p_img !== "") {
	                        	  alert(123);
	          					var li = "<li  ><a href='/product/readView?pno="
	          							+ pno
	          							+ "'><img width='100' height='100' src='"+p_img+"'/>"
	          							+ "<br><div class='sideword' >" + p_title + "</div>"
	          							+ "</a></li>";
	          				}
	                          else {
	          					var li = "<li  ><a href='/product/readView?pno="
	          							+ pno
	          							+ "'><img width='100' height='100' src='../resources/images/아나바다.png'/>"
	          							+ "<br><div class='sideword' >" + pno + p_title + "</div>"
	          							+ "</a></li>";
	          				} */
	                      //ul에 붙이기
	                      $recentItemList.append(li);
	                      }
	                 }
	            	  
	            	  
	              },
	              error : function (request, status, error) {
					alert("실패 : "+error);
				}
				

			});
		}

		

		$(".recent_btn").click(function() {

			var ih = $(this).index() == 0 ? -130 : 130; //위아래로 움직이는 px 숫자
			//var ih = $(this).index() == 0 ? -405 : 405; //위아래로 움직이는 px 숫자
			// 위로 : 0 아래로 : 1 

			var obj = $('.recent_list');

			obj.animate({
				scrollTop : obj.scrollTop() + ih
			}, 100);
		});

		// 이거 젤 마지막에 둬야 함
		get_recent_item();
		//최근본 목록 끝 
		
		
	
		

	});
	

</script>

</head>
<body>

<div id="headLine">
	<div id="anbdHead">
		<div>
			<jsp:include page="../includes/nav.jsp" />
		</div>
		<div>
			<jsp:include page="../includes/header.jsp" />
		</div>
	</div>




<div style="min-width: 1200px; width: 100%; border-bottom: 1px solid #f1f2f5;"></div>
      <div class="container pro-navbar">
         <ul class="profile-pro" style="float: left;">
            <li class="pro-li"><label class="rachb"><input type="radio" id="con" name="p_type" value="" <c:out value="${ empty scri.productType ? 'checked' :''} "/> /><span>전체</span></label></li>
            <li class="pro-li"><label class="rachb"><input type="radio" id="con" name="p_type" value="전자기기" <c:out value="${scri.productType eq '전자기기' ? 'checked' :''} "/> /><span>전자기기</span></label></li>
            <li class="pro-li"><label class="rachb"><input type="radio" id="con" name="p_type" value="상품권/쿠폰" <c:out value="${scri.productType eq '상품권/쿠폰' ? 'checked' :''} "/> /><span>상품권/쿠폰</span></label></li>
            <li class="pro-li"><label class="rachb"><input type="radio" id="con" name="p_type" value="남성의류" <c:out value="${scri.productType eq '남성의류' ? 'checked' :''} "/> /><span>남성의류</span></label></li>
            <li class="pro-li"><label class="rachb"><input type="radio" id="con" name="p_type" value="여성의류" <c:out value="${scri.productType eq '여성의류' ? 'checked' :''} "/> /><span>여성의류</span></label></li>
            <li class="pro-li"><label class="rachb"><input type="radio" id="con" name="p_type" value="아동용품" <c:out value="${scri.searchType eq '아동용품' ? 'checked' :''} "/> /><span>아동용품</span></label></li>
            <li class="pro-li"><label class="rachb"><input type="radio" id="con" name="p_type" value="가구" <c:out value="${scri.searchType eq '가구' ? 'checked' :''} "/> /><span>가구</span></label></li>
            <li class="pro-li"><label class="rachb"><input type="radio" id="con" name="p_type" value="신발" <c:out value="${scri.searchType eq '신발' ? 'checked' :''} "/> /><span>신발</span></label></li>
            <li class="pro-li"><label class="rachb"><input type="radio" id="con" name="p_type" value="가방" <c:out value="${scri.searchType eq '가방' ? 'checked' :''} "/> /><span>가방</span></label></li>
            <li class="pro-li"><label class="rachb"><input type="radio" id="con" name="p_type" value="기타" <c:out value="${scri.searchType eq '기타' ? 'checked' :''} "/> /><span>기타</span></label></li>
         </ul>
         
         <div style="float: right; margin-right: 5px; border: 1px solid #f1f2f5; padding: 3px; box-sizing: border-box;">
            <table>
               <tr>
                  <td style="padding: 0 5px; border-right: 1px solid #f1f2f5;">
                     <select name="searchType" class="pro-select" style="padding: 0 15px 0 3px; box-sizing: border-box; vertical-align: 13%; text-align: center;">
                        <option value="t" <c:out value="${scri.searchType eq 't' ? 'selected' :''} "/>>제목</option>
                        <option value="c" <c:out value="${scri.searchType eq 'c' ? 'selected' :''} "/>>내용</option>
                        <option value="w" <c:out value="${scri.searchType eq 'w' ? 'selected' :''} "/>>작성자&nbsp;</option>
                     </select>
                  </td>
                  
                  <td>
                     <input class="pro-input" type="text" name="keyWord" id="keywordInput" style="margin: 0 5px; vertical-align: 15%;" value="${scri.keyword }">
                     <button class="searchBtn pro-search" type="button" style="vertical-align: 10%; margin: 0 5px; vertical-align: 15%;"><img src="<c:url value='/images/pro_search.png'/>" style="width: 15px; height: 15px;"></button>
                  </td>
               </tr>
            </table>
         </div>
         
      </div>

   <div style="clear: both;"></div>   
   
   <div  style="min-width: 1200px; width: 100%; border-bottom: 1px solid #f1f2f5;"></div>

</div>












	<!-- 검색 기능 부분  -->
	<form role="form" method="get">
		<div id="wapper">
			<section class="nav"></section>
			<section class="section" >

		

			
			
			
			
			

				<!-- 내용 박스 부분 -->
				<section class="py-5">
					<div class="container px-4 px-lg-5 mt-5">
					                  <button id="writebtn" type="button" style="float: right; margin-bottom: 10px;">내글쓰기</button>
                  <div style="clear: both;"></div>
					
						<div style="width: 1000px;" class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">

							<c:forEach items="${list }" var="list">
								<!-- test -->
								<div class="col mb-5 postExistence" id="postExistence"  pno="${list.pno }"     title="/product/readView?pno=${list.pno}&p_type=${list.p_type}&page=${scri.page }&perPageNum=${scri.perPageNum }&searchType=${scri.searchType }&keyword=${scri.keyword }&productType=${scri.productType}" >
									
									
									<div class="card h-100">
										<!-- Product image-->
										<div style="height: 267px;">
											<img class="card-img-top" height="265px;" src="${list.p_filepath }" />
										</div>
										<!-- Product details-->
										<div class="card-body p-4">
											<div class="text-center">
												<!-- Product name-->

												<div class="word">
													<h5 class="fw-bolder">${list.p_title }</h5>
												</div>


												<!-- Product price-->
												₩ ${list.p_cost}
												<div style="margin-top: 10px;">
													<fmt:formatDate pattern="yyyy.MM.dd" value="${list.p_regdate }" />

												</div>
											</div>
										</div>
										<!-- Product actions-->
										<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
											<div class="text-center">
												<a class="btn btn-outline-dark mt-auto" href="#"> 살펴보기</a>
											</div>
										</div>
									</div>
								</div>

							</c:forEach>
















						</div>
					</div>

					<!-- 페이징 처리 부분 -->
					<nav style="margin-left: 50%">
						<ul class="pagination">
							<li class="page-item"><c:if test="${pageMaker.prev }">
									<a class="page-link" href="list${pageMaker.makeSearch(pageMaker.startPage - 1 )}" aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
									</a></li>
							</c:if>
							<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
								<li class="page-item" <c:out value="${pageMaker.cri.page == idx ? 'class=info' : '' }"/>><a class="page-link" href="list${pageMaker.makeSearch(idx)}">${idx }</a></li>
							</c:forEach>


							<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
								<li class="page-item"><a class="page-link" href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}" aria-label="Next"> <span aria-hidden="true">&raquo;</span>
								</a></li>
							</c:if>
						</ul>
					</nav>


				</section>
			</section>
			<!-- 사이드바 - 최근본 상품 목록 -->
			<section class="aside">
				<div class="sideBanner" style="padding-top: 10px; padding-bottom: 10px;">
					최근 본 상품
					<div class="r_btn">
						<button class="recent_btn" style="padding: 5px;"><img src="../resources/images/up.png" width="10px;" height="10px;"></button>
          				<button class="recent_btn" style="padding: 5px;"><img src="../resources/images/down.png" width="10px;" height="10px;"></button>
					</div>
					<div class="recent_list ">
						<ul id="recentItemList" style="margin-left: 5px; margin-right: 5px;">
						</ul>
					</div>
				</div>
			</section>
			<!-- 최근본 상품 끝  -->
		</div>
	</form>
	<!-- Footer-->
	<div id="footer">

		<div id="footer">
			<jsp:include page="../includes/footer.jsp" />
		</div>
	</div>
	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="../resources/js/scripts.js"></script>
</body>
</html>
