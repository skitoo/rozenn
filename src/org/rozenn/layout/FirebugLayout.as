/* * Copyright the original author or authors. *  * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License"); * you may not use this file except in compliance with the License. * You may obtain a copy of the License at *  *      http://www.mozilla.org/MPL/MPL-1.1.html *  * Unless required by applicable law or agreed to in writing, software * distributed under the License is distributed on an "AS IS" BASIS, * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. * See the License for the specific language governing permissions and * limitations under the License. */package org.rozenn.layout{    import org.rozenn.formatter.PatternFormatter;    import flash.external.ExternalInterface;    import org.rozenn.Level;    import org.rozenn.LogRecord;    import org.rozenn.formatter.IFormatter;    /**     * The <code>FirebugLayout</code> class provides a convenient way to output log messages through Firebug console.     *      * @author Alexis Couronne     */    public class FirebugLayout extends AbstractLayout    {        /**         * @private         */        private static const FIREBUG_DEBUG : String = "console.debug";        /**         * @private         */        private static const FIREBUG_INFO : String = "console.info";        /**         * @private         */        private static const FIREBUG_WARN : String = "console.warn";        /**         * @private         */        private static const FIREBUG_ERROR : String = "console.error";        /**         * @private         */        private static const FIREBUG_FATAL : String = "console.error";        /**         * Build an <code>FirebugLayout</code> instance.         *          * @param formatter The default formatter for this layout. If <code>null</code> is passed <code>SimpleFormatter</code> is used.         * @param minLevel	The min level listen by this layout. If <code>null</code> is passed <code>Level.ALL</code> is used.         * @param maxLevel	The max level listen by this layout. If <code>null</code> is passed <code>Level.FATAL</code> is used.         * @throws 	<code>org.skitools.exception.IllegalStateException</code> if passed-in min level is superior than max level.         */        public function FirebugLayout(formatter : IFormatter = null, minLevel : Level = null, maxLevel : Level = null)        {            super(formatter ? formatter : new PatternFormatter("[%C] %M"), minLevel, maxLevel);        }        /**         * This method is called if level <code>LogRecord</code> is between min and max level         * This method send <code>LogRecord</code> informations to Firebug         *          * @param logRecord informations of log message.         */        override protected function send(logRecord : LogRecord) : void        {            if (!ExternalInterface.available) return;            var message : String = getFormatter(logRecord).format(logRecord);            switch(logRecord.getLevel())            {                case Level.DEBUG:                    ExternalInterface.call(FIREBUG_DEBUG, message);                    break;                case Level.INFO:                    ExternalInterface.call(FIREBUG_INFO, message);                    break;                case Level.WARN:                    ExternalInterface.call(FIREBUG_WARN, message);                    break;                case Level.ERROR:                    ExternalInterface.call(FIREBUG_ERROR, message);                    break;                case Level.FATAL:                    ExternalInterface.call(FIREBUG_FATAL, message);                    break;            }        }    }}