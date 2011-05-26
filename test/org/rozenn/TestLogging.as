package org.rozenn
{
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertFalse;
    import org.flexunit.asserts.assertTrue;
    import org.rozenn.layout.AirLoggerLayout;
    import org.rozenn.layout.FirebugLayout;
    import org.rozenn.layout.TraceLayout;

    /**
     * @author Alexis Couronne
     */
    public class TestLogging
    {
        private var instance : Logging;

        [Before]
        public function setUp() : void
        {
            instance = Logging.getInstance();
            instance.removeAllLayouts();
        }

        [After]
        public function tearDown() : void
        {
            instance.removeAllLayouts();
        }

        [Test]
        public function testAddLayout() : void
        {
            var layout1 : FirebugLayout = new FirebugLayout();
            var layout2 : TraceLayout = new TraceLayout();
            var layout3 : AirLoggerLayout = new AirLoggerLayout();

            assertFalse(instance.hasLayout());

            instance.addLayout(layout1);
            instance.addLayout(layout2);
            instance.addLayout(layout3);
            instance.addLayout(layout3);

            assertTrue(instance.hasLayout());
            assertEquals(3, instance.numLayouts);
        }

        [Test]
        public function testRemoveLayout() : void
        {
            var layout1 : FirebugLayout = new FirebugLayout();
            var layout2 : TraceLayout = new TraceLayout();
            var layout3 : AirLoggerLayout = new AirLoggerLayout();

            instance.addLayout(layout1);
            instance.addLayout(layout2);

            assertEquals(2, instance.numLayouts);
            instance.removeLayout(layout3);
            assertEquals(2, instance.numLayouts);

            instance.removeLayout(layout1);
            assertEquals(1, instance.numLayouts);

            assertTrue(layout2, instance.getLayout(0));

            instance.removeLayout(layout2);
            assertFalse(instance.hasLayout());
        }
    }
}
