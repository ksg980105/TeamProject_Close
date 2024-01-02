<%@page import="product.model.ProductBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../main/top.jsp"%>

<style type="text/css">
	#shopNav {
        font-size: 15pt;
        font-weight: 700;
        padding-top: 3px;
	}
	.plist{
		display: flex;
        flex-direction: row;
        margin-bottom: 50px;
	} 
	.filter .product{ 
		float: left;
	} 
	.filter{
		width:150px; 
		margin: 0 0 0 auto;
	}
	.product{ 
	}
	.small-category{
        display: none; /* 초기에는 하위 항목을 숨김 */
    }
    #small-brand{
    	display: none;
    }
    .categories{
    	list-style: none;
    }
    .category{
    	text-decoration: none;
    	color:black;
    }
    #sort a {
    	text-decoration: none;
    	color:black;
    	cursor: pointer;
    }  
    .page-link {
	  color: #000; 
	  background-color: #fff;
	  border: 1px solid #ccc; 
	}
	.page-item.active .page-link {
	 z-index: 1;
	 color: #555;
	 font-weight:bold;
	 background-color: #f1f1f1;
	 border-color: #ccc;
	 
	}
	.page-link:focus, .page-link:hover {
	  color: #000;
	  background-color: #fafafa; 
	  border-color: #ccc;
	}
</style>
<script type="text/javascript">
/* function toggleSmallCategories(bigCategoryName) {
    var smallCategories = document.querySelectorAll('.small-category');

    smallCategories.forEach(function (smallCategory) {
        if (smallCategory.id === 'small-' + bigCategoryName) {
            smallCategory.style.display = (smallCategory.style.display === 'none' || smallCategory.style.display === '') ? 'block' : 'none';
        } else {
            smallCategory.style.display = 'none';
        }
    });
} */
$(document).ready(function(){
	$(".big-category").click(function(){
		var bigCategoryId = $(this).attr("id");
        // Toggle the submenu when the menu item is clicked
        $(".small-category").not("#small-" + bigCategoryId).slideUp();
        $(this).siblings("#small-" + bigCategoryId).stop().slideToggle();
    });
});
function sort(sortType){
	   
	   var urlParams = new URLSearchParams(window.location.search);
	   var bigcategory = urlParams.get("bigcategory_name");
	   var smallcategory = urlParams.get("smallcategory_name");
	   var keyword = urlParams.get("searchWord");
	   var brand = urlParams.get("brand");
	   location.href="list.product?bigcategory_name="+bigcategory+"&smallcategory_name="+smallcategory+"&brand="+brand+"&sort="+sortType+"&searchWord="+keyword+"&whatColumn=product_name";
	}
	function sfilter(smallcategory){
	   
	   var urlParams = new URLSearchParams(window.location.search);
	   var bigcategory = urlParams.get("bigcategory_name");
	   var keyword = urlParams.get("searchWord");
	   var brand = urlParams.get("brand");
	   location.href="list.product?bigcategory_name="+bigcategory+"&smallcategory_name="+smallcategory+"&brand="+brand+"&searchWord="+keyword+"&whatColumn=product_name";
	}
	function bfilter(bigcategory){
	   
	   var urlParams = new URLSearchParams(window.location.search);
	   var smallcategory = urlParams.get("smallcategory_name");
	   var keyword = urlParams.get("searchWord");
	   var brand = urlParams.get("brand");
	   location.href="list.product?bigcategory_name="+bigcategory+"&smallcategory_name="+smallcategory+"&brand="+brand+"&searchWord="+keyword+"&whatColumn=product_name";
	}
</script>

