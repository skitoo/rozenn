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

    /**
     * @author Alexis Couronne
     */
    public class TestLevel
    {
        [Test]
        public function testGetLevel() : void
        {
            assertEquals(Level.ALL, Level.getLevel("ALL"));
            assertEquals(Level.DEBUG, Level.getLevel("DEBUG"));
            assertEquals(Level.INFO, Level.getLevel("INFO"));
            assertEquals(Level.WARN, Level.getLevel("WARN"));
            assertEquals(Level.ERROR, Level.getLevel("ERROR"));
            assertEquals(Level.FATAL, Level.getLevel("FATAL"));
            assertEquals(Level.OFF, Level.getLevel("OFF"));
        }
    }
}
