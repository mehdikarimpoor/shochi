package src
{//src.Register
	import contents.PageData;
	import contents.interFace.DisplayPageInterface;
	
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import contents.Contents;
	
	public class Register extends MovieClip implements DisplayPageInterface
	{
		public function Register()
		{
			super();
            var rec:Rectangle = new Rectangle(0, 0, Contents.config.pageRect.width, Contents.config.pageRect.height);
            new ScrollMT(this, rec, null, true, false, true, false, false, 0);

		}
		
		public function setUp(pageData:PageData):void
		{
		}
	}
}