<div class="body">
	
	<div class="row">
		<div class="col-lg-2"></div>
		<div class="col-lg-8">
			<div style="margin-bottom:50; border-bottom: 3px solid;">
				<h3 style="padding: 10 0 10 0">상품목록</h3>
			</div>
		</div>
		<div class="col-lg-2"></div>   
		<div class="col-lg-2">
			<div class="filter"> 
				<ul class="categories">
			        <c:set var="previousBigCategory" value="" />
			        <c:forEach var="category" items="${clists}">
			            <c:if test="${!category.bigcategory_name.equals(previousBigCategory)}">
			                <li class="big-category" id="${category.bigcategory_name}">
			                    <h2 class="bc">${category.bigcategory_name}</h2>
			                </li>
			                <li class="small-category" id="small-${category.bigcategory_name}">
			            		<a class="category" onclick="bfilter('${category.bigcategory_name}')">전체</a>
			            	</li>
			            </c:if>
			            
			            	<li class="small-category" id="small-${category.bigcategory_name}">
			            		<a  class="category" onclick="sfilter('${category.smallcategory_name}')">${category.smallcategory_name}</a>
			            	</li>
			            
			            <c:set var="previousBigCategory" value="${category.bigcategory_name}" />
			        </c:forEach>
			        <%-- <li class="big-category" id="brand">
			        	<h2 class="bc">브랜드</h2>
			        </li>
			        <c:forEach var="pb" items="${blists }">
			         <c:if test="${!fn:substringBefore(pb.product_name,'/').equals(previousBrand)}">
			        	<li id="small-brand">
			        		<a class="category" href="list.product?brand=${fn:substringBefore(pb.product_name,'/') }">
			        			${fn:substringBefore(pb.product_name,'/') }
			        		</a>
			        	</li>
			         </c:if>
			        	<c:set var="previousBrand" value="${fn:substringBefore(pb.product_name,'/') }" />
			        </c:forEach> --%>
			    </ul>
			</div>
		</div>
		
		<div class="col-lg-8">
			<div style="padding:20 10 5 10">
					<table id="sort" style="border-collapse: collapse; margin-top: -30px; margin-bottom: 10px;">
						<tr>
							<td>
								<a class="array" onclick="sort('new')">신상품순</a> | 
								<a class="array" onclick="sort('low')">낮은 가격순</a> | 
								<a class="array" onclick="sort('high')">높은 가격순</a> | 
								<a class="array" onclick="sort('sale')">판매순</a> | 
								<a class="array" onclick="sort('rating')">별점순</a>
							</td>
						</tr>
					</table>
				<div class="plist">
					
						  <c:choose>
						    <c:when test="${empty plists}">
						      <div class="col-lg-12" align="center" style="padding: 10px; font-size: 30px;">
						        <span class="nog">등록된 제품이 없습니다.</span>
						      </div>
						    </c:when>
						    <c:otherwise>
					<div class="product">
						<table>
						      <c:forEach var="pb" items="${plists}" varStatus="Status">
						        <c:set var="count" value="${Status.count}" />
						        <td align="left" valign="top" width="300px" style="padding:0 40px 0 0">
						          <div style=" height: 250px;">  
						           <a href="detail.product?product_number=${pb.product_number }">
						          	<img id="preview" width="100%" height="100%"
									src='<%=request.getContextPath()%>/resources/productImage/${pb.image}' /> 
						           </a> 
						          </div>  
						          <hr>
						          <div><b>${fn:substringBefore(pb.product_name,'/') }</b></div>
						          <div>${fn:substringAfter(pb.product_name,'/') }</div> 
						          <font color="#f0e68c">★</font>
						          <c:if test="${pb.average_rating == 0 }">
						          	-
						          </c:if>
						          <c:if test="${pb.average_rating != 0 }">
						          	<fmt:formatNumber value="${pb.average_rating }" pattern=".0"/>
						          </c:if>
						          <div>
						          	<fmt:formatNumber value="${pb.price }" pattern="#,###" />원
						          </div>
						        </td>
						        <c:if test="${count % 4 == 0}">
						          </tr><tr>
						        </c:if>
						      </c:forEach>
							</table>
							</div>
						    </c:otherwise>
						  </c:choose>
				</div>
				<div class="row">
				    <div class="col-lg-12 text-center">
				        <div class="d-flex justify-content-center">
				            ${pageInfo.pagingHtml}
				        </div>
				    </div>
				</div>
			</div>
		</div>




	</div>
</div>

<%@ include file="../main/bottom.jsp"%>