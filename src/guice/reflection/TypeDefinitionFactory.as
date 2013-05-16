/***
 * Copyright 2013 LTN Consulting, Inc. /dba Digital Primates®
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 *
 * @author Michael Labriola <labriola@digitalprimates.net>
 */
package guice.reflection {
import randori.webkit.page.Window;

public class TypeDefinitionFactory {

	//TODO: Refactor all of me. This is Copied code... evil
	private function findDefinition(qualifiedClassName:String):Object {
		var nextLevel:* = Window.window;
		var failed:Boolean = false;

		var path:Array = qualifiedClassName.split('.');

		for (var i:int = 0; i < path.length; i++) {
			nextLevel = nextLevel[path[i]];
			if (!nextLevel) {
				failed = true;
				break;
			}
		}

		if (failed) {
			return null;
		}

		return nextLevel;
	}


	public function definitionFromReference( type:Class ):TypeDefinition {
		return new TypeDefinition( type );
	}

	public function definitionFromName( className:String ):TypeDefinition {
		var type:* = findDefinition( className );
		return definitionFromReference( type );
	}

	public function definitionFromProxy( proxy:TypeDefinition ):TypeDefinition {
		var type:* = findDefinition( proxy.getClassName() );
		return definitionFromReference( type );
	}

	public function TypeDefinitionFactory() {
	}
}
}