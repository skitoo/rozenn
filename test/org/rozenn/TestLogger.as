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
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertNull;

    /**
     * @author Alexis Couronne
     */
    public class TestLogger
    {
        private var instance : Logger;

        private var other : Logger;

        private var layout : MyTestLayout;

        [Before]
        public function setUp() : void
        {
            instance = Logger.getLogger(TestLogger);
            other = Logger.getLogger("org.other.Pwet");
            layout = new MyTestLayout();
            Logging.getInstance().addLayout(layout);
        }

        [After]
        public function tearDown() : void
        {
            Logging.getInstance().removeLayout(layout);
        }

        [Test]
        public function testGetClass() : void
        {
            assertEquals("org.rozenn.TestLogger", instance.getClass());
            assertEquals("org.other.Pwet", other.getClass());
        }

        [Test]
        public function testGetEffectiveLevel() : void
        {
            instance.setLevel(null);
            assertEquals(Level.ALL, instance.getEffectiveLevel());
            Logger.getLogger("org.rozenn").setLevel(Level.DEBUG);
            assertEquals(Level.DEBUG, instance.getEffectiveLevel());
            assertEquals(Level.ALL, other.getEffectiveLevel());
            Logger.getLogger("org").setLevel(Level.WARN);
            assertEquals(Level.DEBUG, instance.getEffectiveLevel());
            assertEquals(Level.WARN, other.getEffectiveLevel());
        }

        [Test]
        public function testLog() : void
        {
            assertNull(layout.currentRecord);
            instance.setLevel(Level.ALL);

            instance.debug("debug message");
            assertEquals(Level.DEBUG, layout.currentRecord.getLevel());
            assertEquals("debug message", layout.currentRecord.getMessage());

            instance.info("info message");
            assertEquals(Level.INFO, layout.currentRecord.getLevel());
            assertEquals("info message", layout.currentRecord.getMessage());

            instance.warn("warn message");
            assertEquals(Level.WARN, layout.currentRecord.getLevel());
            assertEquals("warn message", layout.currentRecord.getMessage());

            instance.error("error message");
            assertEquals(Level.ERROR, layout.currentRecord.getLevel());
            assertEquals("error message", layout.currentRecord.getMessage());

            instance.fatal("fatal message");
            assertEquals(Level.FATAL, layout.currentRecord.getLevel());
            assertEquals("fatal message", layout.currentRecord.getMessage());

            instance.setLevel(Level.INFO);
            layout.currentRecord = null;
            instance.debug("plop");
            assertNull(layout.currentRecord);
            instance.info("info message");
            assertEquals(Level.INFO, layout.currentRecord.getLevel());
            assertEquals("info message", layout.currentRecord.getMessage());

            instance.setLevel(Level.WARN);
            layout.currentRecord = null;
            instance.debug("plop");
            instance.info("plip");
            assertNull(layout.currentRecord);
            instance.warn("warn message");
            assertEquals(Level.WARN, layout.currentRecord.getLevel());
            assertEquals("warn message", layout.currentRecord.getMessage());

            instance.setLevel(Level.ERROR);
            layout.currentRecord = null;
            instance.debug("plop");
            instance.info("plip");
            instance.warn("plup");
            assertNull(layout.currentRecord);
            instance.error("error message");
            assertEquals(Level.ERROR, layout.currentRecord.getLevel());
            assertEquals("error message", layout.currentRecord.getMessage());

            instance.setLevel(Level.FATAL);
            layout.currentRecord = null;
            instance.debug("plop");
            instance.info("plip");
            instance.warn("plup");
            instance.error("plyp");
            assertNull(layout.currentRecord);
            instance.fatal("fatal message");
            assertEquals(Level.FATAL, layout.currentRecord.getLevel());
            assertEquals("fatal message", layout.currentRecord.getMessage());

            instance.setLevel(Level.OFF);
            layout.currentRecord = null;
            instance.debug("plop");
            instance.info("plip");
            instance.warn("plup");
            instance.error("plyp");
            instance.fatal("plap");
            assertNull(layout.currentRecord);
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

    public function MyTestLayout(formatter : IFormatter = null, minLevel : Level = null, maxLevel : Level = null)
    {
        super(formatter, minLevel, maxLevel);
    }

    override protected function send(logRecord : LogRecord) : void
    {
        currentRecord = logRecord;
    }
}