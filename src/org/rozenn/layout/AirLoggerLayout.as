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
    import flash.events.SecurityErrorEvent;
    import flash.events.StatusEvent;
    import flash.net.LocalConnection;
    import flash.utils.clearInterval;
    import flash.utils.getQualifiedClassName;
    import flash.utils.setInterval;
    import org.rozenn.Level;
    import org.rozenn.LogRecord;
    import org.rozenn.formatter.IFormatter;


    /**
     * The <code>AirLoggerLayout</code> class provides a convenient way to output log messages through AirLogger console.
     * 
     * @author Alexis Couronne
     * @author Damien Pegoraro
     * @author Cédric Néhémie ( AirLogger )
     */
    public class AirLoggerLayout extends AbstractLayout
    {
        /**
         * @private
         */
        private static const LOCALCONNECTION_ID : String = "_AIRLOGGER_CONSOLE";

        /**
         * @private
         */
        private static const OUT_SUFFIX : String = "_IN";

        /**
         * @private
         */
        private static const IN_SUFFIX : String = "_OUT";

        /**
         * @private
         */
        private static var ALTERNATE_ID_IN : String = "";

        /**
         * @private
         */
        private var _lcOut : LocalConnection;

        /**
         * @private
         */
        private var _lcIn : LocalConnection;

        /**
         * @private
         */
        private var _sID : String;

        /**
         * @private
         */
        private var _bIdentified : Boolean;

        /**
         * @private
         */
        private var _bRequesting : Boolean;

        /**
         * @private
         */
        private var _aLogStack : Array;

        /**
         * @private
         */
        private var _nPingRequest : Number;

        /**
         * @private
         */
        private var _sName : String;

        /**
         * Build an <code>AirLoggerLayout</code> instance.
         * 
         * @param formatter The default formatter for this layout. If <code>null</code> is passed <code>SimpleFormatter</code> is used.
         * @param minLevel	The min level listen by this layout. If <code>null</code> is passed <code>Level.ALL</code> is used.
         * @param maxLevel	The max level listen by this layout. If <code>null</code> is passed <code>Level.FATAL</code> is used.
         * @throws 	<code>org.skitools.exception.IllegalStateException</code> if passed-in min level is superior than max level.
         */
        public function AirLoggerLayout(formatter : IFormatter = null, minLevel : Level = null, maxLevel : Level = null)
        {
            super(formatter, minLevel, maxLevel);

            _lcOut = new LocalConnection();
            _lcOut.addEventListener(StatusEvent.STATUS, onStatus, false, 0, true);
            _lcOut.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError, false, 0, true);

            _lcIn = new LocalConnection();
            _lcIn.addEventListener(StatusEvent.STATUS, onStatus, false, 0, true);
            _lcIn.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError, false, 0, true);
            _lcIn.client = this;
            _lcIn.allowDomain("*");

            connect();

            _aLogStack = new Array();

            _bIdentified = false;
            _bRequesting = false;
        }

        /**
         * This method is called if level <code>LogRecord</code> is between min and max level
         * This method send <code>LogRecord</code> informations to AirLogger
         * 
         * @param logRecord informations of log message.
         */
        override protected function send(logRecord : LogRecord) : void
        {
            var formated : * = getFormatter(logRecord).format(logRecord) ;

            var evt : AirLoggerEvent = new AirLoggerEvent("log", formated, logRecord.getLevel().getID(), logRecord.getDate(), getQualifiedClassName(formated));

            _send(evt);
        }

        /**
         * Connects to the AirLogger console.
         */
        protected function connect() : void
        {
            var b : Boolean = true;

            while ( b )
            {
                try
                {
                    _lcIn.connect(_getInConnectionName(ALTERNATE_ID_IN));

                    b = false;
                    break;
                }
                catch ( e : Error )
                {
                    _lcOut.send(_getOutConnectionName(), "mainConnectionAlreadyUsed", ALTERNATE_ID_IN);

                    ALTERNATE_ID_IN += "_";
                }
            }
        }

        /**
         * Closes connection.
         */
        public function close() : void
        {
            _lcIn.close();
        }

        /**
         * Gives focus to AirLogger console.
         */
        public function focus() : void
        {
            _send(new AirLoggerEvent("focus"));
        }

        /**
         * Clears AirLogger console messages.
         */
        public function clear() : void
        {
            _send(new AirLoggerEvent("clear"));
        }

        /**
         * Sets tab name for current connection in use.
         * 
         * @param s the tab name
         */
        public function setName(s : String) : void
        {
            _sName = s;

            if ( _bIdentified )
            {
                _lcOut.send(_getOutConnectionName(_sID), "setTabName", _sName);
            }
        }

        /**
         * Set id for this SWF.
         * 
         * @param id the id for this SWF
         */
        public function setID(id : String) : void
        {
            try
            {
                clearInterval(_nPingRequest);
                _sID = id;

                _lcIn.close();
                _lcIn.connect(_getInConnectionName(_sID));

                _lcOut.send(_getOutConnectionName(), "confirmID", id, _sName);

                _bIdentified = true;
                _bRequesting = false;

                var l : Number = _aLogStack.length;
                if ( l != 0 )
                {
                    for (var i : Number = 0;i < l;i++ )
                    {
                        _send(AirLoggerEvent(_aLogStack.shift()));
                    }
                }
            }
            catch ( e : Error )
            {
                _lcIn.connect(_getInConnectionName(ALTERNATE_ID_IN));

                _lcOut.send(_getOutConnectionName(), "idAlreadyUsed", id);
            }
        }

        /**
         * Send a ping message to AirLogger
         */
        public function pingRequest() : void
        {
            _lcOut.send(_getOutConnectionName(), "requestID", ALTERNATE_ID_IN);
        }

        /**
         * Indicates if it is requesting
         * 
         * @return <code>true</code> if it is requesting
         */
        public function isRequesting() : Boolean
        {
            return _bRequesting;
        }

        /**
         * Indicates if it is identified to AirLogger console
         * 
         * @return <code>true</code> if it is identified to AirLogger console
         */
        public function isIdentified() : Boolean
        {
            return _bIdentified;
        }

        /**
         * @private
         */
        private function _send(evt : AirLoggerEvent) : void
        {
            if ( _bIdentified )
            {
                _lcOut.send(_getOutConnectionName(_sID), evt.type, evt);
            }
            else
            {
                _aLogStack.push(evt);

                if ( !_bRequesting )
                {
                    pingRequest();
                    _nPingRequest = setInterval(pingRequest, 1000);
                    _bRequesting = true;
                }
            }
        }

        /**
         * @private
         */
        private function _getInConnectionName(id : String = "") : String
        {
            return LOCALCONNECTION_ID + id + IN_SUFFIX;
        }

        /**
         * @private
         */
        private function _getOutConnectionName(id : String = "") : String
        {
            return LOCALCONNECTION_ID + id + OUT_SUFFIX;
        }

        /**
         * @private
         */
        private function onStatus(event : StatusEvent) : void
        {
            trace("onStatus( " + event + ")");
        }

        /**
         * @private
         */
        private function onSecurityError(event : SecurityErrorEvent) : void
        {
            trace("onSecurityError(" + event + ")");
        }
    }
}
internal class AirLoggerEvent
{
    public var type : String;

    public var message : *;

    public var level : uint;

    public var date : Date;

    public var messageType : String;

    public function AirLoggerEvent(sType : String, message : * = null, level : uint = 0, date : Date = null, messageType : String = null)
    {
        this.type = sType;
        this.message = message;
        this.level = level;
        this.date = date;
        this.messageType = messageType;
    }
}