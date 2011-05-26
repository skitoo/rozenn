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
