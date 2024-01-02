package utility;

public class Paging_orderDetail {

   private int totalCount = 0 ; 
   private int totalPage = 0 ; 
   private int pageNumber = 0 ; 
   private int pageSize = 0 ;
   private int beginRow = 0 ;
   private int endRow = 0 ;
   private int pageCount = 5 ;
   private int beginPage = 0 ;
   private int endPage = 0 ;
   private int offset = 0 ;
   private int limit = 0 ;
   private String url = "" ;
   private String pagingHtml = "";
   private String whatColumn = "" ;
   private String keyword = "" ; 
   private String startDate = "";
   private String endDate = "";
   private String activeTab = "";

   public int getTotalCount() {
      return totalCount;
   }


   public void setTotalCount(int totalCount) {
      this.totalCount = totalCount;
   }


   public int getTotalPage() {
      return totalPage;
   }


   public void setTotalPage(int totalPage) {
      this.totalPage = totalPage;
   }


   public int getPageNumber() {
      return pageNumber;
   }


   public void setPageNumber(int pageNumber) {
      this.pageNumber = pageNumber;
   }


   public int getPageSize() {
      return pageSize;
   }


   public void setPageSize(int pageSize) {
      this.pageSize = pageSize;
   }


   public int getBeginRow() {
      return beginRow;
   }


   public void setBeginRow(int beginRow) {
      this.beginRow = beginRow;
   }


   public int getEndRow() {
      return endRow;
   }


   public void setEndRow(int endRow) {
      this.endRow = endRow;
   }


   public int getPageCount() {
      return pageCount;
   }


   public void setPageCount(int pageCount) {
      this.pageCount = pageCount;
   }


   public int getBeginPage() {
      return beginPage;
   }


   public void setBeginPage(int beginPage) {
      this.beginPage = beginPage;
   }


   public int getEndPage() {
      return endPage;
   }


   public void setEndPage(int endPage) {
      this.endPage = endPage;
   }


   public int getOffset() {
      return offset;
   }


   public void setOffset(int offset) {
      this.offset = offset;
   }


   public int getLimit() {
      return limit;
   }


   public void setLimit(int limit) {
      this.limit = limit;
   }


   public String getUrl() {
      return url;
   }


   public void setUrl(String url) {
      this.url = url;
   }


   public String getPagingHtml() {
      System.out.println("pagingHtml:"+pagingHtml);
      
      return pagingHtml;

   }


   public void setPagingHtml(String pagingHtml) {
      this.pagingHtml = pagingHtml;
   }

   public String getWhatColumn() {
      return whatColumn;
   }


   public void setWhatColumn(String whatColumn) {
      this.whatColumn = whatColumn;
   }


   public String getKeyword() {
      return keyword;
   }


   public void setKeyword(String keyword) {
      this.keyword = keyword;
   }
   

   public String getStartDate() {
      return startDate;
   }


   public void setStartDate(String startDate) {
      this.startDate = startDate;
   }


   public String getEndDate() {
      return endDate;
   }


   public void setEndDate(String endDate) {
      this.endDate = endDate;
   }
   

