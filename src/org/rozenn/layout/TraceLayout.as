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
         * @inheritDoc
         */
        public function TraceLayout(formatter : IFormatter = null, minLevel : Level = null, maxLevel : Level = null)
        {
            super(formatter, minLevel, maxLevel);
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
