package
{
	import appManager.event.AppEventContent;
	import appManager.mains.AppWithContent;
	
	import contents.Contents;
	import contents.ContentsEvent;
	import contents.LinkData;
	import contents.displayElements.SoundButton;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.preloaders.Preloader;
	
	import myAsCSS.MyAsCSS;
	
	import popForm.Hints;
	
	import sliderMenu.SliderManager;
	
	import stageManager.StageManager;
	
	import webService.myWebService;
	
	public class adshochi extends AppWithContent
	{
		public function adshochi()
			
		{
			
			super(false,false,false,false,false,true,true);
			playMusic(null)
			//Hints.setPreLoader(new Preloader())

			//myWebService.setUp();
			Unicode.estesna  = '-[]»«)(":' ;
			
			SliderManager.setMenu(Obj.get("sliderMenu_mc",this),276,"leftMenu",true);
			//SliderManager.lock();
			SliderManager.doNotActOnThisObject(Obj.get("frame_mc",this));
			
			//
			StageManager.add("pages_mc_css",0,-1,false,false);
			StageManager.add("homePanel_CSS",0,-1,false,false);
			StageManager.add("footer",0,1,false,false);
			StageManager.add("scroll_mc",0,-1,false,false);
			StageManager.add("header_css",0,-1,false,false);
			StageManager.add("main_css",0,-1,false,false);
			StageManager.add("top_left_menu_css",0,-1,false,false);
	    	StageManager.add("map_CSS",0,1,false,false);
			StageManager.add("BG_mc_css",0,1,false,false);
			StageManager.add("adam_mc",0,1,false,false);
			StageManager.add("title_mc",0,-1,false,false);
			StageManager.add("sait_mc",0,1,false,false);
			StageManager.add("background_mc",0,1,false,false);

			//MyAsCSS.managePlace("footer",true);
			//MyAsCSS.managePlace("homePanel_CSS",true);
			
			
			//MyAsCSS.managePlace("header_CSS",true);
			//MyAsCSS.managePlace("top_left_menu_css",true);
			
			
			//MyAsCSS.managePlace("picInterNal_CSS",true,true,false,true);
			//SliderManager.setMenu(Obj.get("sliderMenu_mc",this),276);
			//SliderManager.lock();
			//var test:MovieClip = Obj.get("test",this)
			//test.mouseEnabled = false
			//test.mouseChildren = false
			//test.visible= false
			
			
		}
		
		/**music is started*/
		protected function playMusic(event:Event):void
		{
			// TODO Auto-generated method stub
			//SoundButton.setUp(stage);
			
			//	var home_detect:LinkData=new LinkData()
			//		home_detect.id="about"
			//	home_detect.level=0
			//		this.dispatchEvent(new AppEventContent(home_detect))	
			
		}
		
		
		override protected function backToHomePage():void
		{
			SliderManager.hide();
			//SliderManager.lock();
			super.backToHomePage();
		}
		
		override protected function showExternalPages():void
		{
			SliderManager.unLock();
			SliderManager.hide();
			super.showExternalPages();
		}
		/*	private function minimized_fun(evt:MouseEvent):void
		{
		MultiMediaManager.minimizeApp()
		}*/
	}
}