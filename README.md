java-shell-utils
================

Add a bunch of shell utilities that deal with Java jars,
and finding classes.

unpack.sh
---------

Unpacks a given ear/war file.

### Usage

```
unpack.sh /path/to/a/file.war
```

Creates a folder in the current directory that contains the
contents of the archive.

pack.sh
-------

Packs a folder as an ear or war file.

### Usage

```
pack.sh /path/to/a/folder war
```

Creates an archive with the given extension name.

For example the previous command would have created an archive
named `folder.war` in the current folder.

has-class.sh
------------

Finds if jars under the current folder contain specific
classes, resources or packages.

### Usage

```
has-class.sh org.apache.Test [-m] [-p]
```

`-m` displays the matches inside the jar files.

`-p` assume packages names, so don't append a `.class` extension

