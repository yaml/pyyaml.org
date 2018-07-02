# : in the flow context

It's not clear what is the best solution:

 1. Forbid ':' for plain scalars in the flow context and use it to separate keys from values.
    his syntax is more Python-compatible. For instance, it allows

        {1:2,2:3,3:5,4:7,5:11,6:13,7:17,8:23}    # prime numbers
 2. Allow ':' for plain scalars in the flow context provided it's not followed by a whitespace.
    Require ': ' to separate keys from values.
    This will allow unquoted time values and URLs in the flow context. For instance,

        [12:45, http://pyyaml.org/]    # Time and URL

What do you think? '''Please leave an excerpt of your document which produced an error here,
in the wiki page.'''


presentation: {type: textarea_tag, params: rich=true tinymce_options=width:500 }

this is a problem for me, please observe:
{{{ 
found unexpected ':'
 in "<string>", line 3, column 14:
 url: http://localhost/
}}}


Here's another real-world example:

          dhcp: [
            {
              group: linux_i386X,
              mac: 99:19:b9:fa:37:99,
            },
          ]
I would definitely agree for the colon-space solution (it fixes these examples, but not, I suppose, every issue.)

Yet another example:

    found unexpected ':'
      in "<string>", line 1, column 11:
        urls: [ftp://ftp.cdrom.com/]
It would make sense to require ': ' when parsing a value - if you see a:b when parsing a value, you should treat that as the string "a:b". When parsing a key-value in a mapping, it should be possible to allow either url:http://pyyaml.org/ (no space) or url: http://pyyaml.org/ as you know from context that you're expecting a : to terminate a key. Of course, colons in keys are pathological and should not be tolerated ;-)

Solution #1 may be natural for Python but not for other languages. Since YAML should stay language-neutral solution #2 would meet much more expectations.
Example from Polyglot Maven:

    distributionManagement:
      site: { id: site, url: "http://www.apache.org" }
      repository: { id: releases, name: releases, url: "http://maven.sonatype.org/releases" }
      snapshotRepository: { id: snapshots, name: snapshots, url: "http://maven.sonatype.org/snapshots" }

Another example (from the Ruby world):

    Psych::SyntaxError: (<unknown>): couldn't parse YAML at line 0 column 10

and the source document:

    order: [ :year, :month, :day ]

Another real world example:

    {created_at: 2011-03-04T15:58:25Z}

Which was reported here[http://redmine.ruby-lang.org/issues/4479].
