package
{
    import org.rozenn.TestAbstractLayout;
    import org.rozenn.TestLevel;
    import org.rozenn.TestLogger;
    import org.rozenn.TestLogging;
    import org.rozenn.TestPatternFormatter;
    import org.rozenn.TestPatternParser;
    import org.rozenn.TestSimpleFormatter;
    import org.rozenn.converter.TestClassConverter;
    import org.rozenn.converter.TestDateConverter;
    import org.rozenn.converter.TestLevelConverter;
    import org.rozenn.converter.TestMessageConverter;

    /**
     * @author Alexis Couronne
     */
    [Suite]
    [RunWith("org.flexunit.runners.Suite")]
    public class RozennTestSuite
    {
        public var testClassConverter : TestClassConverter;

        public var testDateConverter : TestDateConverter;

        public var testLevelConverter : TestLevelConverter;

        public var testMessageConverter : TestMessageConverter;

        public var testAbstractLayout : TestAbstractLayout;

        public var testLevel : TestLevel;

        public var testLogger : TestLogger;

        public var testLogging : TestLogging;

        public var testPatternFormatter : TestPatternFormatter;

        public var testPatternParser : TestPatternParser;

        public var testSimpleFormatter : TestSimpleFormatter;
    }
}
