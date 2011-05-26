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
package org.rozenn.utils 
{

	/**
	 * <code>DateFormatter</code> provides method to format a <code>Date</code> with a string pattern.
	 * 
	 * <p>
	 * <table class=innertable>
	 * <tr><th>Pattern letter</th><th>Description</th></tr>
	 * <tr>
	 * 	<td>y</td>
	 * 	<td>
	 * 	Year.<p>Examples :</p>
	 * 	<ul><li>yy = 10</li><li>yyyy = 2010</li></ul>
	 * 	</td>
	 * </tr>
	 * <tr>
	 * 	<td>M</td>
	 * 	<td>
	 * 	Month.<p>Examples :</p>
	 * 	<ul><li>M = 2</li><li>MM = 02</li><li>MMMM = February</li></ul>
	 * 	</td>
	 * </tr>
	 * <tr>
	 * 	<td>d</td>
	 * 	<td>
	 * 	Day or date in month.<p>Examples :</p>
	 * 	<ul><li>d = 5</li><li>d = 05</li></ul>
	 * 	</td>
	 * </tr>
	 * <tr>
	 * 	<td>E</td>
	 * 	<td>
	 * 	Day of the week.<p>Examples :</p>
	 * 	<ul><li>E = 4</li><li>EE = 04</li><li>EEE = Thu</li><li>EEEE = Thursday</li></ul>
	 * 	</td>
	 * </tr>
	 * <tr>
	 * 	<td>H</td>
	 * 	<td>
	 * 	24 hour in day.<p>Examples :</p>
	 * 	<ul><li>H = 1</li><li>HH = 01</li></ul>
	 * 	</td>
	 * </tr>
	 * <tr>
	 * 	<td>h</td>
	 * 	<td>
	 * 	12 hour in day.<p>Examples :</p>
	 * 	<ul><li>h = 1</li><li>hh = 01</li></ul>
	 * 	</td>
	 * </tr>
	 * <tr>
	 * 	<td>a</td>
	 * 	<td>AM/PM information.</td>
	 * </tr>
	 * <tr>
	 * 	<td>m</td>
	 * 	<td>
	 * 	Minute in hour.<p>Examples :</p>
	 * 	<ul><li>m = 3</li><li>mm = 03</li></ul>
	 * 	</td>
	 * </tr>
	 * <tr>
	 * 	<td>s</td>
	 * 	<td>
	 * 	Second in minute.<p>Examples :</p>
	 * 	<ul><li>s = 9</li><li>ss = 09</li></ul>
	 * 	</td>
	 * </tr>
	 * <tr>
	 * 	<td>s</td>
	 * 	<td>Millisecond in second.</td>
	 * </tr>
	 * </table>
	 * </p>
	 * @author Alexis Couronne
	 */
	public class DateFormatter 
	{
		/**
		 * @private
		 */
		private var _pattern : String;
		
		/**
		 * @private
		 */
		private var _compilatePattern : Array;
		
		/**
		 * @private
		 */
		private static const PATTERN_CHARS : String = "yMdEHhamsS";
		
		/**
		 * The year pattern character. The current value is "y"
		 */
		public static const YEAR_FIELD : String = "y";
		
		/**
		 * The month pattern character. The current value is "M"
		 */
		public static const MONTH_FIELD : String = "M";
		
		/**
		 * The date or day of the month pattern character. The current value is "d"
		 */
		public static const DATE_FIELD : String = "d";
		
		/**
		 * The day of the week pattern character. The current value is "E"
		 */
		public static const DAY_OF_WEEK_FIELD : String = "E";
		
		/**
		 * The 24 hour pattern character. The current value is "H"
		 */
		public static const HOUR_OF_DAY_FIELD : String = "H";
		
		/**
		 * The minute pattern character. The current value is "m"
		 */
		public static const MINUTE_FIELD : String = "m";
		
		/**
		 * The second pattern character. The current value is "s"
		 */
		public static const SECOND_FIELD : String = "s";
		
		/**
		 * The millisecond pattern character. The current value is "S"
		 */
		public static const MILLISECOND_FIELD : String = "S";
		
		/**
		 * The 12 hour pattern character. The current value is 'h'
		 */
		public static const HOUR_FIELD : String = "h";
		
		/**
		 * The am/pm pattern character. The current value is 'a'
		 */
		public static const AM_PM_FIELD : String = "a";
		
		/**
		 * The default format pattern. The current value is "MM/dd/yyyy". 
		 */
		public static const DEFAULT_FORMAT_PATTERN : String = "MM/dd/yyyy";
		
		/**
		 * Build a <code>DateFormatter</code> instance.
		 * If value is null <code>DEFAULT_FORMAT_PATTERN</code> is used.
		 * 
		 * @param pattern the formatting pattern
		 */
		public function DateFormatter(pattern : String = null)
		{
			setPattern(pattern);
		}
		
		/**
		 * Sets the formatting pattern. If pattern value is null <code>DEFAULT_FORMAT_PATTERN</code> is used.
		 * 
		 * @param pattern the formatting pattern. If value is null <code>DEFAULT_FORMAT_PATTERN</code> is used.
		 */
		public function setPattern(pattern : String) : void
		{
			_pattern = pattern || DEFAULT_FORMAT_PATTERN;
			compilePattern();
		}

		/**
		 * Returns the formatting pattern.
		 * 
		 * @return the formatting pattern
		 */
		public function getPattern() : String
		{
			return _pattern;
		}
		
		/**
		 * Formats the date input according to the format string pattern in use.
		 * 
		 * @param date Date to format.
		 * @return formatted date
		 */
		public function format(date : Date) : String
		{
			var result : String = "";
			var field : Field;
			for each(var object : Object in _compilatePattern)
			{
				if(object is String)
				{
					result += String(object);
				}
				else
				{
					field = Field(object);
					switch(field.value)
					{
						case YEAR_FIELD:
							if(field.len == 2)result += date.fullYear.toString().substr(2, 2);
							else if(field.len == 4)result += date.fullYear;
							break;
						case MONTH_FIELD:
							if(field.len == 4) result += getMonthWord(date.month);
							else if(field.len == 2) result += getValueWithZero(date.month + 1);
							else if(field.len == 1) result += (date.month + 1);
							break;
						case DATE_FIELD:
							if(field.len == 2) result += getValueWithZero(date.date);
							else if(field.len == 1) result += date.date;
							break;
						case DAY_OF_WEEK_FIELD:
							if(field.len == 4) result += getWeekDayWord(date.day);
							else if(field.len == 3) result += getQuickWeekDayWord(date.day);
							else if(field.len == 2) result += getValueWithZero(date.day);
							else if(field.len == 1) result += date.day;
							break;
						case HOUR_OF_DAY_FIELD:
							if(field.len == 2) result += getValueWithZero(date.hours);
							else if(field.len == 1) result += date.hours;
							break;
						case MINUTE_FIELD:
							if(field.len == 2) result += getValueWithZero(date.minutes);
							else if(field.len == 1) result += date.minutes;
							break;
						case SECOND_FIELD:
							if(field.len == 2) result += getValueWithZero(date.seconds);
							else if(field.len == 1) result += date.seconds;
							break;
						case MILLISECOND_FIELD:
							result += date.milliseconds;
							break;
						case HOUR_FIELD:
							if(field.len == 2) result += getValueWithZero(getHourFormat12(date.hours));
							else if(field.len == 1) result += getHourFormat12(date.hours);
							break;
						case AM_PM_FIELD:
							result += date.hours < 12 ? "AM" : "PM";
							break;
					}
				}
			}
			return result;
		}
		
		/**
		 * @private
		 */
		private function getValueWithZero(value : Number) : String
		{
			return value > 9 ? value.toString() : "0" + value;
		}
		
		/**
		 * @private
		 */
		private function compilePattern() : void
		{
			_compilatePattern = new Array();
			var patternLength : uint = _pattern.length;
			var currentChar : String = null;
			var currentString : String = null;
			var currentField : Field = null;
			
			for(var i : int = 0 ; i < patternLength ; i++)
			{
				currentChar = _pattern.charAt(i);
				if(PATTERN_CHARS.indexOf(currentChar) == -1)
				{
					if(currentField != null)
					{
						_compilatePattern.push(currentField);
						currentField = null;
					}
					if(currentString == null) currentString = "";
					currentString += currentChar;
				}
				else
				{
					if(currentString != null)
					{
						_compilatePattern.push(currentString);
						currentString = null;
					}
					if(currentField == null)
					{
						currentField = new Field(currentChar);
					}
					else
					{
						if(currentField.value == currentChar)
						{
							currentField.len++;
						}
						else
						{
							_compilatePattern.push(currentField);
							currentField = new Field(currentChar);
						}
					}
				}
			}
			if(currentField != null)_compilatePattern.push(currentField);
			else if(currentString != null)_compilatePattern.push(currentString);
		}
		
		/**
         * Converts numbers from 0 to 6 into the short name of the week day
         * 
         * @param day in integer format. Value between 0 and 6.
         * @return 
         * @throws 	<code>ArgumentError</code> - if <code>day</code> parameter is superior to 6.
         */
        private function getQuickWeekDayWord(day : uint) : String
        {
            return getWeekDayWord(day).substr(0, 3);
        }

        /**
         * Converts numbers from 0 to 6 into the name of the week day
         * 
         * @throws 	<code>ArgumentError</code> - if <code>day</code> parameter is superior to 6.
         */
        private function getWeekDayWord(day : uint) : String
        {
            switch(day)
            {
                case 0 :
                    return "Sunday";
                case 1 :
                    return "Monday";
                case 2 :
                    return "Tuesday";
                case 3 :
                    return "Wednesday";
                case 4 :
                    return "Thursday";
                case 5 :
                    return "Friday";
                case 6 :
                    return "Saturday";
                default:
                    throw new ArgumentError("day parameter must be an integer value between 0 and 6");
            }
        }

        /**
         * Converts numbers from 0 to 11 into the name of the month
         * 
         * @throws 	<code>ArgumentError</code> - if <code>month</code> parameter is superior to 11.
         */
        private function getMonthWord(month : uint) : String
        {
            switch(month)
            {
                case 0 :
                    return "January";
                case 1 :
                    return "February";
                case 2 :
                    return "March";
                case 3 :
                    return "April";
                case 4 :
                    return "May";
                case 5 :
                    return "June";
                case 6 :
                    return "July";
                case 7 :
                    return "August";
                case 8 :
                    return "September";
                case 9 :
                    return "October";
                case 10 :
                    return "November";
                case 11 :
                    return "December";
                default :
                    throw new ArgumentError("month parameter must be an integer value between 0 and 11");
            }
        }
        
        /**
         * Converts an hour with 24h format to 12h format.
         * 
         * @param hourFormat24 hour with 24h format.
         * @return hour with 12h format.
         * @throws 	<code>ArgumentError</code> - if <code>hourFormat24</code> parameter is superior to 23.
         */
        private function getHourFormat12(hourFormat24 : uint) : uint
        {
            if (hourFormat24 <= 11) return hourFormat24;
            else if ( hourFormat24 <= 21) return (hourFormat24 % 11) - 1;
            else if (hourFormat24 == 22) return 10;
            else if (hourFormat24 == 23) return 11;
            else throw new ArgumentError("hourFormat24 parameter must be an integer value between 0 and 23");
        }
	}
}

/**
 * @internal
 */
internal class Field
{
	public var value : String;
	public var len : uint;
	
	public function Field(value : String)
	{
		this.value = value;
		len = 1;
	}
}
