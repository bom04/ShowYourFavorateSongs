
$(function() {

	$("[song-add]").click(function(event) {
		var url = $(this).attr("song-add").split(" ");
		var result=confirm('이 곡을 마이리스트에 추가하시겠습니까?');
		if(result) {
			location.href ="/page/addSong?keyword="+url[1]+"&kara_type="+url[0]+"&song_num="+url[2];
		}
	});

	$("[song-add-chart]").click(function(event) {
		var url = $(this).attr("song-add-chart").split(" ");
		var result=confirm('이 곡을 마이리스트에 추가하시겠습니까?');
		if(result) {
			location.href ="/page/addSong2?kara_type="+url[0]+"&song_id="+url[1];
		}
	});

	$("[song-add-userpage]").click(function(event) {
		var url = $(this).attr("song-add-userpage").split(" ");
		var result=confirm('이 곡을 마이리스트에 추가하시겠습니까?');
		if(result) {
			location.href ="/page/addSong3?user_idx="+url[0]+"&kara_type="+url[1]+"&song_id="+url[2]+"&sort="+url[3]+"&u="+url[4];
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
		if(result) {
			location.href ="/page/follow?user_idx="+url[0]+"&kara_type="+url[1]+"&sort="+url[2]+"&my_user_idx="+url[3];
		}
	});
	$("[delete-follow]").click(function() {
		var url = $(this).attr("delete-follow").split(" ");
		var result= confirm("언팔로우를 하시겠습니까?");
		if(url[3]=='') {
			url[3]=-1;
		}
		if(result) {
			location.href ="/page/unfollow?user_idx="+url[0]+"&kara_type="+url[1]+"&sort="+url[2]+"&my_user_idx="+url[3];
		}
	});
	$("[delete-post]").click(function() {
		var result=confirm("글을 삭제하시겠습니까?");
		if(result) {
			location.href="/page/postDelete?post_id="+$(this).attr("delete-post");
		}
	});
	
	$("[post-modify]").click(function() {
		return confirm("글을 수정하시겠습니까?");
	});
	$("[delete-user]").click(function() {
		var result=confirm("해당 유저를 탈퇴시키겠습니까?");
		if(result) {
			location.href="userDelete?user_idx="+$(this).attr("delete-user");
		}
	});
	$("[delete-comment]").click(function() {
		var result=confirm("댓글을 삭제하시겠습니까?");
		var url = $(this).attr("delete-comment").split(" ");
		if(result) {
			location.href="/page/post/"+url[0]+"/comment/"+url[1]+"/delete";
		}
	});
	$("[delete-reply]").click(function() {
		var result=confirm("답글을 삭제하시겠습니까?");
		var url = $(this).attr("delete-reply").split(" ");
		if(result) {
			location.href="/page/post/"+url[0]+"/comment/"+url[1]+"/"+url[2]+"/delete";
		}
	});

	$("[data-cancel]").click(function() {
		history.back(); // 뒤로가기 기능
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




/* ========================================================================
 * bootstrap.js에서 모달부분만 긁어옴
 * Bootstrap: modal.js v3.3.2
 * http://getbootstrap.com/javascript/#modals
 * ========================================================================
 * Copyright 2011-2015 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 * ======================================================================== */


+function ($) {
	'use strict';

	// MODAL CLASS DEFINITION
	// ======================

	var Modal = function (element, options) {
		this.options        = options
		this.$body          = $(document.body)
		this.$element       = $(element)
		this.$backdrop      =
			this.isShown        = null
			this.scrollbarWidth = 0

			if (this.options.remote) {
				this.$element
				.find('.modal-content')
				.load(this.options.remote, $.proxy(function () {
					this.$element.trigger('loaded.bs.modal')
				}, this))
			}
	}

	Modal.VERSION  = '3.3.2'

		Modal.TRANSITION_DURATION = 300
		Modal.BACKDROP_TRANSITION_DURATION = 150

		Modal.DEFAULTS = {
			backdrop: true,
			keyboard: true,
			show: true
	}

	Modal.prototype.toggle = function (_relatedTarget) {
		return this.isShown ? this.hide() : this.show(_relatedTarget)
	}

	Modal.prototype.show = function (_relatedTarget) {
		var that = this
		var e    = $.Event('show.bs.modal', { relatedTarget: _relatedTarget })

		this.$element.trigger(e)

		if (this.isShown || e.isDefaultPrevented()) return

		this.isShown = true

		this.checkScrollbar()
		this.setScrollbar()
		this.$body.addClass('modal-open')

		this.escape()
		this.resize()

		this.$element.on('click.dismiss.bs.modal', '[data-dismiss="modal"]', $.proxy(this.hide, this))

		this.backdrop(function () {
			var transition = $.support.transition && that.$element.hasClass('fade')

			if (!that.$element.parent().length) {
				that.$element.appendTo(that.$body) // don't move modals dom position
			}

			that.$element
			.show()
			.scrollTop(0)

			if (that.options.backdrop) that.adjustBackdrop()
			that.adjustDialog()

			if (transition) {
				that.$element[0].offsetWidth // force reflow
			}

			that.$element
			.addClass('in')
			.attr('aria-hidden', false)

			that.enforceFocus()

			var e = $.Event('shown.bs.modal', { relatedTarget: _relatedTarget })

			transition ?
					that.$element.find('.modal-dialog') // wait for modal to slide in
					.one('bsTransitionEnd', function () {
						that.$element.trigger('focus').trigger(e)
					})
					.emulateTransitionEnd(Modal.TRANSITION_DURATION) :
						that.$element.trigger('focus').trigger(e)
		})
	}

	Modal.prototype.hide = function (e) {
		if (e) e.preventDefault()

		e = $.Event('hide.bs.modal')

		this.$element.trigger(e)

		if (!this.isShown || e.isDefaultPrevented()) return

		this.isShown = false

		this.escape()
		this.resize()

		$(document).off('focusin.bs.modal')

		this.$element
		.removeClass('in')
		.attr('aria-hidden', true)
		.off('click.dismiss.bs.modal')

		$.support.transition && this.$element.hasClass('fade') ?
				this.$element
				.one('bsTransitionEnd', $.proxy(this.hideModal, this))
				.emulateTransitionEnd(Modal.TRANSITION_DURATION) :
					this.hideModal()
	}

	Modal.prototype.enforceFocus = function () {
		$(document)
		.off('focusin.bs.modal') // guard against infinite focus loop
		.on('focusin.bs.modal', $.proxy(function (e) {
			if (this.$element[0] !== e.target && !this.$element.has(e.target).length) {
				this.$element.trigger('focus')
			}
		}, this))
	}

	Modal.prototype.escape = function () {
		if (this.isShown && this.options.keyboard) {
			this.$element.on('keydown.dismiss.bs.modal', $.proxy(function (e) {
				e.which == 27 && this.hide()
			}, this))
		} else if (!this.isShown) {
			this.$element.off('keydown.dismiss.bs.modal')
		}
	}

	Modal.prototype.resize = function () {
		if (this.isShown) {
			$(window).on('resize.bs.modal', $.proxy(this.handleUpdate, this))
		} else {
			$(window).off('resize.bs.modal')
		}
	}

	Modal.prototype.hideModal = function () {
		var that = this
		this.$element.hide()
		this.backdrop(function () {
			that.$body.removeClass('modal-open')
			that.resetAdjustments()
			that.resetScrollbar()
			that.$element.trigger('hidden.bs.modal')
		})
	}

	Modal.prototype.removeBackdrop = function () {
		this.$backdrop && this.$backdrop.remove()
		this.$backdrop = null
	}

	Modal.prototype.backdrop = function (callback) {
		var that = this
		var animate = this.$element.hasClass('fade') ? 'fade' : ''

			if (this.isShown && this.options.backdrop) {
				var doAnimate = $.support.transition && animate

				this.$backdrop = $('<div class="modal-backdrop ' + animate + '" />')
				.prependTo(this.$element)
				.on('click.dismiss.bs.modal', $.proxy(function (e) {
					if (e.target !== e.currentTarget) return
					this.options.backdrop == 'static'
						? this.$element[0].focus.call(this.$element[0])
								: this.hide.call(this)
				}, this))

				if (doAnimate) this.$backdrop[0].offsetWidth // force reflow

				this.$backdrop.addClass('in')

				if (!callback) return

				doAnimate ?
						this.$backdrop
						.one('bsTransitionEnd', callback)
						.emulateTransitionEnd(Modal.BACKDROP_TRANSITION_DURATION) :
							callback()

			} else if (!this.isShown && this.$backdrop) {
				this.$backdrop.removeClass('in')

				var callbackRemove = function () {
					that.removeBackdrop()
					callback && callback()
				}
				$.support.transition && this.$element.hasClass('fade') ?
						this.$backdrop
						.one('bsTransitionEnd', callbackRemove)
						.emulateTransitionEnd(Modal.BACKDROP_TRANSITION_DURATION) :
							callbackRemove()

			} else if (callback) {
				callback()
			}
	}

	// these following methods are used to handle overflowing modals

	Modal.prototype.handleUpdate = function () {
		if (this.options.backdrop) this.adjustBackdrop()
		this.adjustDialog()
	}

	Modal.prototype.adjustBackdrop = function () {
		this.$backdrop
		.css('height', 0)
		.css('height', this.$element[0].scrollHeight)
	}

	Modal.prototype.adjustDialog = function () {
		var modalIsOverflowing = this.$element[0].scrollHeight > document.documentElement.clientHeight

		this.$element.css({
			paddingLeft:  !this.bodyIsOverflowing && modalIsOverflowing ? this.scrollbarWidth : '',
					paddingRight: this.bodyIsOverflowing && !modalIsOverflowing ? this.scrollbarWidth : ''
		})
	}

	Modal.prototype.resetAdjustments = function () {
		this.$element.css({
			paddingLeft: '',
			paddingRight: ''
		})
	}

	Modal.prototype.checkScrollbar = function () {
		this.bodyIsOverflowing = document.body.scrollHeight > document.documentElement.clientHeight
		this.scrollbarWidth = this.measureScrollbar()
	}

	Modal.prototype.setScrollbar = function () {
		var bodyPad = parseInt((this.$body.css('padding-right') || 0), 10)
		if (this.bodyIsOverflowing) this.$body.css('padding-right', bodyPad + this.scrollbarWidth)
	}

	Modal.prototype.resetScrollbar = function () {
		this.$body.css('padding-right', '')
	}

	Modal.prototype.measureScrollbar = function () { // thx walsh
		var scrollDiv = document.createElement('div')
		scrollDiv.className = 'modal-scrollbar-measure'
			this.$body.append(scrollDiv)
			var scrollbarWidth = scrollDiv.offsetWidth - scrollDiv.clientWidth
			this.$body[0].removeChild(scrollDiv)
			return scrollbarWidth
	}


	// MODAL PLUGIN DEFINITION
	// =======================

	function Plugin(option, _relatedTarget) {
		return this.each(function () {
			var $this   = $(this)
			var data    = $this.data('bs.modal')
			var options = $.extend({}, Modal.DEFAULTS, $this.data(), typeof option == 'object' && option)

			if (!data) $this.data('bs.modal', (data = new Modal(this, options)))
			if (typeof option == 'string') data[option](_relatedTarget)
			else if (options.show) data.show(_relatedTarget)
		})
	}

	var old = $.fn.modal

	$.fn.modal             = Plugin
	$.fn.modal.Constructor = Modal


	// MODAL NO CONFLICT
	// =================

	$.fn.modal.noConflict = function () {
		$.fn.modal = old
		return this
	}


	// MODAL DATA-API
	// ==============

	$(document).on('click.bs.modal.data-api', '[data-toggle="modal"]', function (e) {
		var $this   = $(this)
		var href    = $this.attr('href')
		var $target = $($this.attr('data-target') || (href && href.replace(/.*(?=#[^\s]+$)/, ''))) // strip for ie7
		var option  = $target.data('bs.modal') ? 'toggle' : $.extend({ remote: !/#/.test(href) && href }, $target.data(), $this.data())

				if ($this.is('a')) e.preventDefault()

				$target.one('show.bs.modal', function (showEvent) {
					if (showEvent.isDefaultPrevented()) return // only register focus restorer if modal will actually get shown
					$target.one('hidden.bs.modal', function () {
						$this.is(':visible') && $this.trigger('focus')
					})
				})
				Plugin.call($target, option, this)
	})

}(jQuery);

