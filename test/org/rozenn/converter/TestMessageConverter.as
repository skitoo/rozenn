package org.rozenn.converter
{
    import org.flexunit.asserts.assertEquals;
    import org.rozenn.Level;
    import org.rozenn.LogRecord;
    import org.rozenn.Logger;
    import org.rozenn.formatter.converter.MessageConverter;

    /**
     * @author Alexis Couronne
     */
    public class TestMessageConverter
    {
        private var logger : Logger = Logger.getLogger(TestMessageConverter);

        private var instance : MessageConverter;

        [Before]
        public function setUp() : void
        {
            instance = new MessageConverter();
        }

        [Test]
        public function testConvert() : void
        {
            var logRecord : LogRecord = new LogRecord(logger, Level.DEBUG, "a test log message");

            assertEquals("a test log message", instance.convert(logRecord));
        }
    }
}
