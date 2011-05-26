package org.rozenn
{
    import flash.geom.Point;
    import org.flexunit.asserts.assertEquals;
    import org.rozenn.formatter.SimpleFormatter;


    /**
     * @author Alexis Couronne
     */
    public class TestSimpleFormatter
    {
        private var instance : SimpleFormatter;

        private var logger : Logger = Logger.getLogger(TestPatternFormatter);

        [Before]
        public function setUp() : void
        {
            instance = new SimpleFormatter();
        }

        [Test]
        public function testFormat() : void
        {
            var logRecord : LogRecord = new LogRecord(logger, Level.DEBUG, "Message 1");

            assertEquals("Message 1", instance.format(logRecord));

            var point : Point = new Point();
            logRecord = new LogRecord(logger, Level.DEBUG, point);
            assertEquals(point, instance.format(logRecord));
        }
    }
}
