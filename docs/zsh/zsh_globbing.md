# Zsh Globbing 

UNSORTED/MISC examples
       Hint: A list of valid glob Qualifiers can be found in zshexpn(1). See “man 1 zshexpn | less -p” Qualifiers for details.

           # Get the names of all files that *don't* match a pattern *anywhere* on the
           # file (and without ‘‘-L'' because its GNUish)
             $ print -rl -- *(.^e{'grep -q pattern $REPLY'})
             # or
             $ : *(.e{'grep -q pattern $REPLY || print -r -- $REPLY'})

           # random numbers
             $ echo $[${RANDOM}%1000]     # random between 0-999
             $ echo $[${RANDOM}%11+10]    # random between 10-20
             $ echo ${(l:3::0:)${RANDOM}} # N digits long (3 digits)

           # reverse a word
             $ echo "${(j::)${(@Oa)${(s::):-hello}}}"

           # Show newest directory
             $ ls -ld *(/om[1])

           # random array element
             $ FILES=( .../files/* )
             $ feh $FILES[$RANDOM%$#FILES+1]

           # cat first line in all files in this dir
             $ for file (*(ND-.)) IFS= read -re < $file

           # test if a parameter is numeric
             $ if [[ $1 == <-> ]] ; then
                    echo numeric
               else
                    echo non-numeric
               fi

           # Show me all the .c files for which there doesn't exist a .o file.
             $ print *.c(e_'[[ ! -e $REPLY:r.o ]]'_)

           # All files in /var/ that are not owned by root
             $ ls -ld /var/*(^u:root)

# All files for which the owner hat read and execute permissions
             $ echo *(f:u+rx:)

           # The same, but also others don't have execute permissions
             $ echo *(f:u+rx,o-x:)

           # brace expansion - example
             $ X=(A B C)
             $ Y=(+ -)
             $ print -r -- $^X.$^Y
             A.+ A.- B.+ B.- C.+ C.-

           # Fetch the newest file containing the string 'fgractg*.log' in the
           # filename and contains the string 'ORA-' in it
             $ file=(fgractg*.log(Nm0om[1]))
             $ (($#file)) && grep -l ORA- $file
             # without Zsh
             $ files=$( find . -name . -o -prune -name 'fgractg*>log' -mtime 0 -print )
             > if [ -n "$files" ]; then
             >    IFS='
             > '
             > set -f
             > file=$(ls -td $files | head -1)
             > grep -l ORA- "$file"
             > fi

           # keep specified number of child processes running until entire task finished
             $ zsh -c 'sleep 1 & sleep 3 & sleep 2& print -rl -- $jobtexts'

           # Remove zero length and .bak files in a directory
             $ rm -i *(.L0) *.bak(.)

           # print out files that don't have extensions
             $ printf '%s\n' ^?*.*
             $ printf '%s\n' ^?*.[^.]*(D)
             $ ls -d -- ^?*.*(D)

           # Finding files which does not contain a specific string
             $ print -rl file* | comm -2 -3 - <(grep -l string file*)'
             $ for f (file*(N)) grep -q string $f || print -r $f'

           # Show/Check whether a option is set or not. It works both with $options as
           # with $builtins
             $ echo $options[correct]
             off
             $ $options[zle]
             on

           # Count the number of directories on the stack
             $ print $((${${(z)${(f)"$(dirs -v)"}[-1]}[1]} + 1)) # or
             $ dirs -v | awk '{n=$1}END{print n+1}'

 # Matching all files which do not have a dot in filename
             $ ls *~*.*(.)

           # Show only the ip-address from ‘‘ifconfig device''
             # ifconfig from net-tools (Linux)
             $ print ${${$(LC_ALL=C /sbin/ifconfig eth0)[7]}:gs/addr://}
             # ifconfig from 4.2BSD {Free,Net,Open}BSD
             $ print ${$(/sbin/ifconfig tun0)[6]}

           # Ping all the IP addresses in a couple of class C's or all hosts
           # into /etc/hosts
             $ for i in {1..254}; do ping -c 1 192.168.13.$i; done
             or
             $ I=1
             $ while ( [[ $I -le 255 ]] ) ; do ping -1 2 150.150.150.$I; let I++; done
             or
             $ for i in $(sed 's/#.*//' > /etc/hosts | awk '{print $2}')
             : do
             :    echo "Trying $i ... "
             :    ping -c 1 $i ;
             :    echo '============================='
             : done

           # load all available modules at startup
             $ typeset -U m
             $ m=()
             $ for md ($module_path) m=($m $md/**/*(*e:'REPLY=${REPLY#$md/}'::r))
             $ zmodload -i $m

           # Rename all files within a directory such that their names get a numeral
           # prefix in the default sort order.
             $ i=1; for j in *; do mv $j $i.$j; ((i++)); done
             $ i=1; for f in *; do mv $f $(echo $i | \
               awk '{ printf("%03d", $0)}').$f; ((i++)); done
             $ integer i=0; for f in *; do mv $f $[i+=1].$f; done

           # Find (and print) all symbolic links without a target within the current
           # dirtree.
             $ $ file **/*(D@) | fgrep broken
             $ for i in **/*(D@); [[ -f $i || -d $i ]] || echo $i
             $ echo **/*(@-^./=%p)
             $ print -l **/*(-@)

           # List all plain files that do not have extensions listed in ‘fignore'
             $ ls **/*~*(${~${(j/|/)fignore}})(.)
             # see above, but now omit executables
             $ ls **/*~*(${~${(j/|/)fignore}})(.^*)


# Print out files that don't have extensions (require *setopt extendedglob*
           # and *setopt dotglob*)
             $ printf '%s\n' ^?*.*

           # List files in reverse order sorted by name
             $ print -rl -- *(On)
             or
             $ print -rl -- *(^on)

           # Synonymic to ‘‘ps ax | awk '{print $1}'''
             $ print -l /proc/*/cwd(:h:t:s/self//)

           # Get the PID of a process (without ‘‘ps'', ‘‘sed'', ‘‘pgrep'', ..
           # (under Linux)
             $ pid2 () {
             >   local i
             >   for i in /proc/<->/stat
             > do
             >   [[ "$(< $i)" = *\((${(j:|:)~@})\)* ]] && echo $i:h:t
             > done
             > }

           # for X in 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y'; do ...
             $ for (( i = 36#n; i <= 36#y; i++ )); do
             >   print ${$(([##36]i)):l}
             > done
           # or in combination with ‘‘dc''
             $ print {$((##n))..$((##y))}P\ 10P | dc
           # or with ‘‘eval''
             $ eval print '${$(([##36]'{$((36#n))..$((36#y))}')):l}'

           # foreach in one line of shell
             $ for f (*) print -r -- $f

           # copy a directory recursively without data/files
             $ dirs=(**/*(/))
             $ cd -- $dest_root
             $ mkdir -p -- $dirs
           # or without zsh
             $ find . -type d -exec env d="$dest_root" \
               sh -c ' exec mkdir -p -- "$d/$1"' '{}' '{}' \;

           # If ‘foo=23'', then print with 10 digit with leading '0'.
             $ foo=23
             $ print ${(r:10::0:)foo}

           # find the name of all the files in their home directory that have
           # 20 or more characters in their file names
             print -rl $HOME/${(l:20::?:)~:-}*

