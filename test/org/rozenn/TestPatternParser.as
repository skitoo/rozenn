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
    import org.flexunit.asserts.assertTrue;
    import org.rozenn.formatter.PatternParser;
    import org.rozenn.formatter.converter.ClassConverter;
    import org.rozenn.formatter.converter.DateConverter;
    import org.rozenn.formatter.converter.IConverter;
    import org.rozenn.formatter.converter.LevelConverter;
    import org.rozenn.formatter.converter.LiteralConverter;
    import org.rozenn.formatter.converter.MessageConverter;

    /**
     * @author Alexis Couronne
     */
    public class TestPatternParser
    {
        private var instance : PatternParser;

        [Before]
        public function setUp() : void
        {
            instance = new PatternParser();
        }

        [Test]
        public function testParse() : void
        {
            var converters : Vector.<IConverter>;

            converters = instance.parse("%C %M");
            assertEquals(3, converters.length);

            assertTrue(converters[0] is ClassConverter);
            assertTrue(converters[1] is LiteralConverter);
            assertTrue(converters[2] is MessageConverter);
            assertEquals(" ", LiteralConverter(converters[1]).literal);

            converters = instance.parse("%L [%C] %M");
            assertEquals(5, converters.length);
            assertTrue(converters[0] is LevelConverter);
            assertTrue(converters[1] is LiteralConverter);
            assertTrue(converters[2] is ClassConverter);
            assertTrue(converters[3] is LiteralConverter);
            assertTrue(converters[4] is MessageConverter);

            assertEquals(" [", LiteralConverter(converters[1]).literal);
            assertEquals("] ", LiteralConverter(converters[3]).literal);

            converters = instance.parse("%D{DD/MM/YYYY} - %L %C %M");
            assertEquals(7, converters.length);
            assertTrue(converters[0] is DateConverter);
            assertTrue(converters[1] is LiteralConverter);
            assertTrue(converters[2] is LevelConverter);
            assertTrue(converters[3] is LiteralConverter);
            assertTrue(converters[4] is ClassConverter);
            assertTrue(converters[5] is LiteralConverter);
            assertTrue(converters[6] is MessageConverter);

            assertEquals("DD/MM/YYYY", DateConverter(converters[0]).getOptions());
            assertEquals(" - ", LiteralConverter(converters[1]).literal);

            converters = instance.parse("%D - %C %M");
            assertEquals(5, converters.length);
            assertTrue(converters[0] is DateConverter);
            assertTrue(converters[1] is LiteralConverter);
            assertTrue(converters[2] is ClassConverter);
            assertTrue(converters[3] is LiteralConverter);
            assertTrue(converters[4] is MessageConverter);
        }
    }
}
