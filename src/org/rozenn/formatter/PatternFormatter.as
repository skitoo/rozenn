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
    import org.rozenn.LogRecord;
    import org.rozenn.formatter.converter.IConverter;
	/**
	 * A flexible formatter configurable with string pattern.
	 * You are free to insert any literal text within the conversion pattern.
	 * 
	 * <p>Example for the following pattern <code>%L [%C] %M</code> :</p>
	 * 
	 * <code>
	 *  var logger : Logger = Logger.getLogger("root");<br>
	 * 	logger.debug("Message A");<br>
	 * 	logger.warn("Message B");
	 * </code>
	 * 
	 * <p>output :</p> 
	 * 
	 * <code>
	 * DEBUG [root] Message A<br>
	 * WARN [root] Message B<br>
	 * </code>
	 * <br>
	 * <table class=innertable>
	 * <tr><th>Converstion pattern</th><th>Result</th></tr>
	 * <tr>
	 * 	<td>C</td>
	 * 	<td>Used to output the fully class name of the caller.</td>
	 * </tr>
	 * <tr>
	 * 	<td>D</td>
	 * 	<td>Used to output the date of log record. The format of date can be specified between braces. Example : <b>%D{HH:ii:ss}</b></td>
	 * </tr>
	 * <tr>
	 * 	<td>L</td>
	 * 	<td>Used to output the level of log record</td>
	 * </tr>
	 * <tr>
	 * 	<td>M</td>
	 * 	<td>Used to output the message of log record</td>
	 * </tr>
	 * </table>
	 * 
	 * @author Alexis Couronne
	 * @see org.skitools.utils.DateFormatter
	 */
	public class PatternFormatter implements IFormatter 
	{
		/**
		 * @private
		 */
		private var pattern : String;
		
		/**
		 * @private
		 */
		private var converters : Vector.<IConverter>;
		
		/**
		 * Default pattern string for log output. The current value is "%L [%C] %M".
		 */
		public static const DEFAULT_PATTERN : String = "%L [%C] %M";

		/**
		 * Constructs a PatternLayout using the passed-in conversion pattern. If pattern is null, the <code>DEFAULT_PATTERN</code> is used.
		 * 
		 * @param pattern the conversion pattern. If it null, the <code>DEFAULT_PATTERN</code> is used 
		 */
		public function PatternFormatter(pattern : String=null)
		{
			setPattern(pattern);
		}
		
		/**
		 * Returns conversion pattern
		 * 
		 * @return conversion pattern
		 */
		public function getPattern() : String
		{
            return pattern;
        }
        
        /**
         * Set the conversion pattern. If pattern is null, the <code>DEFAULT_PATTERN</code> is used.
         * 
         * @param pattern the conversion pattern. If it null, the <code>DEFAULT_PATTERN</code> is used
         */
        public function setPattern(pattern : String) : void
        {
        	this.pattern = pattern || DEFAULT_PATTERN;
        	converters = PatternParser.getInstance().parse(this.pattern);
        }

		/**
		 * Makes a formatted string as specified by the conversion pattern. 
		 * 
		 * @param logRecord the <code>LogRecord</code> to format
		 * @return formatted string
		 */
        public function format(logRecord : LogRecord) : * 
		{
			var result : String = "";
			var converter : IConverter;
			for each(converter in converters)
			{
				result += converter.convert(logRecord);			}
			return result;
		}
	}
}
