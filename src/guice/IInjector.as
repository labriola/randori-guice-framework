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
package guice {
import guice.binding.IBinding;
import guice.reflection.TypeDefinition;
import guice.resolver.CircularDependencyMap;

public interface IInjector {
	function getInstance(dependency:Class):Object;

	function getInstanceByDefinition(dependencyTypeDefinition:TypeDefinition):*;

	function getBinding(typeDefinition:TypeDefinition):IBinding;

	function buildClass(typeDefinition:TypeDefinition, circularDependencyMap:CircularDependencyMap):*;
}
}