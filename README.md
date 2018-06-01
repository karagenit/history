# History
Tracking & Graphing my Bash History

## Setup

### Bash History

I customized a few of my `.bashrc` configs to work better with this:

```
# Don't store lines starting with space in the history.
HISTCONTROL=ignorespace

# Append to the history file, don't overwrite it.
shopt -s histappend

# Sizes for the .bash_history file.
HISTSIZE=5000
HISTFILESIZE=25000
```

### Cron job

To make things easier, I set up a cron job to automatically run the `save.sh` script periodically (in my case, once every other hour). The crontab entry looks like:

```
0 * * * * /path/to/directory/save.sh
```

> **NOTE:** You must add the crontab entry to *your user's* crontab (such as by running `crontab -e`), as the save script relies on `$HOME` being set to your home directory.

## Usage

- `status.sh` gives you the current number of unsaved lines in the current `~/.bash_history` file
- `save.sh` moves the `~/.bash_history` file into the `data/` directory with the current timestamp
- `analyze.rb` parses all of the saved files, lists your most popular commands, and spits out the JSON files containing the results
- `graph.r` visually displays the JSON files

## Results

Obviously, I'm not going to commit the `data/` directory with all of my bash history. However, here is a couple nice pictures:

![Totals](output/totals.png)
![Git by Date](output/git.png)
