/*
 * Copyright the original author or authors.
 * 
 * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.mozilla.org/MPL/MPL-1.1.html
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package
{
    import org.rozenn.TestAbstractLayout;
    import org.rozenn.TestLevel;
    import org.rozenn.TestLogger;
    import org.rozenn.TestPatternFormatter;
    import org.rozenn.TestPatternParser;
    import org.rozenn.TestRozenn;
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

        public var testRozenn : TestRozenn;

        public var testPatternFormatter : TestPatternFormatter;

        public var testPatternParser : TestPatternParser;

        public var testSimpleFormatter : TestSimpleFormatter;
    }
}
