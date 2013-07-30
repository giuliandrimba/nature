(function($)
{
	/*
	 * Author: Giulian Drimba
	 * 
	*/
	
	$.fn.spritefy = function(animation_name,p_options)
	{
		var options = p_options;
		var el = this;

		resetElement();
		el.removeClass();
		el.addClass(animation_name);

		applyBaseCSS();
		applyOptions();

		var api = {}

		api.play = function()
		{
			api.status = "playing";
			applyCSS("animation-play-state","running");

			return api;
		}

		api.pause = function()
		{
			api.status = "paused";
			applyCSS("animation-play-state","paused");

			return api;
		}

		el.bind("animationstart", onAnimation);  
		el.bind("webkitAnimationStart", onAnimation);


		el.bind("animationend", onAnimation);  
		el.bind("webkitAnimationEnd", onAnimation);

		el.bind("animationiteration", onAnimation);
		el.bind("webkitAnimationIteration", onAnimation);

		function onAnimation(e) 
		{  
			switch(e.type) 
			{
		    	case "animationstart":
		    		triggerStart();
		    			break; 
		    	case "webkitAnimationStart":
		    		triggerStart();
		    		break;  
		    	case "animationend": 
		    		triggerComplete();
		    		break;
		    	case "webkitAnimationEnd":
		      		triggerComplete();
		      		break;  
		    	case "animationiteration":  
			    	triggerIteration();
			      		break;
		    	case "webkitAnimationIteration":
		      		triggerIteration();
		      		break;  
		  	}  
		} 

		function triggerComplete()
		{
			el.removeAttr("style");
			if(options.onComplete)
			{
				options.onComplete();
			}
		}

		function triggerIteration(time)
		{
			if(options.onIteration)
				options.onIteration();
		}

		function triggerStart()
		{
			if(options.onStart)
				options.onStart();
		}

		function applyOptions()
		{
			if(options.duration)
			{
				applyCSS("animation-duration",options.duration.toString()+"s");
			}

			if(options.delay)
			{
				applyCSS("animation-delay",options.delay.toString()+"s");
			}

			if(options.count)
			{
				applyCSS("animation-iteration-count",options.count.toString());
			}
		}

		function applyBaseCSS()
		{

			applyCSS("animation-name", animation_name);
			applyCSS("animation-timing-function","step-end");
			applyCSS("animation-iteration-count","infinite");
			applyCSS("animation-fill-mode","backwards");
		}

		function applyCSS(property, value)
		{
			el.css("-webkit-"+property,value);
			el.css("-moz-"+property,value);
		}

		function resetElement()
		{
			el.removeClass(animation_name);

			el.unbind("animationstart");
			el.unbind("webkitAnimationStart");
			el.unbind("animationend");  
			el.unbind("webkitAnimationEnd"); 
			el.unbind("animationiteration");
			el.unbind("webkitAnimationIteration");
		}

		$.fn.animation = api;

		api.pause();

		return api;
	}

})(jQuery)