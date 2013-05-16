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
package guice.resolver {
import guice.loader.SynchronousClassLoader;
import guice.reflection.TypeDefinition;

import randori.webkit.page.Window;

public class ProxiedDependencyResolver extends ClassResolver {

	private function createEmptyDefinition(qualifiedClassName:String):Object {
		var nextLevel:* = Window.window;
		var neededLevel:*;

		var path:Array = qualifiedClassName.split('.');

		for (var i:int = 0; i < path.length; i++) {
			neededLevel = nextLevel[path[i]];
			if (!neededLevel) {
				nextLevel[ path[i] ] = neededLevel = {};
			}
			nextLevel = neededLevel;
		}

		return neededLevel;
	}

	private function buildProxyObjectForDependency( qualifiedClassName:String ):void {
		var proxy:* = createEmptyDefinition( qualifiedClassName );

		//if we have a className, we already have this class, no need to make a proxy
		if ( !proxy.className ) {
			proxy.className = qualifiedClassName;
			proxy.isProxy = true;
		}
	}

	//TODO, unwind this. Inheritance is the wrong answer here, this needs to be refactored
	override protected function resolveClassDependencies(type:TypeDefinition):void {
		var classDependencies:Vector.<String> = type.getClassDependencies();

		for ( var i:int=0; i<classDependencies.length; i++) {
			buildProxyObjectForDependency( classDependencies[i] );
		}
	}

	public function ProxiedDependencyResolver( loader:SynchronousClassLoader ) {
		super( loader );
	}
}
}