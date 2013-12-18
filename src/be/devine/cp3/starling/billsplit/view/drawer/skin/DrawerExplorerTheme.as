package be.devine.cp3.starling.billsplit.view.drawer.skin {


import be.devine.cp3.starling.billsplit.view.drawer.DrawerView;
import be.devine.cp3.starling.billsplit.view.screens.Detail;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;
import feathers.themes.MetalWorksMobileTheme;
import starling.display.Quad;




public class DrawersEplorerTheme extends MetalWorksMobileTheme
{
    public static const THEME_NAME_TOP_AND_BOTTOM_DRAWER:String = "drawers-explorer-top-and-bottom-drawer";
    public static const THEME_NAME_LEFT_AND_RIGHT_DRAWER:String = "drawers-explorer-left-and-right-drawer";

    public function DrawersExplorerTheme()
    {
        super();
    }

    override protected function initialize():void
    {
        super.initialize();
        this.setInitializerForClass(Detail, contentViewInitializer);
        this.setInitializerForClass(DrawerView, topAndBottomDrawerViewInitializer, THEME_NAME_TOP_AND_BOTTOM_DRAWER);
        this.setInitializerForClass(DrawerView, leftAndRightDrawerViewInitializer, THEME_NAME_LEFT_AND_RIGHT_DRAWER);
    }

    protected function contentViewInitializer(view:Detail):void
    {
        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
        layout.padding = 20 * this.scale;
        view.layout = layout;
    }

    protected function leftAndRightDrawerViewInitializer(view:DrawerView):void
    {
        view.backgroundSkin = new Quad(10, 10, LIST_BACKGROUND_COLOR);

        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
        layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
        layout.padding = 20 * this.scale;
        layout.gap = 20 * this.scale;
        view.layout = layout;
    }

    protected function topAndBottomDrawerViewInitializer(view:DrawerView):void
    {
        view.backgroundSkin = new Quad(10, 10, GROUPED_LIST_HEADER_BACKGROUND_COLOR);

        var layout:HorizontalLayout = new HorizontalLayout();
        layout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
        layout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
        layout.padding = 20 * this.scale;
        layout.gap = 20 * this.scale;
        view.layout = layout;
    }
}
}
