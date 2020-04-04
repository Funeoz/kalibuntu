![GitHub repo size](https://img.shields.io/github/repo-size/funeoz/kalibuntu) &nbsp; ![GitHub](https://img.shields.io/github/license/funeoz/kalibuntu)

# Kalibuntu

![Imgur](https://i.imgur.com/U4jWYBg.gif)

Kalibuntu is a set of bash scripts to facilitate the process of installing Kali tools on Ubuntu
without using Kali's repositories to prevent system breakages.

Other distributions aren't supported because some packages are taken from Ubuntu repositories.

## Installation

Use ```git``` to get a copy of the project.

```bash
git clone https://github.com/Funeoz/kalibuntu.git 
```

Then give executable rights to all the shell scripts in the folder.

```bash
cd kalibuntu
find . -type f -iname "*.sh" -exec chmod +x {} \;
```

Run ```first_run.sh``` to install needed tools for Kalibuntu (as sudo):

```bash
sudo ./first_run.sh
```

## Usage

Run as root ```kalibuntu.sh```

```bash
sudo ./kalibuntu.sh
```

## Tools supported

See the [wiki for supported tools]().

## To-do

- [ ] support positional parameters for faster tool management (eg: ```./kalibuntu.sh install metasploit```)

- [ ] better log system

- [ ] remove underscores in categories array in kalibuntu.sh

## Contributing 

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
Please make sure to update tests as appropriate.

If you want to add a new tool, please refer to [this page of the wiki]().

## License

The project is under [GPLv3 license](https://github.com/Funeoz/kalibuntu/blob/master/LICENSE).

