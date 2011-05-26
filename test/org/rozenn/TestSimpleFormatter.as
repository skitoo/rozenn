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
    import flash.geom.Point;
    import org.flexunit.asserts.assertEquals;
    import org.rozenn.formatter.SimpleFormatter;


    /**
     * @author Alexis Couronne
     */
    public class TestSimpleFormatter
    {
        private var instance : SimpleFormatter;

        private var logger : Logger = Logger.getLogger(TestPatternFormatter);

        [Before]
        public function setUp() : void
        {
            instance = new SimpleFormatter();
        }

        [Test]
        public function testFormat() : void
        {
            var logRecord : LogRecord = new LogRecord(logger, Level.DEBUG, "Message 1");

            assertEquals("Message 1", instance.format(logRecord));

            var point : Point = new Point();
            logRecord = new LogRecord(logger, Level.DEBUG, point);
            assertEquals(point, instance.format(logRecord));
        }
    }
}
