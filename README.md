# History
Tracking & Graphing my Bash History

## Setup

### Bash History

I customized a few of my `.bashrc` configs to work better with this:

```
# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Sizes for the .bash_history file
HISTSIZE=5000
HISTFILESIZE=25000
```

### Cron job

To make things easier, I set up a cron job to automatically run the `save.sh` script periodically. An example of this cron entry can be found in the `crontab` file.

## Usage

- `status.sh` gives you the current number of unsaved lines in the current `~/.bash_history` file
- `save.sh` moves the `~/.bash_history` file into the `data/` directory with the current timestamp
- `analyze.rb` parses all of the saved files, lists your most popular commands, and spits out a `results.json` file
- `graph.r` visually displays the `results.json` file (including a bar plot of your top 10 commands and your usage of git over time - more coming soon!)

### Visualization Ideas

- Top ~10 Commands
- Total Commands per Week (over time)
- Each of Top 10 Commands per Week

## Results

Obviously, I'm not going to commit the `data/` directory with all of my bash history. However, here is a nice picture:

![results](./results.png)
