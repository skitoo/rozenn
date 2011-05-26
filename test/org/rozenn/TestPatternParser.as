package org.rozenn
{
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertTrue;
    import org.rozenn.formatter.PatternParser;
    import org.rozenn.formatter.converter.ClassConverter;
    import org.rozenn.formatter.converter.DateConverter;
    import org.rozenn.formatter.converter.IConverter;
    import org.rozenn.formatter.converter.LevelConverter;
    import org.rozenn.formatter.converter.LiteralConverter;
    import org.rozenn.formatter.converter.MessageConverter;

    /**
     * @author Alexis Couronne
     */
    public class TestPatternParser
    {
        private var instance : PatternParser;

        [Before]
        public function setUp() : void
        {
            instance = PatternParser.getInstance();
        }

        [Test]
        public function testParse() : void
        {
            var converters : Vector.<IConverter>;

            converters = instance.parse("%C %M");
            assertEquals(3, converters.length);

            assertTrue(converters[0] is ClassConverter);
            assertTrue(converters[1] is LiteralConverter);
            assertTrue(converters[2] is MessageConverter);
            assertEquals(" ", LiteralConverter(converters[1]).literal);

            converters = instance.parse("%L [%C] %M");
            assertEquals(5, converters.length);
            assertTrue(converters[0] is LevelConverter);
            assertTrue(converters[1] is LiteralConverter);
            assertTrue(converters[2] is ClassConverter);
            assertTrue(converters[3] is LiteralConverter);
            assertTrue(converters[4] is MessageConverter);

            assertEquals(" [", LiteralConverter(converters[1]).literal);
            assertEquals("] ", LiteralConverter(converters[3]).literal);

            converters = instance.parse("%D{DD/MM/YYYY} - %L %C %M");
            assertEquals(7, converters.length);
            assertTrue(converters[0] is DateConverter);
            assertTrue(converters[1] is LiteralConverter);
            assertTrue(converters[2] is LevelConverter);
            assertTrue(converters[3] is LiteralConverter);
            assertTrue(converters[4] is ClassConverter);
            assertTrue(converters[5] is LiteralConverter);
            assertTrue(converters[6] is MessageConverter);

            assertEquals("DD/MM/YYYY", DateConverter(converters[0]).getOptions());
            assertEquals(" - ", LiteralConverter(converters[1]).literal);

            converters = instance.parse("%D - %C %M");
            assertEquals(5, converters.length);
            assertTrue(converters[0] is DateConverter);
            assertTrue(converters[1] is LiteralConverter);
            assertTrue(converters[2] is ClassConverter);
            assertTrue(converters[3] is LiteralConverter);
            assertTrue(converters[4] is MessageConverter);
        }
    }
}
