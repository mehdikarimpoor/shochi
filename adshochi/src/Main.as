package src
//src.Main
{
    import flash.display.MovieClip;
    import flash.geom.Rectangle;
    import contents.Contents;

    public class Main extends MovieClip
    {

        public function Main()
        {
            super();
            var rec:Rectangle = new Rectangle(0, 0, Contents.config.pageRect.width, Contents.config.pageRect.height);
            new ScrollMT(this, rec, null, true, false, true, false, false, 0);

        }
    }
}
