package org.rozenn.formatter
{
    import flash.errors.IllegalOperationError;
    import flash.utils.Dictionary;
    import org.rozenn.formatter.converter.ClassConverter;
    import org.rozenn.formatter.converter.DateConverter;
    import org.rozenn.formatter.converter.IConverter;
    import org.rozenn.formatter.converter.LevelConverter;
    import org.rozenn.formatter.converter.LiteralConverter;
    import org.rozenn.formatter.converter.MessageConverter;



	/**
	 * The parse of pattern is delegated by <code>PatternFormatter</code> class to <code>PatternParser</code>.
	 * This class parse pattern and return a chained list of <code>IConverter</code>
	 *  
	 * @author Alexis Couronne
	 */
	public class PatternParser
	{
		/**
		 * @private
		 */
		private static var instance : PatternParser;

		/**
		 * @private
		 */
		private static const ESCAPE_CHAR : String = "%";

		/**
		 * @private
		 */
		private static const LITERAL_STATE : int = 0;

		/**
		 * @private
		 */
		private static const CONVERTER_STATE : int = 1;

		/**
		 * @private
		 */
		private var _rules : Dictionary;

		/**
		 * Returns the singleton instance of the <code>PatternParser</code>.
		 * 
		 * @return the singleton instance of the <code>PatternParser</code>
		 */
		public static function getInstance() : PatternParser
		{
			if(instance == null)instance = new PatternParser(new PrivateAccess());
			return instance;
		}

		/**
		 * Creates a new <code>PatternParser</code> instance. 
		 * 
		 * This constructor is locked. You cannot call the constructor directly.
		 * Please use <code>PatternParser.getInstance()</code> to retreive the singleton instance.
		 * 
		 * @param 	access	a lock for direct instanciation of the <code>PatternParser</code> class.
		 * @throws 	<code>IllegalOperationError</code> - if <code>access</code> parameter is null.
		 */
		public function PatternParser(access : PrivateAccess) 
		{
			if(access == null)throw new IllegalOperationError("PatternParser is a Singleton. You must use PatternParser.getInstance()");
		
			_rules = new Dictionary(true);
			_rules["C"] = ClassConverter;
			_rules["D"] = DateConverter;
			_rules["L"] = LevelConverter;
			_rules["M"] = MessageConverter;
		}

		/**
		 * Parse a format specifier and return a chained list of IConverter.
		 * 
		 * @param pattern pattern to parse.
		 * @return chained list of IConverter.
		 * @author Inspired by Log4J library.
		 */
		public function parse(pattern : String) : Vector.<IConverter>
		{
			var converters : Vector.<IConverter> = new Vector.<IConverter>();
			var i : int = 0;
			var lengthPattern : int = pattern.length;
			var char : String;
			var literal : String = "";
			var state : int = LITERAL_STATE;
			
			while(i < lengthPattern)
			{
				char = pattern.charAt(i++);
				
				switch(state)
				{
					case LITERAL_STATE:
						if(char == ESCAPE_CHAR)
						{
							if(pattern.charAt(i) == ESCAPE_CHAR)
							{
								literal += char;
								i++;
							}
							else
							{
								if(literal.length != 0)
								{
									converters.push(new LiteralConverter(literal));
								}
								literal = "" + char;
								state = CONVERTER_STATE;
							}
						}
						else
						{
							literal += char;
						}
						break;
					case CONVERTER_STATE:
						literal += char;
						
						// parse options
						var options : String = null;
						if(i < lengthPattern && pattern.charAt(i) == "{")
						{
							var end : int = pattern.indexOf("}");
							if(end != -1)
							{
								options = pattern.substring(i + 1, end);
								i = end + 1;
							}
						}
						
						if(_rules[char] != null)
						{
							var AClassConverter : Class = Class(_rules[char]);
							converters.push(new AClassConverter(options));
							literal = "";
						}
						else
						{
							if(literal.length > 0)
							{
								converters.push(new LiteralConverter(literal));
								literal = "";
							}
						}
						state = LITERAL_STATE;
						break;
				}
			}
			return converters;
		}
	}
}

internal class PrivateAccess
{
}
