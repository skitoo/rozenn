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
	 * Formats a string literal. 
	 * 
	 * @author Alexis Couronne
	 */
	public class LiteralConverter implements IConverter 
	{
		/**
		 * @private
		 */
		private var _literal : String;

		/**
		 * Build a <code>LiteralConverter</code> instance.
		 * 
		 * @param literal string literal
		 */
		public function LiteralConverter(literal : String)
		{
			_literal = literal;
		}

		/**
		 * Returns string literal
		 * 
		 * @return string literal
		 */
		public function get literal() : String
		{
			return _literal;
		}

		/**
		 * @inheritDoc
		 */
		public function convert(logRecord : LogRecord) : String
		{
			return _literal;
		}
	}
}
