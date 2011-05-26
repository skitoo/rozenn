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
package org.rozenn
{
    import org.rozenn.layout.ILayout;

    /**
     * This class is the core of logging system. It dispatch to layouts 
     * <code>LogRecord</code> emit by <code>Logger</code> objects.
     * 
     * @author Alexis Couronne
     */
    public class Rozenn
    {
        /**
         * @private
         */
        private static var _layouts : Vector.<ILayout> = new Vector.<ILayout>();

        /**
         * @private
         */
        private static var _currentLayout : ILayout;

		/**
		 * Registers passed-in layout to the logging system.
		 * 
		 * @param layout the layout to add.
		 */
        public static function registerLayout(layout : ILayout) : void
        {
            if (_layouts.indexOf(layout) == -1)
            {
                _layouts.push(layout);
            }
        }

		/**
		 * Unregisters passed-in layout from logging system
		 * 
		 * @param layout the layout to remove.
		 */
        public static function unregisterLayout(layout : ILayout) : void
        {
            var index : int = _layouts.indexOf(layout);
            if (index > -1)
            {
                _layouts.splice(index, 1);
            }
        }

		/**
		 * Remove all layouts from logging system
		 */
        public static function unregisterAllLayouts() : void
        {
            _layouts = new Vector.<ILayout>();
        }

		/**
		 * Indicates if passed-in layout is registered into logging system
		 * 
		 * @param layout the layout to check.
		 * @return <code>true</code> if passed-in layout is registered
		 */
        public static function hasLayout(layout : ILayout) : Boolean
        {
            return (_layouts.indexOf(layout) > -1);
        }

        /**
         * @private
         */
        internal static function log(logRecord : LogRecord) : void
        {
            for each (_currentLayout in _layouts)
            {
                _currentLayout.handle(logRecord);
            }
        }
    }
}
