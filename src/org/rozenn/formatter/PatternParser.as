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
package org.rozenn.formatter
{
    import org.rozenn.formatter.converter.ClassConverter;
    import org.rozenn.formatter.converter.DateConverter;
    import org.rozenn.formatter.converter.IConverter;
    import org.rozenn.formatter.converter.LevelConverter;
    import org.rozenn.formatter.converter.LiteralConverter;
    import org.rozenn.formatter.converter.MessageConverter;

    import flash.utils.Dictionary;

    /**
     * The parse of pattern is delegated by <code>PatternFormatter</code> class to <code>PatternParser</code>.
     * This class parse pattern and return a chained list of <code>IConverter</code>
     *  
     * @author Alexis Couronne
     */
    public class PatternParser
    {
        /**
         * @private
         */
        private static const ESCAPE_CHAR : String = "%";

        /**
         * @private
         */
        private static const LITERAL_STATE : int = 0;

        /**
         * @private
         */
        private static const CONVERTER_STATE : int = 1;

        /**
         * @private
         */
        private var _rules : Dictionary;

        /**
         * Creates a new <code>PatternParser</code> instance.
         */
        public function PatternParser()
        {
            _rules = new Dictionary(true);
            _rules["C"] = ClassConverter;
            _rules["D"] = DateConverter;
            _rules["L"] = LevelConverter;
            _rules["M"] = MessageConverter;
        }

        /**
         * Parse a format specifier and return a chained list of IConverter.
         * 
         * @param pattern pattern to parse.
         * @return chained list of IConverter.
         * @author Inspired by Log4J library.
         */
        public function parse(pattern : String) : Vector.<IConverter>
        {
            var converters : Vector.<IConverter> = new Vector.<IConverter>();
            var i : int = 0;
            var lengthPattern : int = pattern.length;
            var char : String;
            var literal : String = "";
            var state : int = LITERAL_STATE;

            while (i < lengthPattern)
            {
                char = pattern.charAt(i++);

                switch(state)
                {
                    case LITERAL_STATE:
                        if (char == ESCAPE_CHAR)
                        {
                            if (pattern.charAt(i) == ESCAPE_CHAR)
                            {
                                literal += char;
                                i++;
                            }
                            else
                            {
                                if (literal.length != 0)
                                {
                                    converters.push(new LiteralConverter(literal));
                                }
                                literal = "" + char;
                                state = CONVERTER_STATE;
                            }
                        }
                        else
                        {
                            literal += char;
                        }
                        break;
                    case CONVERTER_STATE:
                        literal += char;
                        // parse options
                        var options : String = null;
                        if (i < lengthPattern && pattern.charAt(i) == "{")
                        {
                            var end : int = pattern.indexOf("}");
                            if (end != -1)
                            {
                                options = pattern.substring(i + 1, end);
                                i = end + 1;
                            }
                        }
                        if (_rules[char] != null)
                        {
                            var AClassConverter : Class = Class(_rules[char]);
                            converters.push(new AClassConverter(options));
                            literal = "";
                        }
                        else
                        {
                            if (literal.length > 0)
                            {
                                converters.push(new LiteralConverter(literal));
                                literal = "";
                            }
                        }
                        state = LITERAL_STATE;
                        break;
                }
            }
            return converters;
        }
    }
}
