======
Rozenn
======

.. image:: http://farm3.static.flickr.com/2652/5776052009_7eb9387bf3_o.jpg
   :height: 81px
   :width: 334px
   :alt: Rozenn logo
   :align: center

Rozenn is a Flash/AS3 logging system strongly inspired by the famous `Log4J <http://logging.apache.org/log4j/1.2/>`_ library. Like the latter, Rozenn offers a highly configurable system, either at the inputs of records that the destination of the latter.

Installation
============
The best way to install Rozenn is by adding the provided SWC file to your project. But you can download source code and put it in your classpath.

Usage
=====

Logger
------
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
------------------
Just as Log4J, Rozenn has a notion of logging level. **org.rozenn.Level** class lets you define the importance of the message to log. During setup, you can specify filters for each logger. Thus, the message will be logged only if the level of your message is greater than or equal to the filter associated with the same login.

Rozenn offers 5 levels of logging:
   * **DEBUG** – Used to debug the application
   * **INFO** – Used to inform the user that application runs correctly
   * **WARN** – This level designates potentially harmful situations.
   * **ERROR** – Indicates that an error has occurred. Application is not stopped.
   * **FATAL** – Indicates that a very serious error has occurred. Application can be stopped.
   
Two other logging levels exist in Rozenn. However they are only used when configuring the system:
   * **OFF** – Indicates that no message is logged.
   * **ALL** – Indicates that all messages are logged.

Of course, all these levels are offered basic Rozenn, but nothing prevents you from creating your own.

Logging a message
-----------------
To log a message several methods of the Logger available to you:

::

      logger.log(Level.DEBUG, "debug message");
    
      // the same with debug method
      logger.debug("debug message");
   

Of course these two methods are applicable for the other 4 levels: **INFO**, **WARN**, **ERROR** and **FATAL**.
   
You can specify an object **IFormatter** for a particular message. We'll see what the formatters in the rest of this documentation.
   
Outputs system write log
------------------------
We have seen how to create messages with a level. Now let's see how to send different types of writing proposed by Rozenn. These outputs are represented by the interface **org.rozenn.layout.ILayout**.

Today, five implementations are provided with Rozenn:
   * **org.rozenn.layout.TraceLayout** – Messages are sent to the Flash **trace** method. 
   * **org.rozenn.layout.AirLoggerLayout** – Messages are sent to `AirLogger <http://code.google.com/p/airlogger/>`_ application  developped by `Cédric Néhémie <http://book.abe.free.fr/blog/>`_.
   * **org.rozenn.layout.FlashInspectorLayout** – Messages are sent to FlashInspector application  developped by `Pablo Constantini <http://www.luminicbox.com/>`_.
   * **org.rozenn.layout.FireBugLayout** – Messages are sent to the inevitable Firefox plugin `FireBug <http://getfirebug.com/>`_. Of course your SWF must be played with the browser, the messages appear in the module plugin "Console".
   * **org.rozenn.layout.SOSMaxLayout** - Messages are sent to `SOSMax <http://www.sos.powerflasher.com/>`_ 'Socket Output Server'.
   
Formatting messages
-------------------
Rozenn can format the logging messages. This action takes place before they are sent to a layout. The formatting of messages is done by classes implementing the interface **org.rozenn.formatter.IFormatter**. These objects are associated with the layouts.

Rozenn offers two formatters:
   * **org.rozenn.formatter.SimpleFormatter** – A formatter very simple: passes the message body to layout.
   * **org.rozenn.formatter.PatternFormatter** – This formatter is more advanced. Its constructor takes a pattern that will define the form taken by a message once sent to the layout.
   
Example for pattern **%L [%C] %M** :

::

      var logger : Logger = Logger.getLogger("root");
      logger.debug("Message A");
      logger.warn("Message B");
   
result :

::

      DEBUG [root] Message A
      WARN [root] Message B
   
Table summary tags:

+--------+-------------------------------------------------------------------------------------------------------------------------------------+
| Tag    | Result                                                                                                                              |
+========+=====================================================================================================================================+
| **%C** | The name of the sender of the message log.                                                                                          |
+--------+-------------------------------------------------------------------------------------------------------------------------------------+
| **%D** | The issue date of the message.                                                                                                      |
|        | This tag is a bit special because it accepts an option: **%D{dd/MM/yyyy – HH:mm:ss}**                                               |
|        | This option lets you specify as the date will be displayed. This option is analyzed by the class **org.rozenn.utils.DateFormatter** |
|        | I suggest you take a look at the documentation of the latter.                                                                       |
+--------+-------------------------------------------------------------------------------------------------------------------------------------+
| **%L** | The message level                                                                                                                   |
+--------+-------------------------------------------------------------------------------------------------------------------------------------+
| **%M** | The message body                                                                                                                    |
+--------+-------------------------------------------------------------------------------------------------------------------------------------+


Inheritance levels
------------------
Each Level Logger inherits from its parent unless that a level is explicitly specified.
Only "root" logger, defined by the system, has no parent. Which indicates that by default every logger inherit the root level.

Consider the following example:

.. image:: http://farm5.static.flickr.com/4134/4903514587_e8f5806609_o.jpg
   :height: 505px
   :width: 456px
   :alt: Schema inheritance Loggers
   :align: center

In this example we specify that the root level to **WARN**.

**com.scopart.utils** should have the default level **WARN** (**root** inheritance), but as for **org.skitools.mvc** you break the inheritance chain by specifying **FATAL** as standard. If **com.scopart.utils** one day have children, they will inherit the same level.

Now consider what happens if the logger "org.skitools" sends a message:
   * The message **DEBUG** and **INFO** will not be logged because they have a level below that is specified in **org.skitools** (**WARN**).
   * Messages **WARN**, **ERROR** and **FATAL** will be logged as they are greater than or equal to that specified in **org.skitools**.
   
Configuring the logging system
------------------------------
Here is a small example of Rozenn system configuration logging :

::

   package com.scopart
   {
      import org.rozenn.Level;
      import org.rozenn.Logger;
      import org.rozenn.Logging;
      import org.rozenn.formatter.PatternFormatter;
      import org.rozenn.layout.FirebugLayout;
      import org.rozenn.layout.TraceLayout;
    
      import flash.display.Sprite;
    
      public class MyClass extends Sprite
      {
         private static var logger : Logger = Logger.getLogger(MyClass);
    
         public function MyClass()
         {
            // Recording a TraceLayout in the system
            // It uses by default "org.rozenn.formatter.PatternFormatter" with the pattern "%L [%C] %M"
            Rozenn.registerLayout(new TraceLayout());
            
            // Recording a FirebugLayout in the system
            // It uses a PatternFormatter to format messages
            Rozenn.registerLayout(new FirebugLayout(new PatternFormatter("%L [%C] %M")));
    
            // Specifying a level for the logger
            logger.setLevel(Level.ERROR);
    
            // This message will not be logged as below ERROR specified in the Logger
            logger.debug("message 1"); 
    
            // The following two messages will be logged as greater than or equal to ERROR
            logger.error("message 2");
            logger.fatal("message 3");
         }
      }
   }
