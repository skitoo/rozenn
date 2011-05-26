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
    import flash.events.Event;
    import flash.net.XMLSocket;
    import org.rozenn.Level;
    import org.rozenn.LogRecord;
    import org.rozenn.formatter.IFormatter;


    /**
     * The <code>SOSMaxLayout</code> class provides a convenient way to output log messages through SOS Max server.
     * 
     * @author Alexis Couronne
     */
    public class SOSMaxLayout extends AbstractLayout
    {
        /**
         * @private
         */
        private var _xmlSocket : XMLSocket;

        /**
         * @private
         */
        private var _buffer : Vector.<LogRecord>;

        /**
         * @private
         */
        private var _host : String;

        /**
         * @private
         */
        private var _port : int;

        /**
         * The default SOS Max host
         */
        public static const DEFAULT_HOST : String = "localhost";

        /**
         * The default SOS Max port
         */
        public static const DEFAULT_PORT : int = 4444;

        /**
         * Build an <code>SOSMaxLayout</code> instance.
         * 
         * @param formatter The default formatter for this layout. If <code>null</code> is passed <code>SimpleFormatter</code> is used.
         * @param minLevel	The min level listen by this layout. If <code>null</code> is passed <code>Level.ALL</code> is used.
         * @param maxLevel	The max level listen by this layout. If <code>null</code> is passed <code>Level.FATAL</code> is used.
         * @param host 		The address of SOS Max server
         * @param port		The port of SOS Max Server
         * @throws 	<code>org.skitools.exception.IllegalStateException</code> if passed-in min level is superior than max level.
         */
        public function SOSMaxLayout(formatter : IFormatter = null, minLevel : Level = null, maxLevel : Level = null, host : String = DEFAULT_HOST, port : int = DEFAULT_PORT)
        {
            super(formatter, minLevel, maxLevel);
            _host = host;
            _port = port;

            _xmlSocket = new XMLSocket();
            _xmlSocket.addEventListener(Event.CONNECT, onConnect);
            _xmlSocket.addEventListener(Event.CLOSE, onClose);

            _buffer = new Vector.<LogRecord>();
            connect();
        }

        /**
         * @inheritDoc
         */
        override protected function send(logRecord : LogRecord) : void
        {
            if (_xmlSocket.connected)
            {
                sendMessage(logRecord);
            }
            else
            {
                _buffer.push(logRecord);
            }
        }

        /**
         * @private
         */
        private function sendMessage(logRecord : LogRecord) : void
        {
            var message : String = "!SOS<showMessage key='" + logRecord.getLevel().getName() + "' />";
            message += getFormatter(logRecord).format(logRecord);
            _xmlSocket.send(message);
        }

        /**
         * @private
         */
        private function connect() : void
        {
            if (!_xmlSocket.connected)
                _xmlSocket.connect(_host, _port);
        }

        /**
         * @private
         */
        private function onClose(event : Event) : void
        {
            connect();
        }

        /**
         * @private
         */
        private function onConnect(event : Event) : void
        {
            for each (var logRecord : LogRecord in _buffer)
            {
                sendMessage(logRecord);
            }
            _buffer = new Vector.<LogRecord>();
        }
    }
}
