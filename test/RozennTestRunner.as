package
{
    import org.flexunit.internals.TraceListener;
    import org.flexunit.listeners.CIListener;
    import org.flexunit.runner.FlexUnitCore;

    import flash.display.Sprite;

    /**
     * @author Alexis Couronne
     */
    public class RozennTestRunner extends Sprite
    {
        public function RozennTestRunner()
        {
            var core : FlexUnitCore = new FlexUnitCore();
            core.addListener(new CIListener());
            core.addListener(new TraceListener());
            core.run(RozennTestSuite);
        }
    }
}
