package src
//src.SpecialLinkItem
{
    import contents.displayPages.LinkItem;
    import contents.LinkData;
    import appManager.displayContentElemets.TitleText;


    public class SpecialLinkItem extends LinkItem
    {
        private var MyMc:TitleText;

        public function SpecialLinkItem()
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