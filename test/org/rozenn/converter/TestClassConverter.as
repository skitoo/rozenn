package org.rozenn.converter
{
    import org.flexunit.asserts.assertEquals;
    import org.rozenn.Level;
    import org.rozenn.LogRecord;
    import org.rozenn.Logger;
    import org.rozenn.formatter.converter.ClassConverter;

    /**
     * @author Alexis Couronne
     */
    public class TestClassConverter
    {
        private var logger : Logger = Logger.getLogger(TestClassConverter);

        private var instance : ClassConverter;

        [Before]
        public function setUp() : void
        {
            instance = new ClassConverter();
        }

        [Test]
        public function testConvert() : void
        {
            var logRecord : LogRecord = new LogRecord(logger, Level.DEBUG, "a test log message");

            assertEquals("org.rozenn.converter.TestClassConverter", instance.convert(logRecord));
        }
    }
}
