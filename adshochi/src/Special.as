package src
//src.Special
{
    import flash.display.MovieClip;
    import contents.PageData;
    import contents.LinkData;
    import contents.displayPages.DynamicLinks;

    public class Special extends MovieClip
    {
		private var list:DynamicLinks ;
		private var newLinkData:LinkData;
		private var blueRec_mc: MovieClip;

        public function Special()
        {
            super();
            /*var rec:Rectangle = new Rectangle(0, 0, Contents.config.pageRect.width, Contents.config.pageRect.height-190);
            new ScrollMT(this, rec, null, true, false, true, false, false, 0, true);*/
			list = Obj.get("list_mc",this);
			list.horizontalMenu = true;
			list.setRevertListX = true;
			list.autoScrollSpeed = 0.15;

			var page:PageData = new PageData();
			newLinkData = new LinkData();
			newLinkData.dynamicData = 1;
			page.links1.push(newLinkData);
			
			newLinkData = new LinkData();
			newLinkData.dynamicData = 2;
			page.links1.push(newLinkData);

			newLinkData = new LinkData();
			newLinkData.dynamicData = 3;
			page.links1.push(newLinkData);

			newLinkData = new LinkData();
			newLinkData.dynamicData = 4;
			page.links1.push(newLinkData);

            newLinkData = new LinkData();
			newLinkData.dynamicData = 5;
			page.links1.push(newLinkData);

            newLinkData = new LinkData();
			newLinkData.dynamicData = 6;
			page.links1.push(newLinkData);

			list.setUp(page);

        }
    }
}
