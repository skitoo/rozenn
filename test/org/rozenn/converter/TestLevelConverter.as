package org.rozenn.converter
{
    import org.flexunit.asserts.assertEquals;
    import org.rozenn.Level;
    import org.rozenn.LogRecord;
    import org.rozenn.Logger;
    import org.rozenn.formatter.converter.LevelConverter;

    /**
     * @author Alexis Couronne
     */
    public class TestLevelConverter
    {
        private var logger : Logger = Logger.getLogger(TestLevelConverter);

        private var instance : LevelConverter;

        [Before]
        public function setUp() : void
        {
            instance = new LevelConverter();
        }

        [Test]
        public function testConvert() : void
        {
            var logRecord : LogRecord = new LogRecord(logger, Level.DEBUG, "a test log message");

            assertEquals(Level.DEBUG.getName(), instance.convert(logRecord));
        }
    }
}
