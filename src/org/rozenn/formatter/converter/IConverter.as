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
	 * <code>IConverter</code> define the converter structure.
	 * 
	 * @author Alexis Couronne
	 */
	public interface IConverter 
	{
		/**
		 * Convert <code>LogRecord</code> in a string.
		 * 
		 * @param logRecord <code>LogRecord</code> to format
		 * @return string conversion of <code>LogRecord</code>
		 * @throws 	<code>org.skitools.exception.NotImplementedException</code> if it's not overrided.
		 */
		function convert(logRecord : LogRecord) : String;
	}
}
