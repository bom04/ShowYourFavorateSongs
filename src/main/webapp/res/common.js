
$(function() {

	$("[song-add]").click(function(event) {
		var url = $(this).attr("song-add").split(" ");
		var result=confirm('이 곡을 마이리스트에 추가하시겠습니까?');
		if(result) {
			location.href ="/page/addSong?keyword="+url[1]+"&kara_type="+url[0]+"&song_num="+url[2];
		}
	});
	
	$("[song-delete]").click(function(event) {
		var url = $(this).attr("song-delete").split(" ");
		var result=confirm('이 곡을 마이리스트에서 삭제하시겠습니까?');
		if(result) {
			location.href ="/page/deleteSong?user_idx="+url[0]+"&kara_type="+url[1]+"&sort="+url[2]+"&song_id="+url[3];
		}
	});
	$("[data-follow]").click(function() {
		var url = $(this).attr("data-follow").split(" ");
		var result= confirm("팔로우 하시겠습니까?");
		if(url[3]=='') {
			url[3]=-1;
		}
		alert(url[0]);
		if(result) {
			location.href ="/page/follow?user_idx="+url[0]+"&kara_type="+url[1]+"&sort="+url[2]+"&my_user_idx="+url[3];
		}
	});
	
	
	
	
	
	

	// 밑에서부터는 다시 손봐야됨. 아래부터는 완성이 제대로 안돼 있음
	$("[data-url]").click(function() {
		var url = $(this).attr("data-url");
		location.href = url;
	});

	$("[data-confirm-delete]").click(function() {
		return confirm("삭제하시겠습니까?");
	});
	$("[data-add-list]").click(function() {
		return confirm("마이 리스트에 추가하시겠습니까?");
	});
	$("[data-delete-list]").click(function() {
		return confirm("마이 리스트에서 삭제하시겠습니까?");
	});
	$("[data-add-board]").click(function() {
		return confirm("글을 등록하시겠습니까?");
	});
	$("[data-delete-board]").click(function() {
		return confirm("글을 삭제하시겠습니까?");
	});
	$("[data-modify-board]").click(function() {
		return confirm("글을 수정하시겠습니까?");
	});
	$("[data-cancel-board]").click(function() {
		return confirm("작성을 취소하시겠습니까?");
	});
	$("[data-delete-comment]").click(function() {
		return confirm("댓글을 삭제하시겠습니까?");
	});

	//추가


	$("[data-user-ban]").click(function() {
		return confirm("해당 유저를 영구히 삭제하시겠습니까?");
	});

	$("[data-cancle-profile]").click(function() {
		return confirm("변경 사항을 취소하겠습니까?");
	});

	$("[data-change-profile]").click(function() {
		return confirm("변경 사항을 저장하겠습니까?");
	});


	$("[data-rereply]").click(function() {  //dataurl받아서 
		var url = $(this).attr("data-rereply");
		$("[data-txar]").eq(url).toggle();
	});

	$(document).ready(function(){
		var modalLayer = $("#modalLayer");
		var modalLink = $(".modalLink");
		var modalCont = $(".modalContent");
		var marginLeft = modalCont.outerWidth()/2;
		var marginTop = modalCont.outerHeight()/2; 

		modalLink.click(function(){
			modalLayer.fadeIn("slow");
			modalCont.css({"margin-top" : -marginTop, "margin-left" : -marginLeft});
			$(this).blur();
			$(".modalContent > a").focus(); 
			return false;
		});

		$(".modalContent > button").click(function(){
			modalLayer.fadeOut("slow");
			modalLink.focus();
		});   
	});

})

