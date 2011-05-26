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
    import org.rozenn.formatter.converter.DateConverter;

    /**
     * @author Alexis Couronne
     */
    public class TestDateConverter
    {
        private var instance : DateConverter;

        /**
         * @private
         */
        private var logger : Logger = Logger.getLogger(TestDateConverter);

        private static const P1 : String = "dd/MM/yyyy HH:mm:ss";

        [Before]
        public function setUp() : void
        {
            instance = new DateConverter(P1);
        }

        [Test]
        public function testConvert() : void
        {
            var date : Date = new Date();
            date.fullYear = 2010;
            date.month = 5;
            date.date = 13;
            date.hours = 14;
            date.minutes = 20;
            date.seconds = 32;
            var logRecord : LogRecord = new LogRecord(logger, Level.DEBUG, "a test log message", null, date);

            assertEquals("13/06/2010 14:20:32", instance.convert(logRecord));
        }
    }
}