   public String getActiveTab() {
	   return activeTab;
   }
	
	
   public void setActiveTab(String activeTab) {
	   this.activeTab = activeTab;
   }


public Paging_orderDetail(
         String _pageNumber, 
         String _pageSize,  
         int totalCount,
         String url, 
         String startDate, 
         String endDate,
         String activeTab) {      

      if(  _pageNumber == null || _pageNumber.equals("null") || _pageNumber.equals("")  ){
         System.out.println("_pageNumber:"+_pageNumber); // null
         _pageNumber = "1" ;
      }
      this.pageNumber = Integer.parseInt( _pageNumber ) ; 

      if( _pageSize == null || _pageSize.equals("null") || _pageSize.equals("") ){
         _pageSize = "2" ; 
      }      
      this.pageSize = Integer.parseInt( _pageSize ) ;
   
      this.limit = pageSize ; 

      this.totalCount = totalCount ; 

      this.totalPage = (int)Math.ceil((double)this.totalCount / this.pageSize) ;
      
      this.beginRow = ( this.pageNumber - 1 )  * this.pageSize  + 1 ;
      this.endRow =  this.pageNumber * this.pageSize ;
      
      if( this.pageNumber > this.totalPage ){
         this.pageNumber = this.totalPage ;
      } 
      
      this.offset = ( pageNumber - 1 ) * pageSize ; 
      
      if( this.endRow > this.totalCount ){
         this.endRow = this.totalCount  ;
      }

      this.beginPage = ( this.pageNumber - 1 ) / this.pageCount * this.pageCount + 1  ;
      this.endPage = this.beginPage + this.pageCount - 1 ;
      
      System.out.println("pageNumber:"+pageNumber+"/totalPage:"+totalPage);   
      
      if( this.endPage > this.totalPage ){
         this.endPage = this.totalPage ;
      }
      
      System.out.println("pageNumber2:"+pageNumber+"/totalPage2:"+totalPage);   
      this.url = url ; //  /ex/list.ab
      this.startDate = startDate;
      this.endDate = endDate;
      this.activeTab = activeTab;
      System.out.println("startDate:"+startDate+"/endDate:"+endDate);
      
      //System.out.println("url2:"+url); //url2:/ex/list.ab
      this.pagingHtml = getPagingHtml(url) ;
   
   }
   
//   private String getPagingHtml( String url ){ 
//      System.out.println("getPagingHtml url:"+url); 
//      
//      String result = "" ;
//      String added_param = "&startDate=" + startDate + "&endDate=" + endDate;
//      
//      if (this.beginPage != 1) {
//         result += "&nbsp;<a href='" + url  
//               + "?pageNumber=" + ( 1 ) + "&pageSize=" + this.pageSize 
//               + added_param + "'>맨 처음</a>&nbsp;" ;
//         result += "&nbsp;<a href='" + url 
//               + "?pageNumber=" + (this.beginPage - 1 ) + "&pageSize=" + this.pageSize 
//               + added_param + "'>이전</a>&nbsp;" ;
//      }
//      
//      
//      for (int i = this.beginPage; i <= this.endPage ; i++) {
//         if ( i == this.pageNumber ) {
//            result += "&nbsp;<font color='red'>" + i + "</font>&nbsp;"   ;
//                  
//         } else {
//            result += "&nbsp;<a href='" + url   
//                  + "?pageNumber=" + i + "&pageSize=" + this.pageSize 
//                  + added_param + "'>" + i + "</a>&nbsp;" ;
//            
//         }
//      }
//      
//      System.out.println("result:"+result); 
//      System.out.println();
//      
//      if ( this.endPage != this.totalPage) { 
//         
//         result += "&nbsp;<a href='" + url  
//               + "?pageNumber=" + (this.endPage + 1 ) + "&pageSize=" + this.pageSize 
//               + added_param + "'>다음</a>&nbsp;" ;
//         
//         result += "&nbsp;<a href='" + url  
//               + "?pageNumber=" + (this.totalPage ) + "&pageSize=" + this.pageSize 
//               + added_param + "'>맨 끝</a>&nbsp;" ;
//      }      
//      System.out.println("result2:"+result);
//      
//      return result ;
//   } 
   
   private String getPagingHtml(String url) { // 페이징 문자열을 만든다.
       System.out.println("getPagingHtml url:" + url);

       String result = "";
       String added_param = "&startDate=" + startDate + "&endDate=" + endDate + "&activeTab=3";

       if (this.beginPage != 1) {
           result += "&nbsp;<li class='page-item'><a class='page-link' href='" + url + "?pageNumber=" + (1) + "&pageSize=" + this.pageSize + added_param
                   + "'>&laquo;</a></li>&nbsp;";
           result += "&nbsp;<li class='page-item'><a class='page-link' href='" + url + "?pageNumber=" + (this.beginPage - 1) + "&pageSize=" + this.pageSize
                   + added_param + "'>&lt;</a></li>&nbsp;";
       }

       // 가운데
       for (int i = this.beginPage; i <= this.endPage; i++) {
           if (i == this.pageNumber) {
               result += "&nbsp;<li class='page-item active'><span class='page-link'>" + i + "</span></li>&nbsp;";

           } else {
               result += "&nbsp;<li class='page-item'><a class='page-link' href='" + url + "?pageNumber=" + i + "&pageSize=" + this.pageSize + added_param
                       + "'>" + i + "</a></li>&nbsp;";

           }
       }

       System.out.println("result:" + result);
       System.out.println();

       if (this.endPage != this.totalPage) {
           result += "&nbsp;<li class='page-item'><a class='page-link' href='" + url + "?pageNumber=" + (this.endPage + 1) + "&pageSize=" + this.pageSize
                   + added_param + "'>&gt;</a></li>&nbsp;";

           result += "&nbsp;<li class='page-item'><a class='page-link' href='" + url + "?pageNumber=" + (this.totalPage) + "&pageSize=" + this.pageSize
                   + added_param + "'>&raquo;</a></li>&nbsp;";
       }
       System.out.println("result2:" + result);

       return "<nav aria-label='Page navigation example'><ul class='pagination'>" + result + "</ul></nav>";
   }
   
}
