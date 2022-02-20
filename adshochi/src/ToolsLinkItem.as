package src
//src.ToolsLinkItem
{
    import contents.displayPages.LinkItem;
    import contents.LinkData;
    import appManager.displayContentElemets.TitleText;


    public class ToolsLinkItem extends LinkItem
    {
        private var MyMc:TitleText;

        public function ToolsLinkItem()
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