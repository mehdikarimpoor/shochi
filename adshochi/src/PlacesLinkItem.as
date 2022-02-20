package src
//src.PlacesLinkItem
{
    import contents.displayPages.LinkItem;
    import contents.LinkData;
    import appManager.displayContentElemets.TitleText;


    public class PlacesLinkItem extends LinkItem
    {
        private var MyMc:TitleText;

        public function PlacesLinkItem()
        {
            super(true,false);
            MyMc = Obj.get("myMc",this);
            
        }

        override public function setUp(linkData:LinkData):void{
            this.gotoAndStop(linkData.dynamicData);
            //MyMc.text = linkData.id.toString();
        }
    }
}