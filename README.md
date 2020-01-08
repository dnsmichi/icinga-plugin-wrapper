# Plugin Wrapper Script for Icinga

## About

Every now and then, this question comes up in the community channels.
While Linux/Unix admins usually know what wrapping command arguments means,
beginners might struggle with it.

The rationale for using a plugin wrapper script is to:

- Execute the original plugin with all arguments
- Modify the output, e.g. remove sensitive details or too long data
- Search in the output and override the exit status resulting in the host/service state in Icinga
- Change the exit state based on additional requirements
- Enrich the plugin with performance data to generate metrics for beautiful graphs

## Installation

Copy/Install the wrapper script to the `PluginDir` location defined in Icinga.
You can determine the path with `icinga2 variable get PluginDir`.

RHEL/CentOS/Fedora:

```
install -o root -g root -m755 plugin_wrapper.sh /usr/lib64/nagios/plugins/
```

SLES/OpenSUSE:

```
install -o root -g root -m755 plugin_wrapper.sh /usr/lib/nagios/plugins/
```

Debian/Ubuntu:

```
install -o root -g root -m755 plugin_wrapper.sh /usr/lib/nagios/plugins/
```

## Configuration

Icinga allows you to import existing CheckCommand into newly created ones.
In the example below the plugin call and all its parameters are left alone,
only the plugin wrapper script is put as first command line element.

```
object CheckCommand "wrap-disk" {
  import "disk"

  var disk_command = command

  command = [ PluginDir + "/plugin_wrapper.sh" ] + disk_command
}
```

In order to quickly test this e.g. on the local Icinga server, add
a new host object configuration.

```
object Host "wrapped-disk-host" {
  check_command = "wrap-disk"

  vars.disk_partitions = [ "/" ]
  vars.disk_warning = "90%"
}
```
