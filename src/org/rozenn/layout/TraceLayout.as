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
package org.rozenn.layout
{
    import org.rozenn.formatter.PatternFormatter;
    import org.rozenn.Level;
    import org.rozenn.LogRecord;
    import org.rozenn.formatter.IFormatter;

    /**
     * The <code>TraceLayout</code> class provides a convenient way
     * to output messages through the Adobe Flash IDE output panel.
     * 
     * @author Alexis Couronne
     */
    public class TraceLayout extends AbstractLayout
    {
        /**
         * Build a <code>TraceLayout</code> instance
         * 
         * @param formatter The default formatter for this layout. If <code>null</code> is passed <code>PatternFormatter</code> is used.
         * @param minLevel	The min level listen by this layout. If <code>null</code> is passed <code>Level.ALL</code> is used.
         * @param maxLevel	The max level listen by this layout. If <code>null</code> is passed <code>Level.FATAL</code> is used.
         * @throws 	<code>org.skitools.exception.IllegalStateException</code> if passed-in min level is superior than max level.
         */
        public function TraceLayout(formatter : IFormatter = null, minLevel : Level = null, maxLevel : Level = null)
        {
            super(formatter ? formatter : new PatternFormatter("%L [%C] %M"), minLevel, maxLevel);
        }

        /**
         * @inheritDoc
         */
        override protected function send(logRecord : LogRecord) : void
        {
            trace(getFormatter(logRecord).format(logRecord));
        }
    }
}
