/**
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
    import flash.errors.IllegalOperationError;
    import org.flexunit.asserts.assertNotNull;
    import org.flexunit.asserts.assertNull;
    import org.flexunit.asserts.assertTrue;


    /**
     * @author Alexis Couronne
     */
    public class TestAbstractLayout
    {
        private var instance : MyTestLayout;

        [Before]
        public function setUp() : void
        {
            instance = new MyTestLayout(null, Level.INFO);
        }

        [Test]
        public function testConstructor() : void
        {
            var hasFailed : Boolean = false;
            try
            {
                new MyTestLayout(null, Level.INFO, Level.DEBUG);
            }
            catch(e : IllegalOperationError)
            {
                hasFailed = true;
            }
            assertTrue(hasFailed);
        }

        [Test]
        public function testHandle() : void
        {
            assertNull(instance.currentRecord);
            instance.handle(new LogRecord(null, Level.DEBUG, "debug message"));
            assertNull(instance.currentRecord);
            instance.handle(new LogRecord(null, Level.INFO, "info message"));
            assertNotNull(instance.currentRecord);
            instance.currentRecord = null;
            instance.handle(new LogRecord(null, Level.WARN, "warn message"));
            assertNotNull(instance.currentRecord);
            instance.currentRecord = null;
            instance.handle(new LogRecord(null, Level.ERROR, "error message"));
            assertNotNull(instance.currentRecord);
            instance.currentRecord = null;
            instance.handle(new LogRecord(null, Level.FATAL, "fatal message"));
            assertNotNull(instance.currentRecord);
            instance.currentRecord = null;

            instance.setMinLevel(Level.DEBUG);
            instance.setMaxLevel(Level.WARN);

            instance.handle(new LogRecord(null, Level.DEBUG, "debug message"));
            assertNotNull(instance.currentRecord);
            instance.currentRecord = null;
            instance.handle(new LogRecord(null, Level.INFO, "info message"));
            assertNotNull(instance.currentRecord);
            instance.currentRecord = null;
            instance.handle(new LogRecord(null, Level.WARN, "warn message"));
            assertNotNull(instance.currentRecord);
            instance.currentRecord = null;
            instance.handle(new LogRecord(null, Level.ERROR, "error message"));
            assertNull(instance.currentRecord);
            instance.handle(new LogRecord(null, Level.FATAL, "fatal message"));
            assertNull(instance.currentRecord);
        }
    }
}
import org.rozenn.Level;
import org.rozenn.LogRecord;
import org.rozenn.formatter.IFormatter;
import org.rozenn.layout.AbstractLayout;

internal class MyTestLayout extends AbstractLayout
{
    public var currentRecord : LogRecord;

    public function MyTestLayout(formatter : IFormatter, minLevel : Level = null, maxLevel : Level = null)
    {
        super(formatter, minLevel, maxLevel);
    }

    override protected function send(logRecord : LogRecord) : void
    {
        currentRecord = logRecord;
    }
}
