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
    import org.flexunit.asserts.assertFalse;
    import org.flexunit.asserts.assertTrue;
    import org.rozenn.layout.ILayout;
    import org.rozenn.layout.TraceLayout;
    /**
     * @author Alexis Couronne
     */
    public class TestRozenn
    {
    	[Before]
    	public function setUp() : void
    	{
    		Rozenn.unregisterAllLayouts();
    	}
    	
    	[Test]
    	public function testRegisterLayout() : void
    	{
    		var layout1 : ILayout = new TraceLayout();
    		var layout2 : ILayout = new TraceLayout();
    		
    		assertFalse(Rozenn.hasLayout(layout1));
    		assertFalse(Rozenn.hasLayout(layout2));
    		
    		Rozenn.registerLayout(layout1);
    		Rozenn.registerLayout(layout2);
    		
    		assertTrue(Rozenn.hasLayout(layout1));
    		assertTrue(Rozenn.hasLayout(layout2));
    	}
    	
    	[Test]
    	public function testUnregisterLayout() : void
    	{
    		var layout1 : ILayout = new TraceLayout();
    		var layout2 : ILayout = new TraceLayout();
    		
    		assertFalse(Rozenn.hasLayout(layout1));
    		assertFalse(Rozenn.hasLayout(layout2));
    		
    		Rozenn.registerLayout(layout1);
    		Rozenn.registerLayout(layout2);
    		
    		Rozenn.unregisterLayout(layout1);
    		
    		assertFalse(Rozenn.hasLayout(layout1));
    		assertTrue(Rozenn.hasLayout(layout2));
    	}
    }
}
