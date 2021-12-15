# Code Style Guideline
### Formatting
 - Code should be idented using 2 spaces.
 - Never create local copies of constant values, use the constant values directly.
 - Avoid creating functions that are specific to a single use scenario.
 - Avoid creating single use variables (e.g `int a = 2; abc(a);` write `abc(2);` instead).
 - Don't split lines when writing inline code documentation.

#### If, for, while
 - Always use brackets even when the code inside the condition only has one statement.
 - Curly brackets should always be on their own line.
 - No space between the if, for, while and the condition.
 ```dart
if(isWeekDay)
{
  print("Bike to work!");
}
else
{
  print("Go dancing or read a book!");
}

for(int i = 0; i < 10; i++)
{
  ...
}
 ```

### Functions / Classes
 - Curly brackets should always be on their own line, parameters should be separated by a comma and a single space.
 - Parameters of a function should always fit into a single line, never split arguments into multiple lines.
```dart
class LocaleManager extends LocalizationsDelegate<Locales>
{
  bool shouldReload(LocaleManager old)
  {
    return false;
  }

  void testAbc(int a, double b, {String c, double e, int f, int l})
  {
    ...
  }
}
```

### Function call
 - When calling functions parameters should be fitted into one line when possible.
 - If there are inline function place brackets on their own line. Only use `() =>` value if it fits in a single line.
 - For named parameters for 2 or more parameters use a new line for each named parameter.
 - Trailing commas after the last parameter are optional.
 - Avoid calling more than 3 chained methods.
 - Avoid splitting chained calls in lines.
```dart
Modal.alert(context, Locales.getValue(context, "success"), Locales.getValue(context, "emailPasswordRecover"));

this.emailField = new TextField
(
  decoration: new InputDecoration(border: InputBorder.none, hintText: Locales.getValue(context, "email")),
  controller: new TextEditingController()
);

Service.call(ServiceList.USER_DATA, null, [user.id, user.siteId], null, null, (data, response)
{
  ...
},
(err, response)
{
	...
});


Service.call(ServiceList.USER_DATA, null, [user.id, user.siteId], null, null, (data, response)
{
  ...
},
(err, response) => print(err));

save
(
  context,
  avatar: avatar,
  name: nameController,
  email: emailController,
  mobile: mobileController,
  notes: notesController,
  abc: () => sadasd
);
```

#### Widget trees
 - In this special case feel free to always expand the tree parameters.
 - Avoid getting the unnamed parameters on different lines.
 - Always place brackets on their own line.
 - Avoid cross line conditions (eg using x ? y : z operations across lines), use a if else instead.
 - Trailing commas after the last parameter are optional.



### Identifiers/Names
 - **UpperCamelCase** names capitalize the first letter of each word, including the first.
 - **lowerCamelCase** names capitalize the first letter of each word, except the first which is always lowercase, even if it’s an acronym.
 - **lowercase_with_underscores** use only lowercase letters, even for acronyms, and separate words with _.
 - **SCREAMING_CAPS** use only uppercase letters, even for acronyms, and separate words with _.
 - Avoid using big names, if a name if composed for more than 3 words simplify it.
 - Try to keep names in context but perceptible.
   - E.g. If key belong to module there is no need to call it ModuleKey, Key should be enough.

#### Files
 - For varibles and souce files use lowercase_with_underscores.
```dart
library peg_parser.source_scanner;

import 'file_system.dart';
import 'slider_menu.dart';
```

#### Classes, Types
 - Classes, enums, typedefs, and type parameters should capitalize the first letter of each word (including the first word), and use no separators.
```dart
class SliderMenu { ... }
class HttpRequest { ... }

typedef Predicate<T> = bool Function(T value);
```

#### Variables, Functions
 - Class members, top-level definitions, variables, parameters, and named parameters should capitalize the first letter of each word except the first word, and use no separators.
 - Don't use any prefix letters like `_thisIsAVariable` for example.
 - Data types should be always declared, dynamic should be used only when necessary and var should never be used.
 - Explicitly use the keyword new and `const`. Always use `const` when possible.
```
int testData;

static Client client = new Client();
```
 - Variable attribution should always be separated by space.
 - Multiple variables of the same type can be declared on the same line (up to 3 variables).

### Strings
 - String use the ' character.
```dart
String a = 'abc';
```

### Double
 - Always explicitly place the 0. on the value.
```dart
double a = 0.1;
```

#### Constants
 - In new code, use SCREAMING_CAPS for constant variables, including enum values.
```dart
static const String SERVER_API = "http://server:8081/";

enum ServiceContentType {NONE, JSON, FORM, MULTIPART_FORM}
```

### Ordering
#### Imports
 - Place 'dart:...' imports before other imports.
 - Place 'package:...' imports before relative imports.
 - Never use package imports for the project files.
 - Always place import using '.
 - Separate the type of imports (dart, package, project) with a line.
 ```dart
import 'dart:async';
import 'dart:html';

import 'package:bar/bar.dart';
import 'package:foo/foo.dart';

import 'util.dart';
 ```
