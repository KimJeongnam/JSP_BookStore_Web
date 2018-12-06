<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	        var modal = document.getElementById('myModal');
	 
	        // Get the button that opens the modal
	        var btn = document.getElementById("myBtn");
	 
	        // Get the <span> element that closes the modal
	        var span = document.getElementsByClassName("close")[0];                                          
	 
	        // When the user clicks on the button, open the modal 
	        btn.onclick = function(event) {
	            event.preventDefault();
	            modal.style.display = "block";
	        }
	 
	        // When the user clicks on <span> (x), close the modal
	        span.onclick = function() {
	            modal.style.display = "none";
	        }
	 
	        // When the user clicks anywhere outside of the modal, close it
	        window.onclick = function(event) {
	            if (event.target == modal) {
	                modal.style.display = "none";
	            }
	        }
	    
	       var slider = $('.bxslider').bxSlider({
				auto: true, mode:'fade',
			});
			
				// 클릭시 멈춤 현상 해결 //
			$(document).on('click','.bx-next, .bx-prev,  #bx-pager1',function() {
				slider.stopAuto();
				slider.startAuto();
			});	
    