superlocate
===========

Superlocate is a program that helps browsing filesystems in the CLI. It uses [GNOME Tracker](https://wiki.gnome.org/Projects/Tracker) as backend to search your filesystem for files that match the pattern, and then creates a symlink to each of those results. Tracker searches in the contents, paths, and metadata of files. This means that the user no longer has to browse the labyrinth that makes up the filesystem with its hierarchical structure, but can instead access their files simply by recalling the filename, the directory it's in, or a couple of words that appear inside the document. Don't spend time looking for your files -- let your files come to you!

### Installation
```
sudo pacman -S tracker
git clone https://github.com/Antithesisx/superlocate.git
cd superlocate
sudo cp sl{,a} /usr/local/bin/
sudo chmod +x /usr/local/bin/sl{,a}
```

Then run `tracker-preferences` to configure which directories you want to index. Finally run `tracker-control -s` to initialize the indexing process. It may take a while before this finishes.

### Usage
##### Step 1
`sl some arguments` will use tracker-search to look for files that match "some arguments". This will search inside all user-specified directories (see `tracker-preferences`). It will then output a list of paths that matched the pattern.

##### Step 2
You can pipe the results to `grep` or another program to further refine your results.

##### Step 3
Finally, when you're happy with the result, you can pipe it to `sla` (which stands for superlocate-accept) to create the symlinks. The basenames of those files or directories are used as the names. To avoid confusion, two ls commands are run automatically. The first one shows what links to what, one result per line (ls -l). The other one is a concise output that sorts the files and directories by order of last modification date.

### Examples
```
 % sl psychic wars
/home/user/Music/Blue Öyster Cult/1981 - Fire Of Unknown Origin/03. Veteran Of Psychic Wars.flac
/home/user/Music/Tarot/Crows Fly Black/11-Veteran Of Psychic Wars (Bonus TracK).mp3
/home/user/books/[Plato]_The_Republic_(Webster's_Thesaurus_Edition)(Bookos.org).pdf
```

The Blue Oyster Cult song is what we were looking for. Tarot has covered that song, so that appears as well, and it looks like both the words "psychic" and "wars" appear inside Plato's republic. Since these are just three files, this does not create clutter and we can accept the results.

```
 % sl psychic wars | sla
lrwxrwxrwx 1 user users 160 Apr  3 22:07 03. Veteran Of Psychic Wars.flac -> /home/user/Music/Blue Öyster Cult/1981 - Fire Of Unknown Origin/03. Veteran Of Psychic Wars.flac
lrwxrwxrwx 1 user users 151 Apr  3 22:07 11-Veteran Of Psychic Wars (Bonus TracK).mp3 -> /home/user/Music/Tarot/[2006] Crows Fly Black/11-Veteran Of Psychic Wars (Bonus TracK).mp3
lrwxrwxrwx 1 user users 114 Apr  3 22:07 [Plato]_The_Republic_(Webster's_Thesaurus_Edition)(Bookos.org).pdf -> /home/user/books/[Plato]_The_Republic_(Webster's_Thesaurus_Edition)(Bookos.org).pdf


[Plato]_The_Republic_(Webster's_Thesaurus_Edition)(Bookos.org).pdf  11-Veteran Of Psychic Wars (Bonus TracK).mp3
03. Veteran Of Psychic Wars.flac
```
This probably doesn't look very readable to you, but keep in mind that the real output is colourized. The basenames even have a different colour than the paths, which is very helpful.

Now that the symlinks are created, I can just run `mplayer 03.\ Veteran\ Of\ Psychic\ Wars.flac` to play the song I wanted to hear.

But all the same, there were some 500 results and I only needed one out of them. I don't want to symlink to all those results, but only to the Blue Oyster Cult song. No problem: before accepting the results, I filter by "Cult".

```
 % sl psychic wars
/home/user/Music/Blue Öyster Cult/1981 - Fire Of Unknown Origin/03. Veteran Of Psychic Wars.flac
/home/user/Music/Tarot/Crows Fly Black/11-Veteran Of Psychic Wars (Bonus TracK).mp3
/home/user/books/[Plato]_The_Republic_(Webster's_Thesaurus_Edition)(Bookos.org).pdf
% !! | grep -i cult
/home/user/Music/Blue Öyster Cult/1981 - Fire Of Unknown Origin/03. Veteran Of Psychic Wars.flac
% !! | sla
lrwxrwxrwx 1 user users 160 Apr  3 22:07 03. Veteran Of Psychic Wars.flac -> /home/user/Music/Blue Öyster Cult/1981 - Fire Of Unknown Origin/03. Veteran Of Psychic Wars.flac


03. Veteran Of Psychic Wars.flac
```

### FAQ
Q: Why the heck would I want to clutter my working directory with all those files?!
A: Use [sc](https://github.com/Antithesisx/sc) to start in a clean directory, then create the symlinks there.


