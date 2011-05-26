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
