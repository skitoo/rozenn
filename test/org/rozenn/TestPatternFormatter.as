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
package org.rozenn
{
    import org.flexunit.asserts.assertEquals;
    import org.rozenn.formatter.PatternFormatter;

    /**
     * @author Alexis Couronne
     */
    public class TestPatternFormatter
    {
        private var instance1 : PatternFormatter;

        private var instance2 : PatternFormatter;

        private var logger : Logger = Logger.getLogger(TestPatternFormatter);

        [Before]
        public function setUp() : void
        {
            instance1 = new PatternFormatter();
            instance2 = new PatternFormatter("%C - %L - %M");
        }

        [Test]
        public function testGetPattern() : void
        {
            assertEquals(PatternFormatter.DEFAULT_PATTERN, instance1.getPattern());
            assertEquals("%C - %L - %M", instance2.getPattern());
        }

        [Test]
        public function testFormat() : void
        {
            var logRecord : LogRecord = new LogRecord(logger, Level.DEBUG, "Message 1");

            assertEquals("DEBUG [org.rozenn.TestPatternFormatter] Message 1", instance1.format(logRecord));
            assertEquals("org.rozenn.TestPatternFormatter - DEBUG - Message 1", instance2.format(logRecord));

            var date : Date = new Date();
            date.fullYear = 2010;
            date.month = 5;
            date.date = 13;
            date.hours = 14;
            date.minutes = 20;
            date.seconds = 32;
            logRecord = new LogRecord(logger, Level.FATAL, "Message 2", null, date);

            instance1.setPattern("%D{HH:mm:ss} - %L [%C] %M");
            assertEquals("14:20:32 - FATAL [org.rozenn.TestPatternFormatter] Message 2", instance1.format(logRecord));

            instance1.setPattern("%D - %L [%C] %M");
            assertEquals("06/13/2010 - FATAL [org.rozenn.TestPatternFormatter] Message 2", instance1.format(logRecord));
        }
    }
}