# Save arrays
             $ print -r -- ${(qq)m} > $nameoffile      # save it
             $ eval "m=($(cat -- $nameoffile)"            # or use
             $ m=("${(@Q)${(z)"$(cat -- $nameoffile)"}}") # to restore it

           # get a "ls -l" on all the files in the tree that are younger than a
           # specified age (e.g "ls -l" all the files in the tree that where
           # modified in the last 2 days)
             $ ls -tld **/*(m-2)
           # This will give you a listing 1 file perl line (not à la ls -R).
           # Think of an easy way to have a "ls -R" style output with
           # only files newer than 2 day old.
             $ for d (. ./**/*(/)) {
             >   print -r -- $'\n'${d}:
             >   cd $d && {
             >       l=(*(Nm-2))
             >       (($#l)) && ls -ltd -- $l
             >       cd ~-
             >   }
             > }
           # If you also want directories to be included even if their mtime
           # is more than 2 days old:
             $ for d (. ./**/*(/)) {
             >   print -r -- $'\n'${d}:
             >   cd $d && {
             >      l=(*(N/,m-2))
             >      (($#l)) && ls -ltd -- $l
             >      cd ~-
             >   }
             > }
           # And if you want only the directories with mtime < 2 days to be listed:
             $ for d (. ./**/*(N/m-2)) {
             >   print -r -- $'\n'${d}:
             >   cd $d && {
             >      l=(*(Nm-2))
             >      (($#l)) && ls -ltd -- $l
             >      cd ~-
             >   }
             > }

           # print 42 ‘‘-''
             $ echo ${(l:42::-:)}
           # or use ‘‘$COLUMS''
             $ echo ${(l:$COLUMNS::-:)}
           # and now with colors (require autoload colors ;colors)
             $ echo "$bg[red]$fg[black]${(l:42::-:)}"

           # Redirect STDERR to a command like xless without redirecting STDOUT as well.
             $ foo 2>>(xless)
           # but this executes the command asynchronously. To do it synchronously:
             $ { { foo 1>&3 } 2>&1 | xless } 3>&1

# Rename all MP3-Files from name with spaces.mp3 to Name With Spaces.mp3
             $ for i in *.mp3; do
             >     mv $i ${${(C)i}:s/Mp3/mp3/}
             > done

           # Match file names containing only digits and ending with .xml (require
           # *setopt kshglob*)
             $ ls -l [0-9]##.xml
             $ ls -l <0->.xml

           # Remove all "non txt" files
             $ rm ./^*.txt

           # Move 200 files from a directory into another
             $ mv -- *([1,200]) /another/Dir

           # Convert images (foo.gif => foo.png):
             $ for i in **/*.gif; convert $i $i:r.png

           # convert a collection of mp3 files to wave or cdr,
           # e.g. file.wav -> file.mp3)
             $ for i (./*.mp3){mpg321 --w - $i > ${i:r}.wav}

           # Download with LaTeX2HTML  created Files (for example the ZSH-Guide):
             $ for f in https://zsh.sourceforge.io/Guide/zshguide{,{01..08}}.html; do
             >     lynx -source $f >${f:t}
             > done

           # Move all files in dir1 and dir2 that have line counts greater than 10 to
           # another directory say "/more10"
             $ mv dir[12]/**/*.cr(-.e{'((‘wc -l < $REPLY‘ > 10))'}) /more10

           # Make with dpkg a master-list of everyfile that it has installed
             $ diff <(find / | sort) <(cat /var/lib/dpkg/info/*.list | sort)

           # Replace this fucking Escape-Sequences:
             $ autoload colors ; colors
             $ print "$bg[cyan]$fg[blue]You are a idiot" >> /dev/pts/3

           # Get ASCII value of a character
             $ char=N ; print $((#char))

           # Filename "Erweiterung"
           # Note: The (N) says to use the nullglob option for this particular
           # glob pattern.
             $ for i in *.o(N); do
             >     rm $i
             > done

           # Rename files; i. e. FOO to foo and bar to BAR
             $ for i in *(.); mv $i ${i:l} # ‘FOO' to ‘foo'
             $ for i in *(.); mv $i ${i:u} # ‘bar to ‘BAR'

# Show all suid-files in $PATH
             $ ls -latg ${(s.:.)PATH} | grep '^...s'
           # or more complex ;)
             $ print -l ${^path}/*(Ns,S)
           # or show only executables with a user given pattern
             $ print -l ${^path}/*vim*(*N)

           # gzip files when containing a certain string
             $ gzip ${(ps:\0:)"$(grep -lZ foobar ./*.txt(.))"}

           # A small  one-liner, that reads from stdin and prints to stdout the first
           # unique line i. e. does not print lines that have been printed before
           # (this is similar to the unique command, but unique can only handle
           # adjacent lines).
             $ IFS=$'\n\n'; print -rl -- ${(Oau)${(Oa)$(cat file;echo .)[1,-2]}}

           # Lists every executable in PATH
             $ print -l ${^path}/*(-*N)

           # Match all .c files in all subdirectories, _except_ any SCCS subdirectories?
             $ ls **/*.c~(*/)#SCCS/*

           # List all ‘README' - files case-insensitive with max. one typo
             $ ls **/*(#ia2)readme

           # case insensitive checking for variables
             $ if [[ $OSTYPE == (#i)LINUX*(#I) ]]; then
             >    echo "Penguin on board."
             > else
             >    echo "Not a Linux."
             > fi

   (Recursive) Globbing - Examples
       A list of valid glob Qualifiers can be found in zshexpn(1). Note: **/ is equivalent to (*/)#! For example:

           $ print (*/)#zsh_us.ps
           zsh-4.2.3/Doc/zsh_us.ps
           $ print **/zsh_us.ps
           zsh-4.2.3/Doc/zsh_us.ps

           # Search for ‘README' in all Subdirectories
             $ ls -l **/README

           # find directories that contain both "index.php" and "index.html", or in
           # general, directories that contain more than one file matching "index.*"
             $ ls **/*(D/e:'[[ -e $REPLY/index.php && -e $REPLY/index.html ]]':)
             # or
             $ ls **/*(D/e:'l=($REPLY/index.*(N)); (( $#l >= 2 ))':)

           # Find command to search for directory name instead of basename
             $ print -rl /**/*~^*/path(|/*)
             # or - without Zsh
             $ find / | grep -e /path/ -e '/path$'

 # Print he path of the directories holding the ten biggest C regular files
           # in the current directory and subdirectories.
             $ print -rl -- **/*.c(D.OL[1,10]:h) | sort -u

           # Find files with size == 0 and send a mail
             $ files=(**/*(ND.L0m+0m-2))
             > (( $#files > 0 )) && print -rl -- $files | \
               mailx -s "empty files" foo@bar.tdl

           # recursive chmod
             $ chmod 700 **/(.) # Only files
             $ chmod 700 **/(/) # Only directories

           # print out all of the files in that directory in 2 columns
             $ print -rC2 -- ${1:[...]}/*(D:t)
           #            ^- number ob columns
           # or - if you feel concerned about special characters - use
             $ list=(${1:[...]}/*(ND:t))
             $ (($#list)) && print -rC2 -- ${(V)list}

           # Search all files in /home/*/*-mail/ with a setting ‘‘chmod -s'' flag
           # (recursive, include  dotfiles) remove the setgid/setuid flag and print
           # a message
             $ chmod -s /home/*/*-mail(DNs,S) /home/*/*-mail/**/*(DNs,S))
           # or with a small script
             $ for file (/home/*/*-mail(DNs,S) /home/*/*-mail/**/*(DNs,S)) {
             >    print -r -- $file
             >    chmod -s $file && print -r fixed $file
             > }
           # or use ‘‘zargs'' (require autoload zargs) prevent the arg list too
           # long error
             $ zargs /home/*/*-mail(DNs,S) /home/*/*-mail/**/*(DNs,S)) -- chmod -s

           # List files beginning at ‘foo23' upwards (foo23, foo24, foo25, ..)
             $ ls -l foo<23->

           # get all files that begin with the date strings from June 4 through
           # June 9 of 2004
             $ ls -l 200406{04..10}*(N)
           # or if they are of the form 200406XX (require ‘‘setopt extended_glob''
             $ ls -l 200306<4-10>.*

           # remove spaces from filenames
             $ for a in ./**/*\ *(Dod); do mv $a ${a:h}/${a:t:gs/ /_}; done

           # Show only all *.c and *.h - Files
             $ ls -l *.(c|h)

           # Show only all *.c - files and ignore ‘foo.c'
             $ ls *.c~foo.c

# show data to *really* binary format
             $ zsh -ec 'while {} {printf %.8x $n;repeat 8 \
             > {read -ku0 a printf \ %.8d $(([##2]#a))};print;((n+=8))}' < binary

           # Show only world-readable files
             $ ls -l *(R)

           # List files in the current directory are not writable by the owner
             $ print -l ~/*(ND.^w)

           # find and delete the files which are older than a given parameter
           # (seconds/minutes/hours)
             # deletes all regular file in /Dir that are older than 3 hours
              $ rm -f /Dir/**/*(.mh+3)
             # deletes all symlinks in /Dir that are older than 3 minutes
              $ rm -f /Dir/**/*(@mm+3)
             # deletes all non dirs in /Dir that are older than 30 seconds
              $ rm -f /Dir/**/*(ms+30^/)
             # deletes all folders, sub-folders and files older than one hour
              $ rm ./**/*(.Dmh+1,.DL0)
             # deletes all files more than 6 hours old
              $ rm -f **/*(mh+6)
             # removes all files but the ten newer ones (delete all but last 10
             # files in a directory)
              $ rm ./*(Om[1,-11])
            Note: If you get a arg list too long, you use the builtin rm. For
                  example:
              $ zmodload zsh/files ; rm -f **/*(mh+6)
             or use the zargs function:
              $ autoload zargs ; zargs **/*(mh+6) -- rm -f

           # A User's Guide to the Z-Shell /5.9: Filename Generation and Pattern
           # Matching find all files in all subdirectories, searching recursively,
           # which have a given name, case insensitive, are at least 50 KB large,
           # no more than a week old and owned by the root user, and allowing up
           # to a single error in the spelling of the name. In fact, the required
           # expression looks like this:
             $ ls **/(#ia1)name(LK+50mw-1u0)

           # Change the UID from 102 to 666
             $ chown 666 **/*(u102)

           # List all files which have not been updated since last 10 hours
             $ print -rl -- *(Dmh+10^/)

           # delete only the oldest file in a directory
             $ rm ./*filename*(Om[1])

           # Sort the output from ‘ls -l' by file size
             $ ls -fld *(OL)

           # find most recent file in a directory
             $ setopt dotglob ; print directory/**/*(om[1])

# Show only empty files which nor ‘group' or ‘world writable'
             $ ls *(L0f.go-w.)

           # Find - and list - the ten newest files in directories and subdirs.
           # (recursive)
             $ print -rl -- **/*(Dom[1,10])

           # Print only 5 lines by "ls" command (like ‘‘ls -laS | head -n 5'').
             $ ls -fl *(DOL[1,5])

           # Display the 5-10 last modified files.
             $ print -rl -- /path/to/dir/**/*(D.om[5,10])

           # Find all files without a valid owner.
             $ chmod someuser /**/*(D^u:${(j.:u:.)${(f)"$(</etc/passwd)"}%%:*}:)

           # Find all the empty directories in a tree.
             $ for f in ***/*(/l2); do foo=($f/*(N)); [[ -z $foo ]] && print $f; done
           # Note:Since Zsh 4.2.1 the glob qualifier F indicates a non-empty directory.
           # Hence *(F) indicates all subdirectories with entries, *(/^F) means all
           # subdirectories with no entries.
             $ ls -ld *(/^F)

           # Remove empty directories afterwards.
             $ rmdir ./**/*(/od) 2> /dev/null

           # Show only files which are owned by group ‘users'.
             $ ls -l *(G[users])
