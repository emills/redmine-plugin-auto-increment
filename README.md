Redmine Plugin - Auto Increment
=============================

Auto Increment is a [Redmine plugin](http://www.redmine.org/projects/redmine/wiki/Plugins) which provides wiki macros for incrementing and decrementing a counter. By default the counter is incremented automatically with each macro call but can also be decremented or returned without modification.

The plugin is intended for use in wiki documents which include ordered lists (such as procedures) which are too large for the standard ordered list syntax (#).

## Installation

```
cd $REDMINE_ROOT/plugins
git clone https://github.com/emills/redmine-plugin-auto-increment.git auto_increment
```
Then restart Redmine to apply changes.

## Usage

The following macros are provided:
* `{{auto_increment}}` - Increments a number with the first call returning '1'.
* `{{auto_increment_alpha}}` - Increments an alpha string using standard Ruby incrementation ('a' -> 'b' ... 'z' -> 'aa') with the first call returning 'a'.

Each macro takes the following arguments:
* **variable_name** - The name of the variable to increment. Names are distinct between macros and when not specified the variable name 'DEFAULT' will be used.
* **operations** - The operation to perform before return a value. Defaults to '+' when not specified.
  * **+** : Increment the value
  * **-** : Decrement the value
  * **=** : Do not modify the value

Arugments can be specified in the following formats:
* *None*
* *(variable_name)*
* *(operations)*
* *(variable_name, operation)*

## Examples

*__Coming Soon...__*

## License

This plugin is available under the terms of the [GNU General Public License](http://www.gnu.org/licenses/gpl-2.0.html), version 2 or later.
