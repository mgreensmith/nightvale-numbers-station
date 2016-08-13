
# Night Vale Numbers Station

A streaming radio server playing a Night Vale-esque numbers station.


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

Serve the `./client` directory with your web server of choice and navigate to the index page.

#### Other Clients

Connect to Icecast from a local client (e.g. VLC) at `http://localhost:8000/nightvale.mp3` to hear the stream.


## Development Notes

#### Text-to-speech

I used `espeak` to generate the `mp3` files of spoken numbers in the `./data` directory.
To recreate the files, run `./generate_numbers.sh`. See comments in the script for more info.

#### Playlist generation

The `ezstream` source client for Icecast is responsible for generating an `mp3` stream and sending it to the Icecast server.

I'm using the [Playlist Program](https://www.mankier.com/1/ezstream#Scripting-Playlist_Programs) feature of `ezstream` to generate a pseudorandom mix of the source `mp3` files, via the `./ezstream/next_playlist_item.sh` script. See comments in the script for more info.

#### Audio Files

Helpful tools:

`afplay` to play an audio file from the command line.

`afinfo` to inspect an audio file and determinte bitrate, sample rate, channels, etc.

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
