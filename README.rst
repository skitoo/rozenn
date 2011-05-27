=====
Eozen
=====
Rozenn is a logging system strongly inspired by the famous `Log4J <http://logging.apache.org/log4j/1.2/>`_ library. Like the latter, Rozenn offers a highly configurable, either at the inputs of records that the destination of the latter.

Logger
======
The logger is the basic entity of the system logger. He is represented by the class **org.rozenn.Logger**.

::
   package
   {
      import org.rozenn.Logger;
    
      public class MyClass
      {
         private static var logger : Logger = Logger.getLogger(MyClass);
      }
   }
   
As you can see the declaration of a logger is very simple. It is done by the static method **Logger.getLogger**. This one take parent class name as parameter. You can give a different name but it is preferable to use the class to be used by the system of hierarchy and configuration.

The logging levels
==================
Just as Log4J, Rozenn has a notion of logging level. **org.rozenn.Level** class lets you define the importance of the message to log. During setup, you can specify filters for each logger. Thus, the message will be logged only if the level of your message is greater than or equal to the filter associated with the same login.

Rozenn offers 5 levels of logging:
   * **DEBUG** – Used to debug the application
   * **INFO** – Used to inform the user that application runs correctly
   * **WARN** – This level designates potentially harmful situations.
   * **ERROR** – Indicates that an error has occurred. Application is not stopped.
   * **FATAL** – Indicates a very serious error that occurred. Application can be stopped.
   
Two other logging levels exist in Rozenn. However they are only used when configuring the system:
   * **OFF** – Indicates that no message is logged.
   * **ALL** – Indicates that all messages are logged.

Of course, all these levels are offered basic Rozenn, but nothing prevents you from creating your own.

Logging a message
=================
To log a message several methods of the Logger available to you:

::
   logger.log(Level.DEBUG, "debug message");
 
   // the same with debug method
   logger.debug("debug message");
   

Of course these two methods are applicable for the other 4 levels: **INFO**, **WARN**, **ERROR** and **FATAL**.
   
You can specify an object **IFormatter** for a particular message. We'll see what the formatters in the rest of this documentation.
   

