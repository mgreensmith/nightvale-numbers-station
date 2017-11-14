
# Night Vale Numbers Station

A streaming radio server playing a [Night Vale-esque numbers station](http://nightvale.wikia.com/wiki/WZZZ).


## Serving Audio

Launch the server via:

```
docker-compose up
```

Icecast server will be streaming on host port `8000` with a single stream at `/nightvale.mp3`.

Ezstream source client will dynamically generate an mp3 playlist and stream it to the Icecast server.

The Icecast admin UI is available at `http://localhost:8000`. Admin credentials are `admin/nightvale`.


## Listening

#### Web Client

A small webserver is deployed automatically with the audio server, and is serving from `http://localhost:8080`. It's serving the contents of the `./client` directory, which includes a simple HTML-based web client pointing at the local stream.

#### Other Clients

Connect to Icecast from a local client (e.g. VLC) at `http://localhost:8000/nightvale.mp3` to hear the stream.


## Development Notes

#### Text-to-speech

I tried two different ways to generate the `mp3` files of spoken numbers in the `./data` directory.

`generate_numbers_docker.sh` uses `espeak` to generate audio and `sox` to encode to `mp3`, performed in a docker container.

`generate_numbers_mac.sh` uses OSX's `say` to generate the audio and `lame` to encode to `mp3`, performed on the host. Requires `lame` package from homebrew.

See comments in the scripts for more info.

#### Playlist generation

The `ezstream` source client for Icecast is responsible for generating an `mp3` stream and sending it to the Icecast server.

I'm using the [Playlist Program](https://www.mankier.com/1/ezstream#Scripting-Playlist_Programs) feature of `ezstream` to generate a pseudorandom mix of the source `mp3` files, via the `./ezstream/next_playlist_item.sh` script. See comments in the script for more info.

#### Audio Files

Helpful tools:

`afplay` to play an audio file from the command line. (OSX)

`afinfo` to inspect an audio file and determinte bitrate, sample rate, channels, etc. (OSX)

#### Chime sound

I found it on the internet. Had to change the channel count and sample rate to match the other `mp3` files or the stream clients would break/stop playing when the chime appeared in the stream.

```
~/src/me/nightvale/data $ docker run -it --rm -v $(pwd):/data ozzyjohnson/tts /bin/bash
root@45bde6699aa3:/data# sox chimeraw.mp3 -r 16000 -c 1 chime.mp3
```

Also had to remove ID3 tags from the chime file:

```
brew install eyed3
eyeD3 --remove-all chime.mp3
```

#### TODO

- Add high-cut and low-cut filters to make the audio sound like an AM radio station
- Add [background static](http://linguistics.berkeley.edu/plab/guestwiki/index.php?title=Sox_in_phonetic_research#Add_noise_to_an_audio_file)
- Add a very rare playlist item where the announcer breaks character to give an ominous warning or emotional breakdown, and is cut off abruptly, followed by extended silence
- Find a better chime
