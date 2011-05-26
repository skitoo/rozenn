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
package org.rozenn.formatter.converter 
{
    import org.rozenn.LogRecord;
	/**
	 * <code>AbstractConverter</code> is an abstract class that provides the formatting functionality that derived classes need. 
	 * 
	 * @author Alexis Couronne
	 */
	public class AbstractConverter implements IConverter 
	{
		/**
		 * The options for this converter
		 */
		protected var options : String;
		
		/**
		 * Build an <code>AbstractConverter</code> instance.
		 * 
		 * @param options for this converter. This param can be null.
		 */
		public function AbstractConverter(options : String = null)
		{
			this.options = options;
		}
		
		/**
		 * Returns converter options
		 * 
		 * @return converter options
		 */
		public function getOptions() : String
		{
			return options;
		}
		
		/**
		 * Convert <code>LogRecord</code> in a string.
		 * 
		 * @param logRecord <code>LogRecord</code> to format
		 * @return string conversion of <code>LogRecord</code>
		 */
		public function convert(logRecord : LogRecord) : String
		{
			return null;
		}
	}
}
