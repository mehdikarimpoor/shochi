package  src
{//src.WebViewPage
	
	import appManager.event.AppEventContent;
	
	
	import com.distriqt.extension.nativewebview.*;
	import com.distriqt.extension.nativewebview.events.*;

	import contents.Contents;
	import contents.History;
	import contents.LinkData;
	import contents.PageData;
	import contents.interFace.DisplayPageInterface;
	
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	import stageManager.StageManager;
	import contents.alert.Alert;
	import popForm.PopButton;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	public class WebViewPage extends MovieClip implements DisplayPageInterface
	{
		public static var URLPage:String;

		private const APPLICATION_KEY:String = "" ;

		private var backMC:MovieClip,
					preloaderMC:MovieClip;
					
		private var areaMC:MovieClip;
		private var webView:Object;

		private var _pageData:PageData;
		private var scl:Number = 0;
		private var deltaX:int;
		private var deltaY:int;
		// private var openInWebButton:PopButton ;

		public function WebViewPage()
		{
			super();

            /*openInWebButton = Obj.get("opne_web_mc",this);
			if(openInWebButton)
            {
                openInWebButton.setUp('در مرورگر مشاهده کنید').onClick(openOnBrowser);
                openInWebButton.y += StageManager.stageDelta.height ;
            }*/
			areaMC = Obj.get("area_mc",this);
			preloaderMC = Obj.get("preloader_mc",this);
			// preloaderMC.y = Contents.config.pageRect.height / 2;
			backMC = Obj.get("back_mc",this);
			backMC.buttonMode = true;

			//areaMC.graphics.beginFill(0,0);
			//areaMC.graphics.drawRect(0,0,Contents.config.pageRect.width,Contents.config.pageRect.height);
			trace("StageManager.stageRect : "+Contents.config.pageRect);
		}
		
		/*private function openOnBrowser():void
        {
            // this.dispatchEvent(History.lastPage());
            navigateToURL(new URLRequest(_pageData.content));
        }*/

		public function setUp(pageData:PageData):void
		{
			_pageData = pageData ;

			try
			{
				NativeWebView.init( APPLICATION_KEY );
				if (NativeWebView.isSupported)
				{
					trace("native is support here");
					createViewPort();
					//Hints.show('برنامه در حال بارگزاری اطلاعات می باشد', false, 500000);
					return ;
				}
				else
				{
					trace("You cannot have native web view here");
				}
			}
			catch (e:Error)
			{
				trace("error :"+ e );
				//Hints.show('لطفا از اتصال دستگاه خود به اینترنت مطمئن شوید', false, 5000);
				this.dispatchEvent(History.lastPage());

				/*var linkdata:LinkData = new LinkData();
				linkdata.id = "home";
				linkdata.level = -1;
				this.dispatchEvent(new AppEventContent(linkdata));*/
			}
			//this.addEventListener(Event.ENTER_FRAME,debugStageArea);
		}
		
		protected function debugStageArea(event:Event):void
		{
			var rect:Rectangle = areaRectangle();
			trace("rect : " +rect);
		}
		
		private function createViewPort():void
		{
			trace("Update position");
			var viewPort:Rectangle = areaRectangle();//new Rectangle(0,160,StageManager.stageRect.width,StageManager.stageRect.height);//  -50  -133
			
			var options: WebViewOptions = new WebViewOptions();
			options.allowInlineMediaPlayback = true;
			// options.autoScale=true;
			options.bounces = false;
			options.mediaPlaybackRequiresUserAction = false;
			// options.cachePolicy = CachePolicy.LOAD_DEFAULT;
			//options.useWebKitIfAvailable = true;
			//options.keyboardDisplayRequiresUserAction = f;
			options.backgroundEnabled = false;
			options.backgroundColour = 0xffffff;
			webView = NativeWebView.service.createWebView( viewPort,options ) ;
			
			webView.addEventListener( NativeWebViewEvent.LOCATION_CHANGING, webView_locationChangingHandler );

			webView.addEventListener( NativeWebViewEvent.COMPLETE, webView_completeHandler );
			webView.addEventListener( NativeWebViewEvent.ERROR, webView_errorHandler );
			webView.loadURL( _pageData.content );

			


			this.addEventListener(Event.ENTER_FRAME,reposeWebView);
			this.addEventListener(Event.REMOVED_FROM_STAGE,unLoad);
			
			backMC.addEventListener(MouseEvent.CLICK,goBack);
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN,catchBackButton,false,100000);
		}
		
		protected function goBack(event:MouseEvent):void
		{
			if(webView.canGoBack)
			{
				webView.historyBack();
			}
			else
			{
				this.dispatchEvent(History.lastPage());
			}
		}
		
		protected function catchBackButton(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.BACK || event.keyCode == Keyboard.HOME )
			{
				if(webView.canGoBack)
				{
					event.stopImmediatePropagation();
					event.preventDefault();
					goBack(null);
				}
			}
		}
		
		
		
		protected function unLoad(event:Event):void
		{
			this.removeEventListener(Event.ENTER_FRAME,reposeWebView);
			this.removeEventListener(Event.REMOVED_FROM_STAGE,unLoad);
			
			webView.removeEventListener( NativeWebViewEvent.COMPLETE, webView_completeHandler );
			webView.removeEventListener( NativeWebViewEvent.LOCATION_CHANGING, webView_locationChangingHandler );
			webView.removeEventListener( NativeWebViewEvent.ERROR, webView_errorHandler );
			
			NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN,catchBackButton);
			
			webView.dispose();
			webView = null;
			//Hints.hide();
		}
		
		protected function reposeWebView(event:Event):void
		{
			var rect:Rectangle = areaRectangle();//areaMC.getBounds(stage);
			trace("rect : " +rect);
			webView.width = rect.width;//rect.width
			webView.height =rect.height; //rect.height
			webView.x = rect.x;//rect.x
			webView.y = rect.y;//rect.y
			
			backMC.visible = webView.canGoBack ;

			webView.visible = Obj.isAccesibleByMouse(areaMC) ;//&& !preloaderMC.visible ;
		}
		
		private function areaRectangle():Rectangle
		{
			var rect:Rectangle = Contents.config.pageRect;
			var deltaRect:Rectangle = Contents.config.deltaStageRect ; 
			trace("rect1 : "+rect);
			//trace("****Create view port");
			if(scl==0)
			{
				var sclX:Number = stage.fullScreenWidth/stage.stageWidth ;
				var sclY:Number = stage.fullScreenHeight/stage.stageHeight ;
				trace("Scale detector Y : "+(stage.fullScreenHeight+" vs "+stage.stageHeight));
				trace("Scale detector X : "+(stage.fullScreenWidth+" vs "+stage.stageWidth));
				
				trace("Scale X : "+sclX);
				trace("Scale Y : "+sclY);
				
				scl = Math.min(sclX,sclY) ;
				
				deltaY = deltaRect.height*scl ;
				deltaX = deltaRect.width*scl ;
			}
			trace("scl : "+scl);
			
			//trace("Old rect : " +rect);
			//trace("scl : "+scl);
			//trace("deltaX : "+deltaX);
			//trace("deltaY : "+deltaY);
			
			rect.x*=scl;
			rect.y*=scl;
			//rect.x += deltaX/2;
			//rect.y += deltaY/2;
			rect.width*=scl;
			rect.height*=scl;
			
			rect.x = round(rect.x);
			rect.y = round(rect.y);
			rect.width = round(rect.width);
			rect.height = round(rect.height);
			
			//trace("new rect : " +rect);
			
			if(rect.x<0)
			{
				if(-rect.x<rect.width)
				{
					rect.width += rect.x ;
					rect.x = 0 ;
				}
				else
				{
					rect = null ;
				}
			}
			
			if(rect!=null && rect.y<0)
			{
				if(-rect.y<rect.height)
				{
					rect.height += rect.y ;
					rect.y = 0 ;
				}
				else
				{
					rect = null ;
				}
			}
			
			return rect;
		}
		
		
		private function round(num:Number):Number
		{
			return Math.round(num);
		}
		
		
		private function webView_locationChangingHandler( event:NativeWebViewEvent ):void
		{
			trace( "location change: " + event.data );
			preloaderMC.visible = true ;
			//Hints.show('برنامه در حال بارگزاری اطلاعات می باشد', false, 50000);

		}
		
		private function webView_completeHandler( event:NativeWebViewEvent ):void
		{
			trace( "load complete: " + event.data );
			preloaderMC.visible = false ;
			//Hints.hide();
		}
		
		private function webView_errorHandler( event:NativeWebViewEvent ):void
		{
			trace( "error: " + event.data );
			//Hints.show('لطفا از اتصال دستگاه خود به اینترنت مطمئن شوید', false, 7000);
			this.dispatchEvent(History.lastPage());

			/*var linkdata:LinkData = new LinkData();
			linkdata.id = "home";
			linkdata.level = -1;
			this.dispatchEvent(new AppEventContent(linkdata));*/

		}

	}
}